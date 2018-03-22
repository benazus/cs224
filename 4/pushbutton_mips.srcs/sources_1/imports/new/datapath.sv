`timescale 1ns / 1ps
module datapath (input logic clk, reset, 
                 input logic[1:0] memtoreg, // Changed
                 input logic branchSignal, alusrc, regdst,
                 input logic regwrite, 
                 input logic[1:0] PCSource, // Changed
		         input logic[2:0] alucontrol,
		         input logic[31:0] instr,
		         input logic[31:0] readdata,
                 output logic zero, 
		         output logic[31:0] pc, 
	             output logic[31:0] aluout, writedata);

   logic[4:0] writereg;
   logic[31:0] pcnext, pcnextbr, pcplus4, pcbranch;
   logic[31:0] signimm, signimmsh, srca, srcb, result;
 
   // next PC logic
   flopr #(32) pcreg(clk, reset, pcnext, pc);
   adder pcadd1(pc, 32'b100, pcplus4);
   sl2 immsh(signimm, signimmsh);
   adder pcadd2(pcplus4, signimmsh, pcbranch);
   mux2 #(32) pcbrmux(pcplus4, pcbranch, branchSignal, pcnextbr); // first pc reg
   mux4 #(32) pcmux(pcnextbr, {pcplus4[31:28], instr[25:0], 2'b00}, srca, 0, PCSource, pcnext); // Second pc reg, Changed Here, New source file added

   // register file logic
   regfile rf(clk, regwrite, instr[25:21], instr[20:16], writereg, result, srca, writedata);

   mux2 #(5) wrmux (instr[20:16], instr[15:11], regdst, writereg);
   adder rsMinus4(srca, -4, stackLoc); // Adder for sp, new
   mux4 #(32) rfWriteSource(aluout, readdata, pcplus4, stackLoc, memtoreg, result); // Write-back mux, New source file added
   signext se(instr[15:0], signimm);

   // ALU logic
   mux2 #(32) srcbmux (writedata, signimm, alusrc, srcb);
   alu aluUnit(srca, srcb, alucontrol, aluout, zero);

endmodule