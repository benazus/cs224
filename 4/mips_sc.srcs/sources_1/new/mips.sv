`timescale 1ns / 1ps
module mips (input  logic clk, reset,
             input  logic[31:0] readdata,
             input  logic[31:0] instr,
             output logic memwrite,
             output logic[31:0] aluout, writedata, pc);

  logic branchSignal, zero, alusrc, regdst, regwrite;
  logic [1:0] PCSource, memtoreg;
  logic [2:0] alucontrol;

  controller c (instr[31:26], instr[5:0], zero, memtoreg, memwrite, branchSignal, alusrc, regdst, regwrite, PCSource, alucontrol);

  datapath dp (clk, reset, memtoreg, branchSignal, alusrc, regdst, regwrite, PCSource, alucontrol, instr, readdata, zero, pc, aluout, writedata);
endmodule
