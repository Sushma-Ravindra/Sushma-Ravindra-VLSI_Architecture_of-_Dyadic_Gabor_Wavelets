`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/04/2024 10:11:24 PM
// Design Name: 
// Module Name: gabor_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////



module gabor_tb();

    reg clk; 
    reg reset;
    wire conv;
    
    gabor dut(
        .clk(clk),
        .reset(reset),
        .conv(conv), 
        .data_valid(1'b1)
    );


always 
#1  clk = ~clk;

    
    initial begin 
        reset = 1'b0;



      
    end
    
endmodule
