`timescale 1ns / 1ps
module alu(input  logic [31:0] a, b, 
           input  logic [2:0]  aluctrl, 
           output logic [31:0] result,
           output logic zero);
           
  // alu aluUnit (srca, srcb, alucontrol, aluout, zero);
    always_comb
    case(aluctrl)
        3'b010: result = a+b; // add
        3'b110: result = a-b; // subs
        3'b000: result = a&b; // and
        3'b001: result = a|b; // or
        3'b111: if(a < b)
                    result = 32'b0;
                else 
                    result = {31'b0, 1'b1};
        default: result = 32'bx;// undefined instruction
    endcase
    
    always_comb
        if(a == b)
            zero = 1'b1;
        else
            zero = 1'b0;    
endmodule