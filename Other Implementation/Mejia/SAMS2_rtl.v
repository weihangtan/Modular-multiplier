module SAMS2_rtl(a,b,p);
parameter v = 14;
parameter Q = 14'd12289;//2^(2*v) - 2^v1 + 2^v2 + 1
input [v-1:0] a,b;
output [v-1:0] p;

wire [2*v-1:0] x,y,t_temp;
wire [v:0] t;
wire [4:0] t1;
wire [6:0] t2;
wire [8:0] t3;
wire [10:0] t4;
wire [12:0] t5;
wire [v-1:0] y_temp,y1,y_temp1;
//assign x = a * b;
mul #(.n(v),.m(v))mul_inst1(.A(a), .B(b), .P(x));
//assign t = x[27:14] + x[27:16] + x[27:18] + x[27:20] + x[27:22] + x[27:24] + x[27:26];
RCA #(.n(4))add1(.A(x[27:24]), .B({2'd0,x[27:26]}), .Ci(1'b0), .Co(t1[4]), .S(t1[3:0]));
RCA #(.n(6))add2(.A(x[27:22]), .B({1'd0,t1}), .Ci(1'b0), .Co(t2[6]), .S(t2[5:0]));
RCA #(.n(8))add3(.A(x[27:20]), .B({1'd0,t2}), .Ci(1'b0), .Co(t3[8]), .S(t3[7:0]));
RCA #(.n(10))add4(.A(x[27:18]), .B({1'd0,t3}), .Ci(1'b0), .Co(t4[10]), .S(t4[9:0]));
RCA #(.n(12))add5(.A(x[27:16]), .B({1'd0,t4}), .Ci(1'b0), .Co(t5[12]), .S(t5[11:0]));
RCA #(.n(14))add6(.A(x[27:14]), .B({1'd0,t5}), .Ci(1'b0), .Co(t[14]), .S(t[13:0]));

//assign t_temp = t * Q;
mul #(.n(v),.m(v))mul_inst2(.A(t[v-1:0]), .B(Q), .P(t_temp));

//assign y = x - t_temp;
sub #(.n(2*v))sub1(.A(x),.B(t_temp[2*v-1:0]),.S(y));
sub #(.n(v))sub2(.A(y[v-1:0]),.B(Q),.S(y_temp));
assign y1 = (y>=Q) ? y_temp : y[v-1:0];
sub #(.n(v))sub3(.A(y1),.B(Q),.S(y_temp1));
assign p = (y1>=Q) ? y_temp1 : y1;
endmodule
