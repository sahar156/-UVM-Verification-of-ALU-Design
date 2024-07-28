//object class
import uvm_pkg::*;
`include "uvm_macros.svh" 

`define flag 1

class alu_sequence_item extends uvm_sequence_item;
  `uvm_object_utils(alu_sequence_item)
  
  
  //inistantiation
rand logic rst;
  
rand logic        srcCy, srcAc, bit_in;
rand logic  [3:0] op_code;
rand logic  [7:0] src1, src2, src3;
 bit       desCy, desAc, desOv;
 logic [7:0] des1, des2, des_acc, sub_result;
  
  
  //default costraint
  
  constraint input1_c {src1 inside {[10:20]};}
  constraint input2_c {src2 inside {[10:20]};}
  constraint input3_c {src3 inside {[1:10]};}
  constraint input4_c {srcCy inside {0,1};}
  constraint input5_c {srcAc inside {0,1};}
  constraint input6_c {bit_in inside {0,1};}
  constraint op_code_c {op_code inside {0,1,2,3};}

 
  

  
  //constructor
  function new(string name = "alu_sequence_item");
    super.new(name);
    
    
  endfunction
  
endclass