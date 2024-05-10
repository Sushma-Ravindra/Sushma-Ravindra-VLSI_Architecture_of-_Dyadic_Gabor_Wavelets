module sort_tb;
    reg clk;
    wire [44-1:0] out;
    wire [7:0]z;

    sort #(.NUM_VALS(4), .SIZE(10)) dut (
        .clk(clk),
        .finalout(out),
        .z(z)
        
    );


   
    initial begin
        #100087;
        $finish;
    end

    always begin
        clk = 1'b0; #5;
        clk = 1'b1; #5;
end
endmodule
