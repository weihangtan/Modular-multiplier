module km_b(a,b,p);
parameter v = 16;
parameter v1 = 13;
parameter v2 = 11;
parameter Q = 32'd4294957057;//2^(2*v) - 2^13 - 2^11 + 1
// parameter Q = 24'd16777213;//2^(2*v) - 2^v1 + 2^v2 + 1
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
wire [v+v1-1:0] f1;
wire [2+v1-1:0] f2;
wire [2*v:0] f;
//semi-Karatsuba Multiplication
assign a0 = a[v-1:0];
assign a1 = a[2*v-1:v];
assign b0 = b[v-1:0];
assign b1 = b[2*v-1:v];
assign a1_1 = a1 + a0;
assign b1_1 = b1 + b0;

assign c0 = b0 * a0;
assign c1 = b1 * a1;
assign c2 = a1_1 * b1_1;


//-----------------------
//Modular Reduction
assign c01 = c0 + c1;
assign c02 = c2 - c01;
assign c02b = {c02,{v{1'b0}}};
//assign c1_re = {c1,{v1{1'b0}}} - {c1,{v2{1'b0}}} - c1;
exp_re  #(.l(2*v),.v1(v1),.v2(v2)) c1_re_inst(.x(c1),.y(c1_re)); 
assign c = (c0 + c1_re) + c02b; 

exp_re  #(.l(v),.v1(v1),.v2(v2)) f1_inst(.x(c[3*v-1:2*v]),.y(f1)); 
exp_re  #(.l(2),.v1(v1),.v2(v2)) f2_inst(.x(c[3*v+1:3*v]),.y(f2)); 

assign f = c[2*v-1:0] + f1 + {f2,{v{1'b0}}};

assign p = (f>=Q) ? f-Q : f[2*v-1:0];
 
endmodule
