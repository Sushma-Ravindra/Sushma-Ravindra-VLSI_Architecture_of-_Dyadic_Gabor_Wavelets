module sort #(
   parameter NUM_VALS = 4,
   parameter SIZE     = 10,
   parameter KERNEL_SIZE = 5
)(  input clk,
    //input [10:0] kernel1,
    //input [10:0] kernel2,
    //input [10:0] kernel3,
    //input [10:0] kernel4,
    //input i,
    //input j,
   output reg [(NUM_VALS*SIZE)+NUM_VALS-1:0] finalout,
   output reg [7:0]z
);



reg[1:0] z1,z2,z3,z4; 

reg [(NUM_VALS*SIZE)-1:0] out;
reg [NUM_VALS*SIZE-1:0] in;


reg [10:0] kernel1[KERNEL_SIZE-1:0][KERNEL_SIZE-1:0];
reg [10:0] kernel2[KERNEL_SIZE-1:0][KERNEL_SIZE-1:0];
reg [10:0] kernel3[KERNEL_SIZE-1:0][KERNEL_SIZE-1:0];
reg [10:0] kernel4[KERNEL_SIZE-1:0][KERNEL_SIZE-1:0];



initial
begin
   
   kernel1[0][0] = { 1'b0, 10'd232};    
   kernel1[0][1] = { 1'b0 , 10'd271};  
   kernel1[0][2] = { 1'b 0, 10'd171};  
   kernel1[0][3] = { 1'b1 , 10'd46};  
   kernel1[0][4] = { 1'b 1, 10'd254};
   kernel1[1][0] = { 1'b0, 10'd279};
   kernel1[1][1] = { 1'b 0, 10'd420};
   kernel1[1][2] = { 1'b0 , 10'd407};
   kernel1[1][3] = { 1'b 0, 10'd216};
   kernel1[1][4] = { 1'b 1, 10'd37};
   kernel1[2][0] = { 1'b 0, 10'd184};
   kernel1[2][1] = { 1'b 0, 10'd411};
   kernel1[2][2] = { 1'b 0, 10'd512};
   kernel1[2][3] = { 1'b 0, 10'd411};
   kernel1[2][4] = { 1'b 0, 10'd184};
   kernel1[3][0] = { 1'b 1, 10'd37};
   kernel1[3][1] = { 1'b 0, 10'd216};
   kernel1[3][2] = { 1'b 0, 10'd407};
   kernel1[3][3] = { 1'b 0, 10'd420};
   kernel1[3][4] = { 1'b 0, 10'd279};
   kernel1[4][0] = { 1'b1 , 10'd254};
   kernel1[4][1] = { 1'b 1, 10'd46};
   kernel1[4][2] = { 1'b0 , 10'd171};
   kernel1[4][3] = { 1'b 0, 10'd271};
   kernel1[4][4] = { 1'b 0, 10'd232};


   kernel2[0][0] = { 1'b1, 10'd7};    
   kernel2[0][1] = { 1'b1, 10'd5};  
   kernel2[0][2] = { 1'b0, 10'd0};  
   kernel2[0][3] = { 1'b0, 10'd5};  
   kernel2[0][4] = { 1'b0, 10'd7};
   kernel2[1][0] = { 1'b0, 10'd234};
   kernel2[1][1] = { 1'b0, 10'd317};
   kernel2[1][2] = { 1'b0, 10'd353};
   kernel2[1][3] = { 1'b0, 10'd323};
   kernel2[1][4] = { 1'b0, 10'd242};
   kernel2[2][0] = { 1'b0, 10'd345};
   kernel2[2][1] = { 1'b0, 10'd464};
   kernel2[2][2] = { 1'b 0, 10'd512};
   kernel2[2][3] = { 1'b 0, 10'd464};
   kernel2[2][4] = { 1'b 0, 10'd345};
   kernel2[3][0] = { 1'b 0, 10'd242};
   kernel2[3][1] = { 1'b 0, 10'd323};
   kernel2[3][2] = { 1'b 0, 10'd353};
   kernel2[3][3] = { 1'b 0, 10'd317};
   kernel2[3][4] = { 1'b 0, 10'd234};
   kernel2[4][0] = { 1'b 0, 10'd7};
   kernel2[4][1] = { 1'b 0, 10'd5};
   kernel2[4][2] = { 1'b 0, 10'd0};
   kernel2[4][3] = { 1'b 1, 10'd5};
   kernel2[4][4] = { 1'b 1, 10'd7};



   kernel3[0][0] = { 1'b 1, 10'd254};    
   kernel3[0][1] = { 1'b 1, 10'd33};  
   kernel3[0][2] = { 1'b 0, 10'd188};  
   kernel3[0][3] = { 1'b 0, 10'd282};  
   kernel3[0][4] = { 1'b 0, 10'd232};
   kernel3[1][0] = { 1'b 1, 10'd49};
   kernel3[1][1] = { 1'b 0, 10'd217};
   kernel3[1][2] = { 1'b 0, 10'd412};
   kernel3[1][3] = { 1'b 0, 10'd420};
   kernel3[1][4] = { 1'b 0, 10'd268};
   kernel3[2][0] = { 1'b 0, 10'd167};
   kernel3[2][1] = { 1'b 0, 10'd406};
   kernel3[2][2] = { 1'b 0, 10'd512};
   kernel3[2][3] = { 1'b 0, 10'd406};
   kernel3[2][4] = { 1'b 0, 10'd167};
   kernel3[3][0] = { 1'b 0, 10'd268};
   kernel3[3][1] = { 1'b 0, 10'd420};
   kernel3[3][2] = { 1'b 0, 10'd412};
   kernel3[3][3] = { 1'b 0, 10'd217};
   kernel3[3][4] = { 1'b 1, 10'd49};
   kernel3[4][0] = { 1'b 0, 10'd232};
   kernel3[4][1] = { 1'b 0, 10'd282};
   kernel3[4][2] = { 1'b 0, 10'd188};
   kernel3[4][3] = { 1'b 1, 10'd33};
   kernel3[4][4] = { 1'b 1, 10'd254};


   kernel4[0][0] = { 1'b 0, 10'd0};   
   kernel4[0][1] = { 1'b 0, 10'd238};  
   kernel4[0][2] = { 1'b 0, 10'd22};  
   kernel4[0][3] = { 1'b 0, 10'd238};  
   kernel4[0][4] = { 1'b 0, 10'd0};
   kernel4[1][0] = { 1'b 0, 10'd0};
   kernel4[1][1] = { 1'b 0, 10'd320};
   kernel4[1][2] = { 1'b 0, 10'd29};
   kernel4[1][3] = { 1'b 0 , 10'd320};
   kernel4[1][4] = { 1'b 0 , 10'd0};
   kernel4[2][0] = { 1'b 0 , 10'd0};
   kernel4[2][1] = { 1'b 0 , 10'd353};
   kernel4[2][2] = { 1'b 0 , 10'd512};
   kernel4[2][3] = { 1'b 0 , 10'd353};
   kernel4[2][4] = { 1'b 0 , 10'd0};
   kernel4[3][0] = { 1'b 0 , 10'd0};
   kernel4[3][1] = { 1'b 0 , 10'd320};
   kernel4[3][2] = { 1'b 0 , 10'd29};
   kernel4[3][3] = { 1'b 0 , 10'd320};
   kernel4[3][4] = { 1'b 0 , 10'd0};
   kernel4[4][0] = { 1'b 0 , 10'd0};
   kernel4[4][1] = { 1'b 0 , 10'd238};
   kernel4[4][2] = { 1'b 0 , 10'd22};
   kernel4[4][3] = { 1'b 0 , 10'd238};
   kernel4[4][4] = { 1'b 0 , 10'd0};
     
   
