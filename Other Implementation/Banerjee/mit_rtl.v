module mit_rtl(a,b,p);
parameter v = 14;
parameter Q = 14'd12289;
parameter m = 14'd10921;
input [v-1:0] a,b;
output [v-1:0] p;

wire [2*v-1:0] x;
wire [3*v-1:0] t;
wire [2*v-1:0] z,t_temp1;
wire [2*v:0] t_temp;
wire [v-1:0] z_temp;
//assign x = a * b;
mul #(.n(v),.m(v))mul_inst1(.A(a), .B(b), .P(x));
//assign t = x * m;
mul #(.n(2*v),.m(v))mul_inst2(.A(x), .B(m), .P(t));

//assign t_temp = t[3*v-1:27]  + {t[3*v-1:27],12'd0} + {t[3*v-1:27],13'd0};
RCA #(.n(2*v-1))add1(.A({t[3*v-1:27],12'd0}), .B({12'd0,t[3*v-1:27]}), .Ci(1'b0), .Co(t_temp1[2*v-1]), .S(t_temp1[2*v-2:0]));
RCA #(.n(2*v))add2(.A(t_temp1), .B( {t[3*v-1:27],13'd0}), .Ci(1'b0), .Co(t_temp[2*v]), .S(t_temp[2*v-1:0]));


//assign z = x - t_temp;
sub #(.n(2*v))sub3(.A(x),.B(t_temp[2*v-1:0]),.S(z));
sub #(.n(v))sub4(.A(z[v-1:0]),.B(Q),.S(z_temp));
assign p = (z>=Q) ? z_temp : z[v-1:0];

endmodule
