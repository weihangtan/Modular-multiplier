/* 
 * Author:        Weihang Tan
 Notes:
 1. This is the top-level module
 2. Set the parameter v, v1, v2 and Q
 3. If v1-v2=1, then replace the module "exp_re" in Line 52, 59, 60 as "exp_re_eli", as well as "exp_re_eli.v" file when doing the synthesis
 4. For behavior level implementation, please refer "km_b.v"
 5. If e = -1, use the subtractor in Line 12 in "exp_re_eli.v", otherwise use the adder in Line 13.
*/
module km_rtl(a,b,p);
parameter v = 16;
parameter v1 = 14;
parameter v2 = 12;
parameter Q = 32'd4294955009;//2^(2*16) - 2^13 + 2^12 + 1
//parameter Q = 14'd16381;//2^(2*7) - 2^3 + 2^2 + 1
//parameter Q = 24'd16777213;//2^(2*12) - 2^3 + 2^2 + 1
input [2*v-1:0] a,b;
output [2*v-1:0] p;

wire [v-1:0] a1,a0;
wire [v-1:0] b1,b0;
wire [v:0] a1_1,b1_1;
wire [2*v-1:0] c0,c1;
wire [2*v+1:0] c2,c02;
//reg [2*v-1:0] c0_r,c1_r;
//reg [2*v+1:0] c2_r;
wire [2*v:0] c01;
wire [3*v+1:0] c02b;
wire [2*v+v1-1:0] c1_re;
wire [3*v+1:0] c;
wire c_o;
wire [v+v1-1:0] f1;
wire [2+v1-1:0] f2;
wire [2*v:0] f;
wire [2*v:0] f_temp;
wire [2*v+v1:0] c00;//sum c
wire [2+v1+v:0] f11;//sum f
//semi-Karatsuba Multiplication
assign a0 = a[v-1:0];
assign a1 = a[2*v-1:v];
assign b0 = b[v-1:0];
assign b1 = b[2*v-1:v];

mul #(.n(v),.m(v))mul_inst1(.A(b0), .B(a0), .P(c0));//c0 = b0 * a0;
mul #(.n(v),.m(v))mul_inst2(.A(a1), .B(b1), .P(c1));//c1 = b1 * a1;
RCA #(.n(v))add1(.A(a0), .B(a1), .Ci(1'b0), .Co(a1_1[v]), .S(a1_1[v-1:0]));//a1_1 = a1 + a0;
RCA #(.n(v))add2(.A(b0), .B(b1), .Ci(1'b0), .Co(b1_1[v]), .S(b1_1[v-1:0]));//b1_1 = b1 + b0;
mul #(.n(v+1),.m(v+1))mul_inst3(.A(a1_1), .B(b1_1), .P(c2));//c2 = a1_1 * b1_1;

//-----------------------
//Modular Reduction

RCA #(.n(2*v))add3(.A(c0), .B(c1), .Ci(1'b0), .Co(c01[2*v]), .S(c01[2*v-1:0]));//c01 = c0 + c1
sub #(.n(2*v+2))sub4(.A(c2),.B({1'b0,c01}),.S(c02));//c02 = c2 + c01
assign c02b = {c02,{v{1'b0}}};
exp_re  #(.l(2*v),.v1(v1),.v2(v2)) c1_re_inst(.x(c1),.y(c1_re)); 

//assign c = (c0 + c1_re) + c02b; 
RCA #(.n(2*v+v1))add5(.A({{(v1){1'b0}},c0}), .B(c1_re), .Ci(1'b0), .Co(c00[2*v+v1]), .S(c00[2*v+v1-1:0]));
RCA #(.n(3*v+2))add6(.A({{(v-v1+1){1'b0}},c00}), .B(c02b), .Ci(1'b0), .Co(c_o), .S(c)); 


exp_re  #(.l(v),.v1(v1),.v2(v2)) f1_inst(.x(c[3*v-1:2*v]),.y(f1)); 
exp_re  #(.l(2),.v1(v1),.v2(v2)) f2_inst(.x(c[3*v+1:3*v]),.y(f2)); 

//assign f = c[2*v-1:0] + f1 + {f2,{v{1'b0}}};
RCA #(.n(2+v1+v))add7(.A({2'b0,f1}), .B({f2,{v{1'b0}}}), .Ci(1'b0), .Co(f11[2+v1+v]), .S(f11[2+v1+v-1:0])); 
RCA #(.n(2*v))add8(.A(c[2*v-1:0]), .B({{(2*v-v-3-v1){1'b0}},f11}), .Ci(1'b0), .Co(f[2*v]), .S(f[2*v-1:0]));

sub #(.n(2*v+1))sub9(.A(f),.B({1'b0,Q}),.S(f_temp));
assign p = (f>=Q) ? f_temp[2*v-1:0] : f[2*v-1:0];
 
endmodule
