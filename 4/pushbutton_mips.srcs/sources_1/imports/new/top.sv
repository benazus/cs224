module top(input logic clk, reset, sw_input,
        output logic[0:3] AN,
		output logic[6:0] C, 
        output logic DP);
 
  logic memwrite;
  logic[31:0] pc, instr, readdata, writedata, dataadr;

  assign enables = 4'b1111;
  // instantiate processor and memories

  mips mips(clk_pulse, reset, readdata, instr, memwrite, dataadr, writedata, pc);
  imem imem(pc[7:2], instr);
  dmem dmem(clk_pulse, memwrite, dataadr, writedata, readdata);
  
  display_controller displayController(clk, reset, enables, writedata[7:4], writedata[3:0] , dataadr[7:4], dataadr[3:0], AN, C, DP);
  pulse_controller   pulseController(clk, sw_input, reset, clk_pulse);
  

endmodule