/* 
 * Copyright (C): 2020
 * Author:        Wen Wang <wen.wang.ww349@yale.edu>
 * Updated:       2020-04-11
 *          
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software Foundation,
 * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
*/

// pipelined reduce module
// this module takes in inputs:
  // op1:  signed 32-bit integer  
  // op2:  integer between [-q, q] 
// and returns:
  // res:  integer between [0, q]
// latency = 4 cycles

module mul_and_reduce_pipe
#(
  parameter COEFF_WIDTH = 31,
  parameter MULTIPLIER_WIDTH = 32,
  parameter PARAM_QINV = 587710463 ,
  parameter PARAM_Q = 856145921,
  parameter CONSTS_QINV_WIDTH = (PARAM_QINV > 31) ? 32 : (PARAM_QINV+1)
)
(
  input  wire                                  clk,
  input  wire                                  start, // one-clock high signal
  input  wire                                  rst,
  input  wire signed [COEFF_WIDTH-1:0]         op1,  
  input  wire signed [COEFF_WIDTH-1:0]         op2,   
  output reg  signed [COEFF_WIDTH-1:0]         result = {COEFF_WIDTH{1'b0}}, 
  output reg                                   busy = 1'b0,
  output wire                                  done // one-clock high signal
);

// buffered since reduce module will be shared among different functions, input ops can be a MUX 
wire signed [CONSTS_QINV_WIDTH-1:0] PARAM_QINV_wire;
assign PARAM_QINV_wire = PARAM_QINV;

wire signed [COEFF_WIDTH-1:0] PARAM_Q_wire;
assign PARAM_Q_wire = PARAM_Q;
 
wire signed [2*COEFF_WIDTH-1:0] mul_res_0; 
wire signed [MULTIPLIER_WIDTH+CONSTS_QINV_WIDTH-1:0] mul_res_1;
wire signed [MULTIPLIER_WIDTH+COEFF_WIDTH-1:0] mul_res_2;
reg signed [MULTIPLIER_WIDTH+COEFF_WIDTH-1:0] mul_res_2_buf = {(MULTIPLIER_WIDTH+COEFF_WIDTH){1'b0}};
 
wire signed [MULTIPLIER_WIDTH-1:0] mul_res_0_signed_32;
reg signed [MULTIPLIER_WIDTH-1:0] mul_res_1_signed_32 = {MULTIPLIER_WIDTH{1'd0}};
 
reg signed [2*COEFF_WIDTH-1:0] mul_res_0_buf_0 = {2*COEFF_WIDTH{1'b0}};
reg signed [2*COEFF_WIDTH-1:0] mul_res_0_buf_1 = {2*COEFF_WIDTH{1'b0}};
reg signed [2*COEFF_WIDTH-1:0] mul_res_0_buf_2 = {2*COEFF_WIDTH{1'b0}};
 
wire signed [2*MULTIPLIER_WIDTH:0] res_extend; 
wire signed [MULTIPLIER_WIDTH-1:0] res_extend_high;
wire signed [MULTIPLIER_WIDTH:0] res_extend_high_po;
wire signed [MULTIPLIER_WIDTH-1:0] res_extend_high_ne;
assign mul_res_0_signed_32 = mul_res_0_buf_0[MULTIPLIER_WIDTH-1:0];
//RCA #(.n(2*COEFF_WIDTH))add1(.A({1'd0,mul_res_2_buf}), .B(mul_res_0_buf_2), .Ci(1'b0), .Co(res_extend[2*MULTIPLIER_WIDTH]), .S(res_extend[2*MULTIPLIER_WIDTH-1:0]));

  
//always @(posedge clk) begin  

//  busy <= start ? 1'b1 :
//          done ? 1'b0 :
//          busy;
  
//  mul_res_0_buf_0 <= mul_res_0;
//  mul_res_0_buf_1 <= mul_res_0_buf_0;
//  mul_res_0_buf_2 <= mul_res_0_buf_1;

 

//  mul_res_2_buf <= mul_res_2; 
  
  // make sure the result is within range [0, q]

// result <= (res_extend_high < 0) ? {1'b1,res_extend_high_po[MULTIPLIER_WIDTH-1:0]} : 
 //           (res_extend_high > PARAM_Q) ? {1'b0,res_extend_high_ne[MULTIPLIER_WIDTH-1:0]}:
   //         res_extend_high; 
 
//end

//RCA #(.n(MULTIPLIER_WIDTH-1))add2(.A(res_extend_high[MULTIPLIER_WIDTH-1:0]), .B(31'd856145921), .Ci(1'b0), .Co(res_extend_high_po[MULTIPLIER_WIDTH]), .S(res_extend_high_po[MULTIPLIER_WIDTH-1:0]));
//sub #(.n(MULTIPLIER_WIDTH-1))sub1(.A(res_extend_high[MULTIPLIER_WIDTH-1:0]),.B(31'd856145921),.S(res_extend_high_ne[MULTIPLIER_WIDTH-1:0]));
multiplier #(.WIDTH_IN(COEFF_WIDTH)) multiplier_inst_0 (
  .clk(clk),
  .a(op1),
  .b(op2),
  .p(mul_res_0)  
  );
assign mul_res_0_buf_2 = mul_res_0;
multiplier_CONSTS #(.WIDTH_IN(MULTIPLIER_WIDTH), .CONSTS(PARAM_QINV), .CONSTS_WIDTH(CONSTS_QINV_WIDTH)) multiplier_inst_1 (
  .clk(clk),
  .a(mul_res_0_signed_32), 
  .p(mul_res_1)  
  );
assign  mul_res_1_signed_32 = mul_res_1[MULTIPLIER_WIDTH-1:0]; 
multiplier_CONSTS #(.WIDTH_IN(MULTIPLIER_WIDTH), .CONSTS(PARAM_Q), .CONSTS_WIDTH(COEFF_WIDTH)) multiplier_inst_2 (
  .clk(clk),
  .a(mul_res_1_signed_32), 
  .p(mul_res_2)  
  );
assign mul_res_2_buf = mul_res_2;   
assign res_extend = (mul_res_2_buf + mul_res_0_buf_2);
assign res_extend_high = (res_extend[2*MULTIPLIER_WIDTH-1:0] >>> 32);

assign  result = (res_extend_high < 0) ? res_extend_high + PARAM_Q : 
            (res_extend_high > PARAM_Q) ? res_extend_high - PARAM_Q :
            res_extend_high; 
/*  
delay #(.WIDTH(1), .DELAY(4)) delay_inst_1(
  .clk(clk),
  .rst(rst),
  .din(start),
  .dout(done)
);
*/
endmodule  
