`timescale 1ns/1ps

module sort #(parameter KERNEL_SIZE = 11,
             parameter NUM_VALS = 4,
             parameter SIZE = 10)
   (input clk,
    input [KERNEL_SIZE-1:0] kernel [0:NUM_VALS-1], 
    output logic [KERNEL_SIZE-1:0] sort_out [0:NUM_VALS-1],
    output logic [1:0] sel [0 : NUM_VALS-1] );
 

logic [KERNEL_SIZE-2:0] out [NUM_VALS-1:0];
logic [NUM_VALS*SIZE-1:0] in;

logic [SIZE-1:0] temp;
logic [SIZE-1:0] array [1:NUM_VALS];

integer k,l,r,s,i,j;


always @ (*) begin

        
        in[39:0] = { kernel[0][9:0], kernel[1][9:0], kernel[2][9:0], kernel[3][9:0]};    

        for (k = 0; k < NUM_VALS; k = k + 1) begin
            array[k+1] = in[k*SIZE +: SIZE];
        end
       
        for (l = NUM_VALS; l > 0; l= l - 1) begin
            for (r = 1 ; r < l; r= r + 1) begin
                if (array[r] < array[r + 1]) begin
                    temp = array[r];
                    array[r]= array[r + 1];
                    array[r+1] = temp;
                end
            end
        end

        for (s = 0; s < NUM_VALS; s = s + 1) begin
            out[s] = array[s+1];         
        end            

        for (i=0; i<NUM_VALS; i=i+1) begin
            for (j=0; j<NUM_VALS; j=j+1) begin
                if(out[i] == kernel[j][SIZE-1:0]) begin
                    sort_out[(NUM_VALS-1)-i] = kernel[j];            
                    sel[(NUM_VALS-1)-i] = j;
                end
            end
        end

end

endmodule


//////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.04.2024 12:23:07
// Design Name: 
// Module Name: conv_tb
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


module conv_tb #(parameter IMAGE_WIDTH = 128,
                parameter IMAGE_HEIGHT = 128,
                parameter IMAGE_SIZE = 9,
                parameter KERNEL_LENGTH = 5,
                parameter KERNEL_SIZE = 11,
                parameter NUM_VALS = 4)();

logic clk;
logic [KERNEL_SIZE-1:0] kernel [0:NUM_VALS-1];
logic [KERNEL_SIZE-1:0] sort_out [0:NUM_VALS-1];
logic [1:0] sel [0 : NUM_VALS-1];

sort uut (.clk(clk),.kernel(kernel),.sort_out(sort_out),.sel(sel));

initial begin 
clk=0;
#10;
kernel = {11'b00011101000, 11'b10000000111, 11'b10011111110, 11'b00000000000};
#100;
$finish;
end

always #5 clk = ~clk;

endmodule
