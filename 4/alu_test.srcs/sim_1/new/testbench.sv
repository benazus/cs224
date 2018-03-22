`timescale 1ns / 1ps

module testbench();

	logic[31:0] a, b, result;
	logic zero;
	logic[2:0] aluctrl;


	alu eyelyu(a, b, aluctrl, result, zero);

	initial
		begin
			a = 32'b01101;
			b = 32'b11000;
			aluctrl = 3'b010;
		end

	always
		begin
			aluctrl = 3'b010; #20;
			aluctrl = 3'b110; #20;
			aluctrl = 3'b000; #20;
			aluctrl = 3'b001; #20;
			aluctrl = 3'b111; #20;
		end
endmodule
