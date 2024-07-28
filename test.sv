import uvm_pkg::*;
`include "uvm_macros.svh"

`ifndef flage
`include "env.sv"
`endif

`ifndef flagse
`include "sequence.sv"
`endif

class alu_test extends uvm_test;
  `uvm_component_utils(alu_test)
  
  alu_env env;
  alu_base_sequence rst_seq;
  alu_test_sequence test_seq;
  
  //constructor
  function new(string name = "alu_test" , uvm_component parent);
    super.new(name,parent);
    `uvm_info("TEST_CLASS" , "Inside constructor" , UVM_HIGH)
    
  endfunction
  
  
  //build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("TEST_CLASS" , "Build phase" , UVM_HIGH)
    
    env = alu_env::type_id::create("env",this);
  endfunction
  
  
  
  //connect phase
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("TEST_CLASS" , "connect phase" , UVM_HIGH)

    //connect monitor with scoreboard

    
  endfunction
  
  
  //run phase
  task run_phase (uvm_phase phase);
    super.run_phase(phase);
    
    `uvm_info("TEST_CLASS" , "run phase" , UVM_HIGH)

    phase.raise_objection(this);
    //start sequences
    rst_seq = alu_base_sequence::type_id::create("rst_seq");
    rst_seq.start(env.agnt.seqr);
    
    repeat(100);
    test_seq = alu_test_sequence::type_id::create("test_seq");
    test_seq.start(env.agnt.seqr);
    #10
    
    phase.drop_objection(this);

    
    
  endtask
  
endclass