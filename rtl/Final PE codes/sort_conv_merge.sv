`timescale 1ns/1ps

module sort #(parameter IMAGE_WIDTH = 128,
             parameter IMAGE_HEIGHT = 128,
             parameter IMAGE_SIZE = 8,
             parameter KERNEL_LENGTH = 5,
             parameter KERNEL_SIZE = 11,
             parameter NUM_VALS = 4,
             parameter SIZE = 10)
   (input clk,
    input [7:0]img_pixel,
    input [10:0]kernel1,
    input [10:0]kernel2,
    input [10:0]kernel3,
    input [10:0]kernel4, 
    output logic [IMAGE_SIZE-1:0] final_tmp[0:NUM_VALS-1]
);
 

logic [(NUM_VALS*SIZE)-1:0] out;
logic [NUM_VALS*SIZE-1:0] in;

logic [SIZE-1:0] temp;
logic [SIZE-1:0] array [1:NUM_VALS];
logic [(NUM_VALS*SIZE)+NUM_VALS-1:0] finalout;
logic [1:0] sel [0:NUM_VALS-1];

integer k,l,r,s,e,f;

logic [(IMAGE_SIZE+KERNEL_SIZE-2):0] in1_tmp;
logic [(KERNEL_SIZE-1):0] in2_tmp [0:3];
logic [(KERNEL_SIZE-2):0] in2_diff = 0;
logic [(IMAGE_SIZE+KERNEL_SIZE-2):0] res_tmp=0;
logic [(IMAGE_SIZE+KERNEL_SIZE-1):0] res [0:3];
logic [(IMAGE_SIZE+KERNEL_SIZE-1):0] add_res = 0;
logic [IMAGE_SIZE+KERNEL_SIZE:0] final_tmp = 0;


always @ (*) begin

        
        in[39:0] = { kernel1[9:0], kernel2[9:0], kernel3[9:0], kernel4[9:0]};    

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
                out[s*SIZE +: SIZE] = array[s+1];         
            end            
 
            if(out[39:30]==kernel1[9:0]) begin 
                finalout[43:33] = kernel1;
            end
            else if(out[39:30]==kernel2[9:0]) begin
                finalout[43:33] = kernel2;
            end 
            else if(out[39:30]==kernel3[9:0])begin
                finalout[43:33] = kernel3;
            end
            else  begin
                finalout[43:33] = kernel4;
            end

            if(out[29:20]==kernel2[9:0]) begin 
                finalout[32:22] = kernel2;
            end

            else if(out[29:20]==kernel3[9:0]) begin
                finalout[32:22] = kernel3;
            end
            else if(out[29:20]==kernel4[9:0]) begin
                finalout[32:22] = kernel4;
            end
            else begin
                finalout[32:22] = kernel1;
            end


            if(out[19:10]==kernel3[9:0]) begin
                finalout[21:11] = kernel3;
            end

            else if(out[19:10]==kernel4[9:0]) begin
                finalout[21:11] = kernel4;
            end
            else if(out[19:10]==kernel1[9:0]) begin
                finalout[21:11] = kernel1;
            end
            else  begin
                finalout[21:11] = kernel2;
            end

            if(out[9:0]==kernel4[9:0]) begin
                finalout[10:0] = kernel4;
            end
            else if(out[9:0]==kernel1[9:0]) begin
                finalout[10:0] = kernel1;
            end
            else if(out[9:0]==kernel2[9:0]) begin
                finalout[10:0] = kernel2;
            end
            else begin
                finalout[10:0] = kernel3;
            end
//************************************************convolution*****************************************
                in1_tmp = {11'b0, img_pixel};
                in2_tmp[3] = finalout[10:0];
                in2_tmp[2] = finalout[21:11];
                in2_tmp[1] = finalout[32:22];
                in2_tmp[0] = finalout[43:33];
                
        for(e=0;e<4;e=e+1) begin
        
        in2_diff = (e==0) ? (in2_tmp[e][KERNEL_SIZE-2:0]) : (in2_tmp[e][KERNEL_SIZE-2:0] - in2_tmp[e-1][KERNEL_SIZE-2:0]);

        for (f=0;f<11;f=f+1) begin
            if(in2_diff[f]==1'b0) begin
			res_tmp = res_tmp+0;
		    end
	        else if (in2_diff[f]==1'b1) begin
			res_tmp = res_tmp + (in1_tmp <<f);
		    end
        end

        res[e] = ((img_pixel[IMAGE_SIZE-1])^(in2_tmp[e][KERNEL_SIZE-1])) ? 0 : ({1'b0 , (res_tmp)>>9});
        case(sel[e])
            2'b00: final_tmp[0] = (res[e] >> 9);
            2'b01: final_tmp[1] = (res[e] >> 9);
            2'b10: final_tmp[2] = (res[e] >> 9);
            2'b11: final_tmp[3] = (res[e] >> 9);
        endcase

    end

    
    // assign final_res = final_tmp[IMAGE_SIZE-1:0];


      end

endmodule
