module top #(parameter IMAGE_WIDTH = 512,
             parameter IMAGE_HEIGHT = 512,
             parameter IMAGE_SIZE = 8,
             parameter KERNEL_LENGTH = 5,
             parameter KERNEL_SIZE = 11,
             parameter NUM_VALS = 4,
             parameter SIZE = 10
             )
             (input clk);
//      in and out variables
logic [KERNEL_SIZE-1:0] kernel1 [0:(KERNEL_LENGTH**2)-1];
logic [KERNEL_SIZE-1:0] kernel2 [0:(KERNEL_LENGTH**2)-1];
logic [KERNEL_SIZE-1:0] kernel3 [0:(KERNEL_LENGTH**2)-1];
logic [KERNEL_SIZE-1:0] kernel4 [0:(KERNEL_LENGTH**2)-1];
logic [IMAGE_SIZE:0] img_pixel [0: (KERNEL_LENGTH**2)-1];
logic [IMAGE_SIZE-1:0] arr [0:(KERNEL_LENGTH**2)-1]; 
logic [IMAGE_SIZE-1:0] k45;
logic [IMAGE_SIZE-1:0] k90;
logic [IMAGE_SIZE-1:0] k135;
logic [IMAGE_SIZE-1:0] k180;
//logic [IMAGE_SIZE-1:0] 
//      sort_variables
logic [KERNEL_SIZE-1:0] kernel [0:NUM_VALS-1];
logic [KERNEL_SIZE-2:0] out [NUM_VALS-1:0];
logic [NUM_VALS*SIZE-1:0] in;
logic [SIZE-1:0] temp;
logic [SIZE-1:0] array [1:NUM_VALS];
logic [KERNEL_SIZE-1:0] sort_out [0:NUM_VALS-1];
logic [1:0] sel [0 : NUM_VALS-1];
//      convolution_variables
logic [(IMAGE_SIZE+KERNEL_SIZE-1):0] img_tmp;
logic [(KERNEL_SIZE-2):0] kernel_diff = 0;
logic [(IMAGE_SIZE+KERNEL_SIZE-2):0] res_tmp =0;
logic [(IMAGE_SIZE+KERNEL_SIZE-1):0] res [0:NUM_VALS-1];
logic [IMAGE_SIZE+KERNEL_SIZE-1:0] final_tmp [0:NUM_VALS-1];
logic [IMAGE_SIZE+KERNEL_SIZE-1:0] final_res45=0,final_res90=0, final_res135=0, final_res180 = 0;
//      blockram variables
logic [17:0]addr=0;
logic [7:0]data;
logic flag1=0,flag2=0;
logic [4:0] addr1=0;
logic addr2=0;
logic [10:0] data1,data2,data3,data4;

 //      integer_variables
//logic conv_done = 0;
//integer k,l,r,s,i,j,e,f,g,a,b,c,d;
integer a=0,b=0,c=0,d=0,e=0,f=0,g=0,i=0,j=0,k=0,l=0,r=0,s=0;
integer h=0,m=0,n=0,o=0,p=0,q=0,t=0,u=0,v=0;
integer x,y,w,z,a1;
integer file1;

