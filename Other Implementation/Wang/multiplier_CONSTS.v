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

module multiplier_CONSTS
  #(
   parameter WIDTH_IN = 32,
   parameter CONSTS = 3098553343,
   parameter CONSTS_WIDTH = 32
  )
 (
  input  wire                                      clk,
  input  wire signed [WIDTH_IN-1:0]                a, 
  output wire signed [WIDTH_IN+CONSTS_WIDTH-1:0]   p
  );
  
  //assign p = a*CONSTS;
 SignedMultiplier #(.n(WIDTH_IN),.m(WIDTH_IN+1))multi(.A(a), .B(CONSTS), .P(p));

endmodule // multiplier
