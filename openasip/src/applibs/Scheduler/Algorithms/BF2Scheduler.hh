/*
    Copyright (c) 2002-2014 Tampere University.

    This file is part of TTA-Based Codesign Environment (TCE).

    Permission is hereby granted, free of charge, to any person obtaining a
    copy of this software and associated documentation files (the "Software"),
    to deal in the Software without restriction, including without limitation
    the rights to use, copy, modify, merge, publish, distribute, sublicense,
    and/or sell copies of the Software, and to permit persons to whom the
    Software is furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
    THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
    FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
    DEALINGS IN THE SOFTWARE.
 */

/**
 * @file BF2Scheduler.hh
 *
 * Declaration of BF2Scheduler class.
 *
 * Bypassing Bottom-up Breadth-First-Search Instruction Scheduler
 * (BubblefishScheduler)
 *
 * @author Heikki Kultala 2014-2020(heikki.kultala-no.spam-tuni.fi)
 * @note rating: red
 */

#ifndef TTA_BF2_SCHEDULER_HH
#define TTA_BF2_SCHEDULER_HH

#include "DDGPass.hh"

#include <map>

#include "DataDependenceGraph.hh"
#include "MachinePart.hh"

#include "LiveRangeData.hh"
#include "LoopAnalyzer.hh"

class ResourceManager;
class SimpleResourceManager;
class BUMoveNodeSelector;
class LLVMTCECmdLineOptions;
class RegisterRenamer;
class BFOptimization;
class MoveNodeDuplicator;
class BF2ScheduleFront;
class BFScheduleLoopBufferInit;

namespace TTAMachine {
    class Unit;
    class RegisterFile;
    class Port;
    class Bus;
    class FUPort;
    class HWOperation;
}

namespace TTAProgram {
    class Terminal;
    class MoveGuard;
}

class BF2Scheduler : public DDGPass {

public:
    BF2Scheduler(InterPassData& ipd, RegisterRenamer* renamer);
    BF2Scheduler(
        InterPassData& ipd, RegisterRenamer* renamer, bool killDeadResults);

    ~BF2Scheduler();

    virtual int handleDDG(
        DataDependenceGraph& ddg, SimpleResourceManager& rm,
        const TTAMachine::Machine& targetMachine, int minCycle = 0,
        bool testOnly = false);

    void scheduleDDG(
        DataDependenceGraph& ddg,
        SimpleResourceManager& rm,
        const TTAMachine::Machine& targetMachine);

    virtual std::string shortDescription() const override;

    virtual int handleLoopDDG(
        DataDependenceGraph&, SimpleResourceManager&,
        const TTAMachine::Machine&, int tripCount,
        SimpleResourceManager*, bool testOnly) override;

    DataDependenceGraph& ddg() { return *ddg_; }
    const DataDependenceGraph& ddg() const { return *ddg_; }
    DataDependenceGraph* prologDDG() { return prologDDG_; }
    SimpleResourceManager& rm() { return *rm_; }
    SimpleResourceManager* prologRM() { return prologRM_; }
    BUMoveNodeSelector& selector() { return *selector_; }
    MoveNodeDuplicator& duplicator() {
        assert(duplicator_!=NULL);
        return *duplicator_;
    }
    bool killDeadResults() const { return killDeadResults_; }

    void revertBBLiveRangeBookkeepingForDestination(MoveNode* mn);
    void revertBBLiveRangeBookkeepingForSource(MoveNode* mn);

    std::set<const TTAMachine::RegisterFile*,
             TTAMachine::MachinePart::Comparator>
    possibleTempRegRFs(const MoveNode& mn, bool tempRegAfter,
                       const TTAMachine::RegisterFile* forbiddenRF = nullptr);

    static bool isSourceUniversalReg(const MoveNode& mn);
    DataDependenceEdge* findBypassEdge(const MoveNode& mn);

    void nodeKilled(MoveNode& mn);
    void nodeResurrected(MoveNode& mn);
    void nodeAndCopyKilled(MoveNode& mn);

    const TTAMachine::Machine& targetMachine() const { return *targetMachine_; }

    // This is not yet used, but will be used soon.
    enum LoopSchedulingMode {
        // Old version
        NO_LOOP_SCHEDULER = 0,
    };

    enum PreLoopOperandEnum {
        NO_PORT=0,
        SHARED=1,
        NOT_SHARED=2,
        NO_LOOP_INVARIANT=3
    };

    /** Struct for return values */
    struct PreLoopShareInfo {
        PreLoopOperandEnum state_;
        MoveNode* sharedMN_;
        TTAMachine::FUPort* sharedPort_;
        PreLoopShareInfo(PreLoopOperandEnum state) : state_(state),
                                                     sharedMN_(NULL),
                                                     sharedPort_(NULL) {}
        PreLoopShareInfo(MoveNode& mn, TTAMachine::FUPort& port) :
            state_(SHARED),
            sharedMN_(&mn),
            sharedPort_(&port) {}
    };

    enum SchedulingDirection {
        EITHER=0,
        TOPDOWN=1,
        BOTTOMUP=2,
        EXACTCYCLE=3
    };

    bool isDeadResult(MoveNode& mn) const;
    TTAMachine::FUPort* isPreLoopSharedOperand(MoveNode& mn) const;

    struct SchedulingLimits {
        SchedulingDirection direction;
        int earliestCycle;
        int latestCycle;
        SchedulingLimits() : direction(BOTTOMUP), earliestCycle(0),
                             latestCycle(INT_MAX) {}
    };

