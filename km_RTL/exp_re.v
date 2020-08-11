module exp_re(x,y);
parameter l = 16;
parameter v1 = 3;
parameter v2 = 1;

input [l-1:0] x;
output [l+v1-1:0] y;

wire [v1+l-1:0] sub_re1;
wire carry;
//assign y = {x,{v1{1'b0}}} - {x,{v2{1'b0}}} - x;
//sub #(.n(v1+l))sub_inst1(.A({x,{v1{1'b0}}} ), .B({{(v1-v2){1'b0}},x,{v2{1'b0}}}), .S(sub_re1));
RCA #(.n(v1+l))add1(.A({x,{v1{1'b0}}}), .B({{(v1-v2){1'b0}},x,{v2{1'b0}}}), .Ci(1'b0), .Co(carry), .S(sub_re1));
sub #(.n(v1+l))sub_inst2(.A(sub_re1), .B({{v1{1'b0}},x}), .S(y));

endmodule
