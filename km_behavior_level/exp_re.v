module exp_re(x,y);
parameter l = 16;
parameter v1 = 3;
parameter v2 = 1;

input [l-1:0] x;
output [l+v1-1:0] y;

assign y = {x,{v1{1'b0}}} + {x,{v2{1'b0}}} - x;


endmodule