// synopsys translate_off
//`include "oc8051_timescale.v"
// synopsys translate_on
 `timescale 1ns/10ps



`include "oc8051_defines.v"
 
 
 
module oc8051_alu #(parameter DELAY = 1) (clk, rst, op_code, src1, src2, src3, srcCy, srcAc, bit_in, 
                  des1, des2, des_acc, desCy, desAc, desOv, sub_result);

 
input        srcCy, srcAc, bit_in, clk, rst;
input  [3:0] op_code;
input  [7:0] src1, src2, src3;
output       desCy, desAc, desOv;
output [7:0] des1, des2, des_acc, sub_result;
 
reg desCy, desAc, desOv;
reg [7:0] des1, des2, des_acc;
 
 
//
//add
//
wire [4:0] add1, add2, add3, add4;
wire [3:0] add5, add6, add7, add8;
wire [1:0] add9, adda, addb, addc;
 
//
//sub
//
wire [4:0] sub1, sub2, sub3, sub4;
wire [3:0] sub5, sub6, sub7, sub8;
wire [1:0] sub9, suba, subb, subc;
wire [7:0] sub_result;
 
//
//mul
//
  wire [7:0] mulsrc1, mulsrc2;
  wire mulOv;
  reg enable_mul;
 
//
//div
//
wire [7:0] divsrc1,divsrc2;
wire divOv;
reg enable_div;
 
//
//da
//
reg da_tmp, da_tmp1;
//reg [8:0] da1;
 
//
// inc
//
wire [15:0] inc, dec;
 
oc8051_multiply oc8051_mul1(.clk(clk), .rst(rst), .enable(enable_mul), .src1(src1), .src2(src2), .des1(mulsrc1), .des2(mulsrc2), .desOv(mulOv));
oc8051_divide oc8051_div1(.clk(clk), .rst(rst), .enable(enable_div), .src1(src1), .src2(src2), .des1(divsrc1), .des2(divsrc2), .desOv(divOv));
 
