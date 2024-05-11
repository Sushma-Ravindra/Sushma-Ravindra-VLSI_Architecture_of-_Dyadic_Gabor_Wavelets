module convolution #(parameter NUM_VALS = 4,
   parameter PIXEL_SIZE     = 8,
   parameter KERNEL_SIZE = 11)
(
    input clk,
    input [PIXEL_SIZE-1:0] a,
    input [(KERNEL_SIZE)-1:0] kernel [0:NUM_VALS-1],
    input [1:0] sel [0 : NUM_VALS-1],
    output logic [PIXEL_SIZE-1:0] final_tmp [0:NUM_VALS-1]
);

integer i,j,k;
logic [(PIXEL_SIZE+KERNEL_SIZE-2):0] a_tmp;
// logic [(KERNEL_SIZE-1):0] b_tmp [0:3];
logic [(KERNEL_SIZE-2):0] b_diff = 0;
logic [(PIXEL_SIZE+KERNEL_SIZE-2):0] res_tmp = 0;
logic [(PIXEL_SIZE+KERNEL_SIZE-1):0] res [0:3];
logic [(PIXEL_SIZE+KERNEL_SIZE-1):0] add_res = 0;
logic [PIXEL_SIZE+KERNEL_SIZE:0] final_tmp = 0;

always@(*) begin

    a_tmp = {11'd0, a[PIXEL_SIZE-1:0]};

    for(i=0;i<4;i=i+1) begin
        
        b_diff = (i==0) ? (kernel[i][KERNEL_SIZE-2:0]) : ((kernel[i][KERNEL_SIZE-2:0]) - (kernel[i-1][KERNEL_SIZE-2:0]));

        for (j=0;j<11;j=j+1) begin
            if(b_diff[j]==1'b0) begin
			res_tmp= res_tmp+ 'd0;
		    end
	        else if (b_diff[j]==1'b1) begin
			res_tmp = res_tmp + (a_tmp <<j);
		    end
        end
        
        res[i] = ((a[PIXEL_SIZE-1])^(b_tmp[i][KERNEL_SIZE-1])) ? ({1'b1, (res_tmp)>>9}) : ({1'b0 , (res_tmp)>>9});
        case(sel[i])
            2'b00: final_tmp[0] = (res[i] >> 9);
            2'b01: final_tmp[1] = (res[i] >> 9);
            2'b10: final_tmp[2] = (res[i] >> 9);
            2'b11: final_tmp[3] = (res[i] >> 9);
        endcase

    end

    
    // assign final_res = final_tmp[PIXEL_SIZE-1:0];

end

endmodule

    