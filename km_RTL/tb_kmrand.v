module tb_adder;
//------------------define your input width here---------------//

`define WORD_LEN 14   //12 bit input

//-------------------------------------------------------------//


//-------------------define your test mode here----------------//

`define RANDOM        //use random case to generate test data

//-------------------------------------------------------------//


//`define FORLOOP     //uncomment this to use for loop test
//`define MANUAL

reg [`WORD_LEN-1:0] A, B;  //signed input
parameter Q = 14'd16381;
wire [`WORD_LEN-1:0] P;       
wire Cout;
//wire [`WORD_LEN*2-1:0] a1,b1;
reg [`WORD_LEN-1:0] check;    

integer    i, j;        // loop variables
integer    num_correct; // counter to keep track of the number correct
integer    num_wrong;   // counter to keep track of the number wrong



//------------------instantiate YOUR circuit here--------------//
// please use A,B as input, P as output



//-------------------------------------------------------------//



// simulation of  6000 random numbers
`ifdef RANDOM
km_rtl kk(.a(A), .b(B), .p(P));
initial begin
    num_correct = 0; num_wrong = 0;
	$dumpfile ("signal.vcd");
        $dumpvars(0,tb_adder);
repeat (30000) begin
    // get new operand values and compute a check value
    A = $urandom_range(16381,1); B = $urandom_range(16381,1);
   check = A * B % 16381;

    // compute and display the value every 10 time units
     //#10 $display($time, "  (%d * %d) = %b (%d)", A, B, P, check);

            #10 if (P == check)
                   num_correct = num_correct + 1;
                else
			begin
			num_wrong = num_wrong + 1;
			$display($time, "  %d * %d = %d (%d)", A, B, P, check);
			$display("A: %b; B: %b; output: %b, check: %b", A, B, P, check);
			end
end
    $display("num_correct = %d, num_wrong = %d", num_correct, num_wrong);
$finish;
end
`endif

/*
`ifdef MANUAL
initial begin
#20
A = 31; B = 31;
#20
$display($time, "  %d * %d = %d ", A, B, P);
A = 1000;B = 33;
#20
$display($time, "  %d * %d = %d ", A, B, P);
$finish;
end
`endif


`ifdef FORLOOP
// exhaustive checking
initial begin
   
    num_correct = 0; num_wrong = 0;
    Cin = 0;
    
    for (i = 0; i < 32; i = i + 1) begin
        A = i;
        for (j = 0; j < 32; j = j + 1) begin
            B = j;
            check = A * B;
 
            #10 if (P == check)
                   num_correct = num_correct + 1;
                else
			begin
			num_wrong = num_wrong + 1;
			$display($time, "  %d * %d = %d (%d)", A, B, P,check);
			end
        end
    end
 
    // print the final counter values
    $display("num_correct = %d, num_wrong = %d", num_correct, num_wrong);

$finish;
end
`endif
*/
endmodule


