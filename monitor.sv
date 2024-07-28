import uvm_pkg::*;
`include "uvm_macros.svh"

`ifndef flag
`include "sequence_item.sv" 
`endif

`ifndef flagi
`include "interface.sv"
`endif

`define flagm 1

class alu_monitor extends uvm_monitor;
  `uvm_component_utils(alu_monitor)
  
   virtual alu_interface vif; 

  alu_sequence_item item;


uvm_analysis_port #(alu_sequence_item) monitor_port;
  

  //constructor
  function new(string name = "alu_monitor" , uvm_component parent);
    super.new(name,parent);
    `uvm_info("MONITOR_CLASS" , "Inside constructor" , UVM_HIGH)
    
  endfunction

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
`uvm_info("MONITOR_CLASS" , "Build phase" , UVM_HIGH)
     if(!uvm_config_db#(virtual alu_interface)::get(this, "", "vif", vif))
       `uvm_fatal("NO_VIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
  endfunction: build_phase
  
  
  //build phase
//  function void build_phase(uvm_phase phase);
//    super.build_phase(phase);
//    `uvm_info("MONITOR_CLASS" , "Build phase" , UVM_HIGH)
//
//    monitor_port = new("monitor_port , this");
//    
//     if(!(uvm_config_db #(virtual alu_interface)::get(this, "*" , "vif" , vif))) begin
//      `uvm_error("MONITOR_CLASS" , "failed to get vif from config db")
//    end
    
 // endfunction
  
  
  //connect phase
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("MONITOR_CLASS" , "Build phase" , UVM_HIGH)
    
  endfunction
  
  
  //run phase
  task run_phase (uvm_phase phase);
    super.run_phase(phase);

    `uvm_info("MONITOR_CLASS" , "Run phase" , UVM_HIGH)

    forever begin

      item = alu_sequence_item::type_id::create("item"); 


      //sample inputs
      wait(!vif.rst);
      @(posedge vif.clk);
      item.srcCy = vif.srcCy;
      item.srcAc = vif.srcAc;
      item.op_code = vif.op_code;
      item.bit_in = vif.bit_in;
      item.src1 = vif.src1;
      item.src2 = vif.src2;
      item.src3 = vif.src3;

      //sample outputs
      @(posedge vif.clk);
      item.desCy = vif.desCy;
      item.desAc = vif.desAc;
      item.desOv = vif.desOv;
      item.des1 = vif.des1;
      item.des2 = vif.des2;
      item.des_acc = vif.des_acc;
      item.sub_result = vif.sub_result;

      //send item to scoreboard
      monitor_port.write(item);


    end
     
    
  endtask
  
endclass