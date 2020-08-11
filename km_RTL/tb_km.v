module tb_km();
parameter DELAY = 200;
parameter v = 16;
parameter v1 = 13;
parameter v2 = 12;
parameter Q = 32'd4294967291;

reg [2*v-1:0] a, b;
wire [2*v-1:0] resu;
reg [2*v:0] c_check;
//wire [14*64-1:0] vec1;
integer i;
km_rtl kk(.a(a), .b(b), .p(resu));
//always #(DELAY/2) clk=~clk; 	
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
