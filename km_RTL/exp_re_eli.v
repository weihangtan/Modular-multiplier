module exp_re_eli(x,y);
parameter l = 16;
parameter v1 = 3;
parameter v2 = 1;

input [l-1:0] x;
output [l+v1-1:0] y;

wire [v1+l-1:0] sub_re1;
sub #(.n(v1+l))sub_inst1(.A({x,{v1{1'b0}}} ), .B({{v1{1'b0}},x}), .S(y));

endmodule
