import uvm_pkg::*;
`include "uvm_macros.svh"

`ifndef flag
`include "sequence_item.sv" 
`endif

`define flags 1

class alu_sequencer extends uvm_sequencer;
  `uvm_component_utils(alu_sequencer)
  

  //constructor
  function new(string name = "alu_sequencer" , uvm_component parent);
    super.new(name,parent);
    `uvm_info("SEQUENCER_CLASS" , "Inside constructor" , UVM_HIGH)
    
  endfunction
  
  

  //build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("SEQUENCER_CLASS" , "Build phase" , UVM_HIGH)
    
  endfunction
  

  //connect phase
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("SEQUENCER_CLASS" , "Build phase" , UVM_HIGH)
    
  endfunction
  
  
  //run phase
  task run_phase (uvm_phase phase);
    super.run_phase(phase);
    
    
    
    
  endtask
  
endclass