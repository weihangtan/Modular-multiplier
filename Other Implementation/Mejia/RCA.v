module RCA(A, B, Ci, Co, S);
parameter n = 2;
input [n-1:0] A, B;
input Ci;
output Co;
output [n-1:0] S;
wire[n:0] c;
assign c[0] = Ci;
assign Co = c[n];


genvar i;
    generate
        for(i =0; i < n; i = i +1) begin: addbit
            FA bitt(.a(A[i]), .b(B[i]),.ci(c[i]), .co(c[i+1]), .s(S[i]));
        end
    endgenerate

endmodule
