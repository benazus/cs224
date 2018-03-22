`timescale 1ns / 1ps

module sim();
  logic         clk;
  logic         reset;

//  wire [31:0] writedata, dataadr; // default	
  logic [31:0] writedata, dataadr, pc, instr; // modified
  logic memwrite;

  // instantiate device to be tested
  // top dut(clk, reset, writedata, dataadr, memwrite);	// default
  top dut(clk, reset, writedata, dataadr, pc, instr, memwrite); // modified
  
  // initialize test
  initial
    begin
      reset <= 1; # 22; reset <= 0;
    end

  // generate clock to sequence tests
  always
    begin
      clk <= 1; # 5; clk <= 0; # 5;
    end    
endmodule
