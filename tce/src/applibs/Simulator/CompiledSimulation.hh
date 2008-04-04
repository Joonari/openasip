/**
 * @file CompiledSimulation.hh
 *
 * Declaration of CompiledSimulation abstract class.
 *
 * @author Viljami Korhonen 2007 (viljami.korhonen@tut.fi)
 * @note rating: red
 */

#ifndef COMPILED_SIMULATION_HH
#define COMPILED_SIMULATION_HH

#include "Machine.hh"
#include "MemorySystem.hh"
#include "SimulatorConstants.hh"
#include "SimValue.hh"
#include "OperationPool.hh"

#include <map>


namespace TTAMachine {
    class Machine;
}

namespace TTAProgram {
    class Program;
}

class SimulatorFrontend;


/**
 * A struct that describes a single FU result type
 */
struct FUResultElementType {
    /// time when this result is ready
    ClockCycleCount cycles;
    
    /// FU Result value
    SimValue value;
    
    /// Is this result element used in the array or not
    bool used;
    
    FUResultElementType() : cycles(0), used(false) {}
};

/**
 * A struct for dynamic array containing the FU results
 */
struct FUResultType {
    /// size of the array
    const int size;
    /// array of result elements
    FUResultElementType* data;
    
    /// A constructor that initializes the ring buffer
    FUResultType(int maxLatency) 
        : size(maxLatency), data(new FUResultElementType[size]) {}
    /// The destructor. Frees all memory
    ~FUResultType() { delete[] data; data = NULL; }
};   


/**
 * An abstract class that is used as a base for all the compiled simulations
 * 
 * The derived classes are generated by CompiledSimCodeGenerator and then
 * get loaded as plugins by the CompiledSimController.
 * 
 */
class CompiledSimulation {
public:
    CompiledSimulation(
        const TTAMachine::Machine& machine,
        const TTAProgram::Program& program,
        SimulatorFrontend& frontend,
        MemorySystem& memorySystem);
    virtual ~CompiledSimulation();
    
    virtual void simulateCycle() = 0;
    
    virtual void step(double count);
    virtual void next(int count);
    virtual void run();
    virtual void runUntil(UIntWord address);
            
    virtual InstructionAddress programCounter() const;
    virtual InstructionAddress lastExecutedInstruction() const;
    
    virtual ClockCycleCount cycleCount() const;
    
    virtual SimValue registerFileValue(
        const std::string& rfName, 
        int registerIndex);
    
    virtual SimValue immediateUnitRegisterValue(
        const std::string& iuName, int index);
    
    virtual SimValue FUPortValue(
        const std::string& fuName,
        const std::string& portName);
    
    virtual bool stopRequested() const;
    virtual bool isFinished() const;
        
protected:
    TTAMachine::FunctionUnit& functionUnit(const std::string& name)
        const throw (InstanceNotFound);
    
    Memory& FUMemory(const std::string& FUName) const throw (InstanceNotFound);
    MemorySystem* memorySystem() const;
    SimulatorFrontend& frontend() { return frontend_; }
    void msg(const std::string& msg) const;
    
    static void inline addFUResult(
        FUResultType& results,
        ClockCycleCount cycleCount,
        const SimValue& value,
        int latency);
    
    static void inline addFUResult(
        FUResultType& results,
        ClockCycleCount cycleCount,
        const UIntWord& value,
        int latency);
    
    static void inline FUResult(
        SimValue& target,
        FUResultType& results,
        ClockCycleCount cycles);
        
    /// Number of cycles simulated so far
    ClockCycleCount cycleCount_;
    /// Number of basic blocks gone through
    int basicBlockCount_;
    /// The jump target. Allows jumping to different addresses in the code
    InstructionAddress jumpTarget_;
    /// The program counter. i.e. which address the simulation is currently at
    InstructionAddress programCounter_;
    /// Last executed instruction
    InstructionAddress lastExecutedInstruction_;    
    /// Number of cycles left to simulate until the execution returns
    ClockCycleCount cyclesToSimulate_;
    
    /// Type for symbol map: string = symbolname, SimValue* = value location
    typedef std::map<std::string, SimValue*> Symbols;
    /// A Symbol map for easily getting the SimValues out of the simulation
    Symbols symbols_;    

    /// Should the simulation stop or not?
    bool stopRequested_;  
    /// Is the simulation finished?
    bool isFinished_;

    /// Function unit navigator
    const TTAMachine::Machine::FunctionUnitNavigator fuNavigator_;
    
    /// A flag for FU conflict detection
    bool conflictDetected_;

    /// The simulated machine
    const TTAMachine::Machine& machine_;
    /// The simulated program
    const TTAProgram::Program& program_;

    /// Maximum possible number of operands
    static const int OPERAND_TABLE_SIZE = 256;
    /// Operand table used for simulateTrigger()
    SimValue* operandTable_[OPERAND_TABLE_SIZE];
    /// Output operands as SimValues, again used for simulateTrigger()
    SimValue outOperands_[OPERAND_TABLE_SIZE];
    /// The operation pool
    OperationPool operationPool_;

private:
    /// Copying not allowed.
    CompiledSimulation(const CompiledSimulation&);
    /// Assignment not allowed.
    CompiledSimulation& operator=(const CompiledSimulation&);
    
    /// The memory system
    MemorySystem* memorySystem_;
    /// The simulator frontend
    SimulatorFrontend& frontend_;
};

#include "CompiledSimulation.icc"

#endif
