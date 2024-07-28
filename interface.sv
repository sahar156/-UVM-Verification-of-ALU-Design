`define flagi 1
interface alu_interface (input logic clk);
  logic rst;
  
logic        srcCy, srcAc, bit_in;
logic  [3:0] op_code;
logic  [7:0] src1, src2, src3;
bit       desCy, desAc, desOv;
logic [7:0] des1, des2, des_acc, sub_result;
  
endinterface: alu_interface