module sub(A, B, S);

parameter n = 4;
input [n-1:0] A, B;
//output Co;
output [n-1:0] S;
wire[n:0] c;
assign c[0] = 0;
//assign Co = c[n];
genvar i;
    generate
        for(i =0; i < n; i = i +1) begin: subbit
            FS bittt(.a(A[i]), .b(B[i]),.ci(c[i]), .co(c[i+1]), .s(S[i]));
        end
    endgenerate



endmodule 