//      input image data
blk_mem_gen_0 img_data (
  .clka(clk),    // input wire clka
  .addra(addr),  // input wire [17 : 0] addra
  .douta(data)  // output wire [7 : 0] douta
);
//      kernel45
blk_mem_gen_1 kernel45 (
  .clka(clk),    // input wire clka
  .addra(addr1),  // input wire [4 : 0] addra
  .douta(data1)  // output wire [10 : 0] douta
);
//      kernel90
blk_mem_gen_2 kernel90 (
  .clka(clk),    // input wire clka
  .addra(addr1),  // input wire [4 : 0] addra
  .douta(data2)  // output wire [10 : 0] douta
);
//      kernel135
blk_mem_gen_3 kernel135 (
  .clka(clk),    // input wire clka
  .addra(addr1),  // input wire [4 : 0] addra
  .douta(data3)  // output wire [10 : 0] douta
);
//      kernel180
blk_mem_gen_4 kernel180 (
  .clka(clk),    // input wire clka
  .addra(addr1),  // input wire [4 : 0] addra
  .douta(data4)  // output wire [10 : 0] douta
);
//      output 45 kernel
blk_mem_gen_5 outkernel45 (
  .clka(clk),    // input wire clka
  .ena(1'b0),      // input wire ena
  .wea(1'b1),      // input wire [0 : 0] wea
  .addra(addr2),  // input wire [17 : 0] addra
  .dina(k45),    // input wire [7 : 0] dina
  .douta( )  // output wire [7 : 0] douta
);
//      module for extracting bram values

always@(posedge clk) begin
    if(v<(KERNEL_LENGTH**2)) begin
        kernel1[v] = data1;
        kernel2[v] = data2;
        kernel3[v] = data3;
        kernel4[v] = data4;
        v=v+1;
        addr1 = addr1 + 1;
    end
    flag2 = 1'b1;
end

always@(posedge clk) begin   
    
     if(t<509)
    begin
        if(u<509)
        begin
           
            if(h<5)
            begin
                addr = t*IMAGE_WIDTH +u+h;
                arr[o+h] = data;
                h=h+1;
            end
               
           else
           begin
            if(m<5)
                begin
                    addr = ((t+1)*(IMAGE_WIDTH)) +u + m;
                    arr[o+m+5] = data;
                    m=m+1;
                end
            else if(n<5)
                begin    
                    addr = ((t+2)*(IMAGE_WIDTH)) +u + n;
                    arr[o+n+10] = data;
                    n=n+1;
                end
               
             else if(p<5)
                begin    
                    addr = ((t+3)*(IMAGE_SIZE)) +u + p;
                    arr[p+o+15] = data;
                    p=p+1;
                end
               
             else if(q<5)
                begin    
                    addr = ((t+4)*(IMAGE_WIDTH)) +u + q;
                    arr[o+q+20] = data;
                    q=q+1;
                end
             end  
             
             if( h=='d5 && m=='d5 && n=='d5 && p=='d5 && q=='d5)
                begin
                    flag1 = 1'b1;
                    h=0;
                    m=0;
                    n=0;
                    p=0;
                    q=0;
                    u=u+1;
                    
                    for (a1=0; a1<(KERNEL_LENGTH**2); a1 = a1+1) begin
                    img_pixel[a1] = {1'b0,arr[a1]};
                    end 
               
                    if(u>508)begin
                        u=0;
                        t=t+1;
                      end                
                  end                           
            end    
          end
 
end
//      main module
always @ (posedge clk) begin

for(w=0; w<IMAGE_WIDTH; w=w+1) begin
    for(z=0; z<IMAGE_WIDTH; z=z+1) begin
   if((flag1 == 1'b1) & (flag2 == 1'b1)) begin

    for(a=0;a<(KERNEL_LENGTH**2); a=a+1) begin
//      sort_algorithm
        kernel[0] = kernel1[a];
        kernel[1] = kernel2[a];
        kernel[2] = kernel3[a];
        kernel[3] = kernel4[a];
        in[39:0] = { kernel[0][KERNEL_SIZE-2:0], kernel[1][KERNEL_SIZE-2:0], kernel[2][KERNEL_SIZE-2:0], kernel[3][KERNEL_SIZE-2:0]};    

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

//      convolution_algorithm
        for (e=0;e<NUM_VALS; e=e+1) begin

            img_tmp = {9'b0, img_pixel[a][IMAGE_SIZE-2:0]};
            kernel_diff = (e==0) ? (sort_out[e][KERNEL_SIZE-2:0]) : (sort_out[e][KERNEL_SIZE-2:0] - sort_out[e-1][KERNEL_SIZE-2:0]);

            for (f=0; f<KERNEL_SIZE-1; f=f+1) begin
                if (kernel_diff[f] == 1'b0)begin
                    res_tmp = res_tmp + 0;
                end
                else begin
                    res_tmp = res_tmp + (img_tmp << f);
                end
            end

            res[e] = ((img_pixel[a][IMAGE_SIZE-1])^(sort_out[e][KERNEL_SIZE-1])) ? ({1'b1, res_tmp}) : ({1'b0, res_tmp});
            
            case(sel[e])
            2'b00: final_tmp[0] = (res[e] >> 9);
            2'b01: final_tmp[1] = (res[e] >> 9);
            2'b10: final_tmp[2] = (res[e] >> 9);
            2'b11: final_tmp[3] = (res[e] >> 9);
            endcase
                          
        end
        
        res_tmp = 'd0;        
        
        if (final_res45[KERNEL_SIZE+IMAGE_SIZE-1] ^ final_tmp[0][KERNEL_SIZE+IMAGE_SIZE-1]) begin
            if(final_res45[KERNEL_SIZE+IMAGE_SIZE-2:0] > final_tmp[0][KERNEL_SIZE+IMAGE_SIZE-2:0]) begin
                final_res45 = {final_res45[KERNEL_SIZE+IMAGE_SIZE-1], (final_res45[KERNEL_SIZE+IMAGE_SIZE-2:0] - final_tmp[0][KERNEL_SIZE+IMAGE_SIZE-2:0])};
            end  
            else begin
                final_res45 = {final_tmp[0][KERNEL_SIZE+IMAGE_SIZE-1], (final_tmp[0][KERNEL_SIZE+IMAGE_SIZE-2:0] - final_res45[KERNEL_SIZE+IMAGE_SIZE-2:0])};
            end
        end
        else begin
            final_res45 = {final_res45[KERNEL_SIZE+IMAGE_SIZE-1], (final_res45[KERNEL_SIZE+IMAGE_SIZE-2:0] + final_tmp[0][KERNEL_SIZE+IMAGE_SIZE-2:0])};
        end
        
        if (final_res90[KERNEL_SIZE+IMAGE_SIZE-1] ^ final_tmp[1][KERNEL_SIZE+IMAGE_SIZE-1]) begin
            if(final_res90[KERNEL_SIZE+IMAGE_SIZE-2:0] > final_tmp[1][KERNEL_SIZE+IMAGE_SIZE-2:0]) begin
                final_res90 = {final_res90[KERNEL_SIZE+IMAGE_SIZE-1], (final_res90[KERNEL_SIZE+IMAGE_SIZE-2:0] - final_tmp[1][KERNEL_SIZE+IMAGE_SIZE-2:0])};
            end  
            else begin
                final_res90 = {final_tmp[1][KERNEL_SIZE+IMAGE_SIZE-1], (final_tmp[1][KERNEL_SIZE+IMAGE_SIZE-2:0] - final_res90[KERNEL_SIZE+IMAGE_SIZE-2:0])};
            end
        end
        else begin
            final_res90 = {final_res90[KERNEL_SIZE+IMAGE_SIZE-1], (final_res90[KERNEL_SIZE+IMAGE_SIZE-2:0] + final_tmp[1][KERNEL_SIZE+IMAGE_SIZE-2:0])};
        end
        
        if (final_res135[KERNEL_SIZE+IMAGE_SIZE-1] ^ final_tmp[2][KERNEL_SIZE+IMAGE_SIZE-1]) begin
            if(final_res135[KERNEL_SIZE+IMAGE_SIZE-2:0] > final_tmp[2][KERNEL_SIZE+IMAGE_SIZE-2:0]) begin
                final_res135 = {final_res135[KERNEL_SIZE+IMAGE_SIZE-1], (final_res135[KERNEL_SIZE+IMAGE_SIZE-2:0] - final_tmp[2][KERNEL_SIZE+IMAGE_SIZE-2:0])};
            end  
            else begin
                final_res135 = {final_tmp[2][KERNEL_SIZE+IMAGE_SIZE-1], (final_tmp[2][KERNEL_SIZE+IMAGE_SIZE-2:0] - final_res135[KERNEL_SIZE+IMAGE_SIZE-2:0])};
            end
        end
        else begin
            final_res135 = {final_res135[KERNEL_SIZE+IMAGE_SIZE-1], (final_res135[KERNEL_SIZE+IMAGE_SIZE-2:0] + final_tmp[2][KERNEL_SIZE+IMAGE_SIZE-2:0])};
        end
        
        if (final_res180[KERNEL_SIZE+IMAGE_SIZE-1] ^ final_tmp[3][KERNEL_SIZE+IMAGE_SIZE-1]) begin
            if(final_res180[KERNEL_SIZE+IMAGE_SIZE-2:0] > final_tmp[3][KERNEL_SIZE+IMAGE_SIZE-2:0]) begin
                final_res180 = {final_res180[KERNEL_SIZE+IMAGE_SIZE-1], (final_res180[KERNEL_SIZE+IMAGE_SIZE-2:0] - final_tmp[3][KERNEL_SIZE+IMAGE_SIZE-2:0])};
            end  
            else begin
                final_res180 = {final_tmp[3][KERNEL_SIZE+IMAGE_SIZE-1], (final_tmp[3][KERNEL_SIZE+IMAGE_SIZE-2:0] - final_res180[KERNEL_SIZE+IMAGE_SIZE-2:0])};
            end
        end
        else begin
            final_res180 = {final_res180[KERNEL_SIZE+IMAGE_SIZE-1], (final_res180[KERNEL_SIZE+IMAGE_SIZE-2:0] + final_tmp[3][KERNEL_SIZE+IMAGE_SIZE-2:0])};
        end
        
    end     
    
    k45 = (final_res45[KERNEL_SIZE+IMAGE_SIZE-1])?  ('d0) : (final_res45[IMAGE_SIZE-1:0]);
    k90 = (final_res90[KERNEL_SIZE+IMAGE_SIZE-1])?  ('d0) : (final_res90[IMAGE_SIZE-1:0]);
    k135 = (final_res135[KERNEL_SIZE+IMAGE_SIZE-1])?  ('d0) : (final_res135[IMAGE_SIZE-1:0]);
    k180 = (final_res180[KERNEL_SIZE+IMAGE_SIZE-1])?  ('d0) : (final_res180[IMAGE_SIZE-1:0]);
    
    addr2 = addr2+1;
    

//    file1 = $fopen("output_circle512_45.txt", "w");
//        for(x=0; x<IMAGE_HEIGHT; x=x+1) begin
//            for(y=0; y<IMAGE_WIDTH; y=y+1) begin
//                $fwrite(file1, "%d\n", k45[x][y]);
//            end
//        end
//        $fclose(file1);

    flag1=0;
end
end
end
end
endmodule