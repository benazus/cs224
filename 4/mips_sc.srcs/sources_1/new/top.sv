`timescale 1ns / 1ps
module top(input logic clk, reset,            
	     output logic[31:0] writedata, dataadr, pcOut, instrOut,           
	     output logic memwrite);  

   logic[31:0] readdata, pc, instr;
   
   always_comb
   	begin
   		pcOut <= pc;
   		instrOut <= instr;
   	end
   	

   // instantiate processor and memories  
   mips mips(clk, reset, readdata, instr, memwrite, aluout, dataadr, pc);  
   imem imem(pc[7:2], instr);  
   dmem dmem(clk, memwrite, dataadr, writedata, readdata);

endmodule