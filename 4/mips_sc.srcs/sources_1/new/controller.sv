`timescale 1ns / 1ps
module controller(input logic[5:0] op, funct,
                  input logic zero,
                  output logic[1:0] memtoreg, 
                  output logic memwrite,
                  output logic branchSignal, alusrc,
                  output logic regdst, regwrite,
                  output logic[1:0] PCSource,
                  output logic[2:0] alucontrol);

   logic[1:0] aluop;
   logic branch;

   maindec md(op, memtoreg, memwrite, branch, alusrc, regdst, regwrite, PCSource, aluop);

   aludec  ad(funct, aluop, alucontrol);

   assign branchSignal = branch & zero;

endmodule