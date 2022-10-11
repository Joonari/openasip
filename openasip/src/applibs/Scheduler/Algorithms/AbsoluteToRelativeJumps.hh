/*
    Copyright (c) 2002-2019 Tampere University.

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
 * @file AbsoloteToRelativeJumps.cc
 *
 * Declaration of AbsoloteToRelativeJumps class.
 *
 * @author Heikki Kultala 2019 (heikki.kultala-no.spam-tuni.fi)
 * @note rating: red
 */

#ifndef TCE_ABSOLUTE_TO_RELATIVE_JUMPS_HH
#define TCE_ABSOLUTE_TO_RELATIVE_JUMPS_HH

#include "ProcedurePass.hh"
#include "ProgramPass.hh"

class AbsoluteToRelativeJumps :
    public ProcedurePass, public ProgramPass {

public:
    AbsoluteToRelativeJumps(InterPassData& ipd) : 
        ProcedurePass(ipd), ProgramPass(ipd) {}

    virtual void handleProcedure(
        TTAProgram::Procedure& procedure,
        const TTAMachine::Machine& targetMachine) override;

    virtual std::string shortDescription() const override {
        return "Compiler pass to convert absolute jumps to relative jumps.";
    }
};

#endif
