


module mul(A, B, P);
parameter n = 2;
parameter m = 2;
input [n - 1 : 0] A;
input [m - 1 : 0] B;
output [m + n - 1:0] P;
wire [n + m - 2 : 0] S [m-1 : 0];
wire [n + m -2 : 0] Snew [m-1 : 0];
wire [m - 1 : 0] Carry;
assign Carry[0] = 1'b0;
assign Snew[0] = S[0];
assign P = {Carry[m-1], Snew[m-1]};

genvar i, j, k, l, z, x, v;
generate
    for(i = 0; i < m; i = i + 1)begin:one_gen
        for(j = i; (j-i) < n; j = j + 1)begin:one
            assign S[i][j] = A[j-i] & B[i];
        end
    end
    for(k = 1; k < m; k = k + 1)begin:two_gen
        for(l = 0 ; l < k; l = l + 1)begin:two
            assign S[k][l] = 1'b0;
        end
    end       
    for(z = 0; z < m; z = z + 1)begin:three_gen
        for (x = z + n; x < m + n - 1;  x= x + 1)begin:three
            assign S[z][x] = 1'b0;
         end
    end
    for(v =0; v < m - 1; v = v + 1) begin: addbit
        RCA #(m + n - 1) bittt(.A(Snew[v]),.B(S[v + 1]), .Ci(Carry[v]), .Co(Carry[v + 1]), .S(Snew[v + 1]));
    end
endgenerate
endmodule
