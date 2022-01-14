`timescale 1ns/1ps
// =============================================================================
//  Program : committed_map_table.sv
//  Author  : Hon-Chou Dai
//  Date    : May/15/2021
// -----------------------------------------------------------------------------
//  Description:
//  This module current use for simulation debug.
//  It would not be synthesized in current design.
//  It may need in future if we want to implement RISCV debug spec.
//
// -----------------------------------------------------------------------------
//  Revision information:
//
//    None.
//
// -----------------------------------------------------------------------------
//  License information:
//
//  This software is released under the BSD-3-Clause Licence,
//  see https://opensource.org/licenses/BSD-3-Clause for details.
//  In the following license statements, "software" refers to the
//  "source code" of the complete hardware/software system.
//
//  Copyright 2022,
//                    Embedded Intelligent Systems Lab (EISL)
//                    Deparment of Computer Science
//                    National Yang Ming Chiao Tung Uniersity (NYCU)
//                    Hsinchu, Taiwan.
//
//  All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice,
//     this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice,
//     this list of conditions and the following disclaimer in the documentation
//     and/or other materials provided with the distribution.
//
//  3. Neither the name of the copyright holder nor the names of its contributors
//     may be used to endorse or promote products derived from this software
//     without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
//  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
//  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
//  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
//  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
//  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
//  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
//  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
//  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
//  POSSIBILITY OF SUCH DAMAGE.
// =============================================================================

import Falco_pkg::*;

module committed_map_table(
    input clk,
    input rst,
    commit_stage_io.Committed_map io
);

prf_specifier_t committed_map_table [31:0] /* verilator public */;
integer i;

always_ff @(posedge clk) begin
    if (rst)
        for (i = 0 ; i < 32 ; i = i + 1) begin
            committed_map_table[i] <= i; //init map to architected register specifiers
        end
    if (io.committed_update.map_update_0)
        committed_map_table[io.committed_update.map_arf_0] <= io.committed_update.map_prf_0;
    if (io.committed_update.map_update_1)
        committed_map_table[io.committed_update.map_arf_1] <= io.committed_update.map_prf_1;
end

endmodule
