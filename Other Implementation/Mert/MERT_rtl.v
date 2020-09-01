module MERT_rtl(A,B,R);
parameter q = 32'd2181040129;//2^31+2^25+2^11+1
input [31:0] A,B;
output [31:0] R;
wire [63:0] C;
wire [10:0]Cptemp;
wire [11:0]Cp;
wire [31:0] R1temp;
wire [53:0] R1;

wire [10:0]R1ptemp;
wire [11:0]R1p;
wire [31:0] R2temp;
wire [43:0] R2;

wire [10:0]R2ptemp;
wire [11:0]R2p;
wire [31:0] T1temp;
wire [32:0] T1;
wire [31:0] T4;
mul #(.n(32),.m(32))mul0(.A(A), .B(A), .P(C));

assign Cptemp=~C[10:0];

RCA #(.n(11))add1(.A(Cptemp), .B(11'd1), .Ci(1'b0), .Co(Cp[11]),.S(Cp[10:0]));
mul #(.n(11),.m(21))mul1(.A(Cp[10:0]), .B(q[31:11]), .P(R1temp));
RCA #(.n(53))add2(.A({21'd0,R1temp}), .B(C[63:11]), .Ci(C[10]||Cp[10]),.Co(R1[53]), .S(R1[52:0]));

assign R1ptemp=~R1[10:0];

RCA #(.n(11))add3(.A(R1ptemp), .B(11'd1), .Ci(1'b0), .Co(R1p[11]),.S(R1p[10:0]));
mul #(.n(11),.m(21))mul2(.A(R1p[10:0]), .B(q[31:11]), .P(R2temp));
RCA #(.n(43))add4(.A({11'd0,R2temp}), .B(R1[53:11]), .Ci(R1[10]||R1p[10]),.Co(R2[43]), .S(R2[42:0]));

assign R2ptemp=~R2[10:0];

RCA #(.n(11))add5(.A(R2ptemp), .B(11'd1), .Ci(1'b0), .Co(R2p[11]),.S(R2p[10:0]));
mul #(.n(11),.m(21))mul3(.A(R2p[10:0]), .B(q[31:11]), .P(T1temp));
RCA #(.n(32))add6(.A(T1temp), .B(R2[42:11]), .Ci(R2[10]||R2p[10]),.Co(T1[32]), .S(T1[31:0]));

sub #(.n(32))sub1(.A(T1[31:0]), .B(q), .S(T4));

assign R=(T4[31])?T1[31:0]:T4;


endmodule 
