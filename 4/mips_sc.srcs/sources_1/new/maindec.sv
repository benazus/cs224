`timescale 1ns / 1ps
module maindec (input logic[5:0] op, 
	              output logic [1:0]memtoreg,
	              output logic memwrite, branch,
	              output logic alusrc, regdst, regwrite, 
	              output logic[1:0] PCSource,
	              output logic[1:0] aluop );
   logic [10:0] controls;

   assign {regwrite, regdst, alusrc, branch, memwrite,
                memtoreg,  aluop, PCSource} = controls;

  always_comb
    case(op)
      6'b000000: controls <= 11'b11000001000; // R-type Arithmetics
      6'b100011: controls <= 11'b10100010000; // LW
      6'b101011: controls <= 11'b00101000000; // SW
      6'b000100: controls <= 11'b00010000100; // BEQ
      6'b001000: controls <= 11'b10100000001; // ADDI
      6'b000010: controls <= 11'b00000000001; // J
      6'b000001: controls <= 11'b00000100010; // JALR
      6'b000011: controls <= 11'b10101110000; // PUSH
      default:   controls <= 11'bxxxxxxxxxxx; // illegal op
    endcase
endmodule