module gabor(
    input clk,
    input reset,
    output reg conv,
    input data_valid
);

    // Parameters
    parameter WIDTH = 128;
    parameter HEIGHT = 128;
    parameter KERNEL_SIZE = 5;

    // Inputs
    //input wire data_valid;
    integer i, j,m,n;
    integer k = 0;
    integer file1;

    // Outputs
     reg [31:0] conv_result[0:WIDTH-1][0:HEIGHT-1];

    // Internal variables
    reg [7:0] img_pixel;
    reg [7:0] pixel[0:16384]; 
    reg [9:0] kernel[KERNEL_SIZE-1:0][KERNEL_SIZE-1:0];
    reg [7:0] image_arr [0:WIDTH-1][0:HEIGHT-1];
    integer file_handle;

    // Open the file for writing
    initial begin
        file_handle = $fopen("conv_result.txt", "w");
        if (file_handle == 0) begin
            $display("Error: Unable to open file for writing");
            $finish;
        end
    end

    // Read image data from file
initial 
begin 
  file1 = $fopen("output.txt","r");
    $readmemb("output.txt",pixel);

    k=0;
      
        for ( i = 0; i < 128; i = i + 1) begin
            for (j = 0; j < 128; j = j + 1) begin
                image_arr[i][j] = pixel[k];
               
                k=k+1;

            end
        end
  $fclose(file1);
/*
for (i = 0; i < 128; i = i + 1) begin
    for (j = 0; j < 128; j = j + 1) begin
        $display("image_arr[%d][%d] = %d", i, j, image_arr[i][j]);
        // %h format specifier displays the value in hexadecimal
    end
end */




end 
initial 
begin 
     
    kernel[0][0] = 10'd0;    
    kernel[0][1] = 10'd238;  
    kernel[0][2] = 10'd22;  
    kernel[0][3] = 10'd238;  
    kernel[0][4] = 10'd0; 
    kernel[1][0] = 10'd0; 
    kernel[1][1] = 10'd320; 
    kernel[1][2] = 10'd29; 
    kernel[1][3] = 10'd320; 
    kernel[1][4] = 10'd0; 
    kernel[2][0] = 10'd0; 
    kernel[2][1] = 10'd353; 
    kernel[2][2] = 10'd512; 
    kernel[2][3] = 10'd353; 
    kernel[2][4] = 10'd0; 
    kernel[3][0] = 10'd0; 
    kernel[3][1] = 10'd320; 
    kernel[3][2] = 10'd29; 
    kernel[3][3] = 10'd320; 
    kernel[3][4] = 10'd0; 
    kernel[4][0] = 10'd0; 
    kernel[4][1] = 10'd238; 
    kernel[4][2] = 10'd22; 
    kernel[4][3] = 10'd238; 
    kernel[4][4] = 10'd0; 
       
    
end

    // Convolution process
    always @(*) begin
        if (reset) begin
            conv = 0;
        end
        else if (data_valid) begin
            
            for (i = 0; i < WIDTH; i = i + 1) begin
                for (j = 0; j < HEIGHT; j = j + 1) begin
                    conv_result[i][j] = 32'b0; // Clear output before convolution
                    for (m = 0; m < KERNEL_SIZE; m = m + 1) begin
                        for (n = 0; n < KERNEL_SIZE; n = n + 1) begin
                            if ((i + m < WIDTH) && (j + n < HEIGHT))
                            conv_result[i][j] = conv_result[i][j] + ((image_arr[i+m][j+n] * kernel[m][n]) >> 9);
                            if(conv_result[i][j]>255)begin
                                conv_result[i][j] = 255;
                            end

                            else 
                                conv_result[i][j] = conv_result[i][j];
                    
                        end
                    end
                    
		            $display("conv_arr[%d][%d] = %d", i, j, conv_result[i][j]);
                    $fwrite(file_handle, "%d ", conv_result[i][j]);
                end
                $fwrite(file_handle, "\n");
            end
            //$fclose(file_handle);
            $display("Convolution result written to file");
            conv = 1'b1;
		$display("Convolution is  %b",conv);
        end
    end
always@* begin 
if(conv) begin 
$fclose(file_handle);
$finish;
end
end

endmodule

