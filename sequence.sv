//object class
import uvm_pkg::*;
`include "uvm_macros.svh"

`ifndef flag
`include "sequence_item.sv"
`endif

`define flagse 1
class alu_base_sequence extends uvm_sequence;
  `uvm_object_utils(alu_base_sequence)
  
  alu_sequence_item rst_pkt;
  
  function new(string name = "alu_base_sequence");
    super.new(name);
    `uvm_info("BASE_SEQ" , "Inside constructor" , UVM_HIGH)

    
  endfunction
  
  
  //body task
  task body();
    `uvm_info("BASE_SEQ" , "Inside body task" , UVM_HIGH)
    
    
    rst_pkt = alu_sequence_item::type_id::create("rst_pkt");
    
    start_item(rst_pkt);
    //rst_pkt.randomize() with {rst==1;};
    finish_item(rst_pkt);
    
  endtask
 
  
  
endclass : alu_base_sequence



class alu_test_sequence extends alu_base_sequence;
  `uvm_object_utils(alu_test_sequence)
  
  alu_sequence_item item;
  
  function new(string name = "alu_test_sequence");
    super.new(name);
    `uvm_info("TEST_SEQ" , "Inside constructor" , UVM_HIGH)

    
  endfunction
  
  
  //body task
  task body();
    `uvm_info("TEST_SEQ" , "Inside body task" , UVM_HIGH)
    
    
    item = alu_sequence_item::type_id::create("item");
    
    start_item(item);
    //item.randomize() with {rst==0;};
    finish_item(item);
    
  endtask
 
  
  
endclass