/* Add */
assign add1 = {1'b0,src1[3:0]};
assign add2 = {1'b0,src2[3:0]};
assign add3 = {3'b000,srcCy};
assign add4 = add1+add2+add3;
 
assign add5 = {1'b0,src1[6:4]};
assign add6 = {1'b0,src2[6:4]};
assign add7 = {1'b0,1'b0,1'b0,add4[4]};           
assign add8 = add5+add6+add7;                     
                                                  
assign add9 = {1'b0,src1[7]};
assign adda = {1'b0,src2[7]};
assign addb = {1'b0,add8[3]};
assign addc = add9+adda+addb;
 
/* Sub */
assign sub1 = {1'b1,src1[3:0]};
assign sub2 = {1'b0,src2[3:0]};
assign sub3 = {1'b0,1'b0,1'b0,srcCy};   
assign sub4 = sub1-sub2-sub3;
 
assign sub5 = {1'b1,src1[6:4]};
assign sub6 = {1'b0,src2[6:4]};
assign sub7 = {1'b0,1'b0,1'b0, !sub4[4]};   
assign sub8 = sub5-sub6-sub7;
 
assign sub9 = {1'b1,src1[7]};
assign suba = {1'b0,src2[7]};
assign subb = {1'b0,!sub8[3]};
assign subc = sub9-suba-subb;
 
assign sub_result = {subc[0],sub8[2:0],sub4[3:0]};
 
/* inc */
assign inc = {src2, src1} + {15'h0, 1'b1};
assign dec = {src2, src1} - {15'h0, 1'b1};
 
always @(op_code or src1 or src2 or srcCy or srcAc or bit_in or src3 or mulsrc1
      or mulsrc2 or mulOv or divsrc1 or divsrc2 or divOv or addc or add8 or add4
      or sub4 or sub8 or subc or da_tmp or inc or dec or sub_result)
begin
 
  case (op_code) /* synopsys full_case parallel_case */
//operation add
    `OC8051_ALU_ADD: begin
      des_acc = {addc[0],add8[2:0],add4[3:0]};
      des1 = src1;
      des2 = src3+ {7'b0, addc[1]};
      desCy = addc[1];
      desAc = add4[4];
      desOv = addc[1] ^ add8[3];
 
      enable_mul = 1'b0;
      enable_div = 1'b0;
    end
//operation subtract
    `OC8051_ALU_SUB: begin
      des_acc = sub_result;
//      des1 = sub_result;
      des1 = 8'h00;
      des2 = 8'h00;
      desCy = !subc[1];
      desAc = !sub4[4];
      desOv = !subc[1] ^ !sub8[3];
 
      enable_mul = 1'b0;
      enable_div = 1'b0;
    end
//operation multiply
    `OC8051_ALU_MUL: begin
      des_acc = mulsrc1;
      des1 = src1;
      des2 = mulsrc2;
      desOv = mulOv;
      desCy = 1'b0;
      desAc = 1'b0;
      enable_mul = 1'b1;
      enable_div = 1'b0;
    end
//operation divide
    `OC8051_ALU_DIV: begin
      des_acc = divsrc1;
      des1 = src1;
      des2 = divsrc2;
      desOv = divOv;
      desAc = 1'b0;
      desCy = 1'b0;
      enable_mul = 1'b0;
      enable_div = 1'b1;
    end
//operation decimal adjustment
    `OC8051_ALU_DA: begin
 
      if (srcAc==1'b1 | src1[3:0]>4'b1001) {da_tmp, des_acc[3:0]} = {1'b0, src1[3:0]}+ 5'b00110;
      else {da_tmp, des_acc[3:0]} = {1'b0, src1[3:0]};
 
      if (srcCy | da_tmp | src1[7:4]>4'b1001)
        {da_tmp1, des_acc[7:4]} = {srcCy, src1[7:4]}+ 5'b00110 + {4'b0, da_tmp};
      else {da_tmp1, des_acc[7:4]} = {srcCy, src1[7:4]} + {4'b0, da_tmp};
 
      desCy = da_tmp | da_tmp1;
      des1 = src1;
      des2 = 8'h00;
      desAc = 1'b0;
      desOv = 1'b0;
      enable_mul = 1'b0;
      enable_div = 1'b0;
    end
//operation not
// bit operation not
    `OC8051_ALU_NOT: begin
      des_acc = ~src1;
      des1 = ~src1;
      des2 = 8'h00;
      desCy = !srcCy;
      desAc = 1'b0;
      desOv = 1'b0;
      enable_mul = 1'b0;
      enable_div = 1'b0;
    end
//operation and
//bit operation and
    `OC8051_ALU_AND: begin
      des_acc = src1 & src2;
      des1 = src1 & src2;
      des2 = 8'h00;
      desCy = srcCy & bit_in;
      desAc = 1'b0;
      desOv = 1'b0;
      enable_mul = 1'b0;
      enable_div = 1'b0;
    end
//operation xor
// bit operation xor
    `OC8051_ALU_XOR: begin
      des_acc = src1 ^ src2;
      des1 = src1 ^ src2;
      des2 = 8'h00;
      desCy = srcCy ^ bit_in;
      desAc = 1'b0;
      desOv = 1'b0;
      enable_mul = 1'b0;
      enable_div = 1'b0;
    end
//operation or
// bit operation or
    `OC8051_ALU_OR: begin
      des_acc = src1 | src2;
      des1 = src1 | src2;
      des2 = 8'h00;
      desCy = srcCy | bit_in;
      desAc = 1'b0;
      desOv = 1'b0;
      enable_mul = 1'b0;
      enable_div = 1'b0;
    end
//operation rotate left
// bit operation cy= cy or (not ram)
    `OC8051_ALU_RL: begin
      des_acc = {src1[6:0], src1[7]};
      des1 = src1 ;
      des2 = 8'h00;
      desCy = srcCy | !bit_in;
      desAc = 1'b0;
      desOv = 1'b0;
      enable_mul = 1'b0;
      enable_div = 1'b0;
    end
//operation rotate left with carry and swap nibbles
    `OC8051_ALU_RLC: begin
      des_acc = {src1[6:0], srcCy};
      des1 = src1 ;
      des2 = {src1[3:0], src1[7:4]};
      desCy = src1[7];
      desAc = 1'b0;
      desOv = 1'b0;
      enable_mul = 1'b0;
      enable_div = 1'b0;
    end
//operation rotate right
    `OC8051_ALU_RR: begin
      des_acc = {src1[0], src1[7:1]};
      des1 = src1 ;
      des2 = 8'h00;
      desCy = srcCy & !bit_in;
      desAc = 1'b0;
      desOv = 1'b0;
      enable_mul = 1'b0;
      enable_div = 1'b0;
    end
//operation rotate right with carry
    `OC8051_ALU_RRC: begin
      des_acc = {srcCy, src1[7:1]};
      des1 = src1 ;
      des2 = 8'h00;
      desCy = src1[0];
      desAc = 1'b0;
      desOv = 1'b0;
      enable_mul = 1'b0;
      enable_div = 1'b0;
    end
//operation pcs Add
    `OC8051_ALU_INC: begin
      if (srcCy) begin
        des_acc = dec[7:0];
	des1 = dec[7:0];
        des2 = dec[15:8];
      end else begin
        des_acc = inc[7:0];
	des1 = inc[7:0];
        des2 = inc[15:8];
      end
      desCy = 1'b0;
      desAc = 1'b0;
      desOv = 1'b0;
      enable_mul = 1'b0;
      enable_div = 1'b0;
    end
//operation exchange
//if carry = 0 exchange low order digit
    `OC8051_ALU_XCH: begin
      if (srcCy)
      begin
        des_acc = src2;
        des1 = src2;
        des2 = src1;
      end else begin
        des_acc = {src1[7:4],src2[3:0]};
        des1 = {src1[7:4],src2[3:0]};
        des2 = {src2[7:4],src1[3:0]};
      end
      desCy = 1'b0;
      desAc = 1'b0;
      desOv = 1'b0;
      enable_mul = 1'b0;
      enable_div = 1'b0;
    end
    `OC8051_ALU_NOP: begin
      des_acc = src1;
      des1 = src1;
      des2 = src2;
      desCy = srcCy;
      desAc = srcAc;
      desOv = 1'b0;
      enable_mul = 1'b0;
      enable_div = 1'b0;
    end
  endcase
end
 
endmodule
