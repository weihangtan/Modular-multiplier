module tb_km();
parameter DELAY = 200;
parameter v = 18;
parameter v1 = 4;
parameter v2 = 3;
//parameter v_2 = 8'b00000000;
parameter v_2 = 5'd0;
parameter v1_2 = 4'd0;
parameter v2_2 = 3'd0;
parameter d_v1_2 = 1'd0;//the difference of v1, v2
//parameter Q = 16'd65477;
parameter Q = 10'd1017;

reg signed [31-1:0] a, b;
reg clk;
wire signed [31-1:0] resu, n2, n3, n4, n5;
wire busy,done;
reg [2*v:0] c_check;
//wire [14*64-1:0] vec1;
integer i;
//km kk(.a(a), .b(b), .f(resu),.clk(clk));
mul_and_reduce_pipe #(.COEFF_WIDTH(31),.MULTIPLIER_WIDTH(32),.PARAM_QINV(587710463),.PARAM_Q(856145921)) mul_and_reduce_pipe_inst (.clk(clk),.start(1'b1),.rst(1'b0),.op1(a), .op2(b),.result(resu), .busy(busy),.done(done) // one-clock high signal
);
always #(DELAY/2) clk=~clk; 	
initial begin
$dumpfile("test.vcd");
$dumpvars(0, tb_km);
end

initial begin
assign a = 35425252;
assign b = 23526262;
clk = 0;
assign c_check = a*b%Q;
	 	 $display("%d %d %d",a, b, resu);
	 
	 	 
	 	 
#10000;
$finish;

end


endmodule