end




reg [SIZE-1:0] temp;
reg [SIZE-1:0] array [1:NUM_VALS];


reg [9:0] out1, out2, out3, out4;
reg [(NUM_VALS*SIZE)+4-1:0] sorted_bus;
integer k,p,q,m;

always @ (posedge clk) begin

    
   
   for (integer i = 0; i < KERNEL_SIZE; i = i + 1) begin
      for (integer j = 0; j < KERNEL_SIZE; j = j + 1) begin
         in[39:0] = { kernel1[i][j][9:0], kernel2[i][j][9:0], kernel3[i][j][9:0], kernel4[i][j][9:0]};
      


        for (k = 0; k < NUM_VALS; k = k + 1) begin
                array[k+1] = in[k*SIZE +: SIZE];
             end
       
            for (p = NUM_VALS; p > 0; p = p - 1) begin
                for (q = 1 ; q < p; q = q + 1) begin
                    if (array[q] < array[q + 1]) begin
                        temp = array[q];
                        array[q]= array[q + 1];
                        array[q+1] = temp;
                    end
                end
            end

            for (m = 0; m < NUM_VALS; m = m + 1) begin
                out[m*SIZE +: SIZE] = array[m+1];

            end

            
            
    


            if(out[39:30]==kernel1[i][j][9:0]) begin
                z1=2'b00; 
                finalout[43:33] = kernel1[i][j];
            end
            else if(out[39:30]==kernel2[i][j][9:0]) begin 

                z1=2'b01;
                finalout[43:33] = kernel2[i][j];
            end 
            else if(out[39:30]==kernel3[i][j][9:0])begin
                z1=2'b10; 
                finalout[43:33] = kernel3[i][j];
            end
            else if(out[39:30]==kernel4[i][j][9:0]) begin
                z1=2'b11; 
                finalout[43:33] = kernel4[i][j];
            end

            if(out[29:20]==kernel1[i][j][9:0]) begin
                z2=2'b00; 
                finalout[32:22] = kernel1[i][j];
            end

            else if(out[29:20]==kernel2[i][j][9:0]) begin
                z2=2'b01; 
                finalout[32:22] = kernel2[i][j];
            end
            else if(out[29:20]==kernel3[i][j][9:0]) begin
                z2=2'b10; 
                finalout[32:22] = kernel3[i][j];
            end
            else if(out[29:20]==kernel4[i][j][9:0]) begin
                z2=2'b11; 
                finalout[32:22] = kernel4[i][j];
            end


            if(out[19:10]==kernel1[i][j][9:0]) begin 
                z3=2'b00; 
                finalout[21:11] = kernel1[i][j];
            end

            else if(out[19:10]==kernel2[i][j][9:0]) begin
                z3=2'b01; 
                finalout[21:11] = kernel2[i][j];
            end
            else if(out[19:10]==kernel3[i][j][9:0]) begin
                z3=2'b10; 
                finalout[21:11] = kernel3[i][j];
            end
            else if(out[19:10]==kernel4[i][j][9:0]) begin
                z3=2'b11; 
                finalout[21:11] = kernel4[i][j];
            end

            if(out[9:0]==kernel1[i][j][9:0]) begin
                z4=2'b00; 
                finalout[10:0] = kernel1[i][j];
            end
            else if(out[9:0]==kernel2[i][j][9:0]) begin
                z4=2'b01; 
                finalout[10:0] = kernel2[i][j];
            end
            else if(out[9:0]==kernel3[i][j][9:0]) begin
                z4=2'b10; 
                finalout[10:0] = kernel3[i][j];
            end
            else if(out[9:0]==kernel4[i][j][9:0]) begin
                z4=2'b11; 
                finalout[10:0] = kernel1[i][j];
            end

            z = {z1,z2,z3,z4};


            $display("In: %d, %d ,%d ,%d", in[39:30], in[29:20], in[19:10], in[9:0]);
            $display("Out: %d ,%d ,%d ,%d", finalout[43:33], finalout[32:22], finalout[21:11], finalout[10:0]);
            $display("Order: %d ,%d ,%d ,%d", z1,z2,z3,z4);
            $display(z);
      end 
   end        

end







endmodule

