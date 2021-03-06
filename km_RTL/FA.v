module FA(a, b, ci, co, s);
input a, b, ci;
output co, s;

assign s = a ^ b ^ ci;
assign co = (a & b) |(a & ci) | (b & ci);
endmodule
