module tb_km();
parameter DELAY = 200;
parameter v = 7;
parameter v1 = 2;
parameter v2 = 1;
//parameter v_2 = 8'b00000000;
parameter v_2 = 5'd0;
parameter v1_2 = 4'd0;
parameter v2_2 = 3'd0;
parameter d_v1_2 = 1'd0;//the difference of v1, v2
//parameter Q = 16'd65477;
parameter Q = 32'd4294967291;

reg [2*v-1:0] a, b;
reg clk;
wire [2*v-1:0] resu, n2, n3, n4, n5;
reg [2*v:0] c_check;
//wire [14*64-1:0] vec1;
integer i;
km_b kk(.a(a), .b(b), .p(resu));
always #(DELAY/2) clk=~clk; 	
initial begin
$dumpfile("test.vcd");
$dumpvars(0, tb_km);
end

initial begin
assign a = 13333;
assign b = 2972;
clk = 0;
assign c_check = a*b%Q;
	 	 $display("%d %d %d",a, b, resu);
	 
	 	 
	 	 
#10000;
$finish;

end


endmodule