    static bool isDestinationUniversalReg(const MoveNode& mn);

    typedef std::map<MoveNode*, MoveNode*, MoveNode::Comparator>
    MoveNodeMap;

    TTAMachine::Unit* getDstUnit(MoveNode& mn);
    bool isTrigger(const TTAMachine::Unit& unit, MoveNode& mn);

    bool hasUnscheduledSuccessors(MoveNode& mn) const;

    int tripCount() { return tripCount_; }

    int maximumAllowedCycle() const { return latestCycle_; }

    BF2ScheduleFront* currentFront() { return currentFront_; }

    TTAProgram::MoveGuard* jumpGuard();
    MoveNode* guardWriteNode() { return jumpGuardWrite_; }
    MoveNode* jumpNode() { return jumpNode_; }

    MoveNode* loopLimitNode() {
        return llResult_ == 0 ? NULL : llResult_->counterValueNode;
    }

    LoopAnalyzer::LoopAnalysisResult* getLoopAnalysis() {
        return llResult_;
    }

    void setLoopLimits(LoopAnalyzer::LoopAnalysisResult* llResult) {
        llResult_ = llResult;
    }

    bool mustBeTrigger(const MoveNode& mn, const ProgramOperation& po);

    // just to allow prolog to be longer than loop body.
    static const int PROLOG_CYCLE_BIAS = 1000;

    std::list<ProgramOperation*> loopBufOps();

    void deletingNode(MoveNode* deletedNode);

    void finalizeSchedule();

    void unschedule();

    MoveNodeMap bypassNodes();

    RegisterRenamer* renamer() { return renamer_; }
protected:

    int handleLoopDDG(BUMoveNodeSelector& selector, bool allowPreLoopOpshare);

private:

    bool findJump();

    BF2ScheduleFront* currentFront_;
    int scheduleFrontFromMove(MoveNode& mn);

    std::vector<BFOptimization*> scheduledStack_;

    // kill copy also for these
    DataDependenceGraph::NodeSet dreRemovedMoves_;
    // do not kill copy for these
    DataDependenceGraph::NodeSet removedMoves_;

    MoveNodeMap operandShareRemovedMoves_;
    MoveNodeMap sharedOperands_;

    /// Nodes that may become ready due bypass removing antideps
    DataDependenceGraph::NodeSet bypassPredecessors_;

    DataDependenceGraph::NodeSet pendingMoves_;

    MoveNode* selectMoveToSchedule();


    void initializeQueues();

    MoveNodeSet findSiblings(MoveNode& mn);

    static void writeDotWithNameAndNodeID(
        DataDependenceGraph& ddg,
        const TCEString& namePrefix, const MoveNode& mn);

    bool isRegCopyBefore(MoveNode& mn);
    bool isRegCopyAfter(MoveNode& mn);

    bool pushAntidepDestsDown(MoveNode& mn, int oldLC, int maxLC);
    void undoPushAntideps(MoveNode& aDepSource);

    void eraseFromMoveNodeUseSet(
        LiveRangeData::MoveNodeUseMapSet& mnuMap,
        const TCEString& reg, MoveNode* mn);

    int swapToUntrigger(
        ProgramOperationPtr po, const Operation& op,
        int operandIndex, MoveNode& trig);

    void revertTopOpt();

    void countLoopInvariantValueUsages();
    void allocateFunctionUnits();
    void reservePreallocatedFUs();
    void preAllocateFunctionUnits(ProgramOperationPtr po);

    PreLoopShareInfo preAllocateFunctionUnits(
        ProgramOperationPtr po, const Operation& op,
        const TTAMachine::HWOperation& hwop, bool onlySharedWithAnother);


    PreLoopShareInfo preAllocateFunctionUnits(
        ProgramOperationPtr po, const Operation& op, int operandIndex,
        const TTAMachine::HWOperation& hwop, bool onlySharedWithAnother);

    PreLoopShareInfo preAllocateFunctionUnitsInner(
        ProgramOperationPtr po, const Operation& op,
        bool onlySharedWithAnother);

    void unreservePreallocatedFUs();

    void releasePortForOp(const Operation& op);

    DataDependenceGraph* ddg_;
    DataDependenceGraph* prologDDG_;
    SimpleResourceManager* rm_;
    SimpleResourceManager* prologRM_;

    int latestCycle_;

    const TTAMachine::Machine* targetMachine_;
    BUMoveNodeSelector* selector_;
    LLVMTCECmdLineOptions* options_;
    RegisterRenamer* renamer_;

    bool killDeadResults_;
    int tripCount_;
    MoveNode* jumpNode_;
    MoveNode* jumpGuardWrite_;
    LoopAnalyzer::LoopAnalysisResult* llResult_;

    MoveNodeDuplicator* duplicator_;

    std::multimap<TCEString, MoveNode*> invariants_;
    std::multimap<int, TCEString> invariantsOfCount_;

    // NULL as movenode means no operand share, FU used mutliple times
    std::multimap<TTAMachine::FUPort*, MoveNode*> preSharedOperandPorts_;

    // NULL as movenode means no operand share, FU used multiple times
    std::map<MoveNode*, TTAMachine::FUPort*, MoveNode::Comparator>
    preLoopSharedOperands_;

    std::list<ProgramOperation*> loopBufOps_;
};

#endif
