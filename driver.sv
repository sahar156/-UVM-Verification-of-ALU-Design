`ifndef flag
`include "sequence_item.sv"
`endif

`ifndef flagi
`include "interface.sv"
`endif

`define flagd 1
class alu_driver extends uvm_driver;
  `uvm_component_utils(alu_driver)
  
  virtual alu_interface vif; 


  alu_sequence_item item;
  
  
  //costructor
  function new(string name = "alu_driver" , uvm_component parent);
    super.new(name,parent);
    `uvm_info("DRIVER_CLASS" , "Inside constructor" , UVM_HIGH)
    
  endfunction
  
function void build_phase(uvm_phase phase);
    super.build_phase(phase);
`uvm_info("DRIVER_CLASS" , "Build phase" , UVM_HIGH)
     if(!uvm_config_db#(virtual alu_interface)::get(this, "", "vif", vif))
       `uvm_fatal("NO_VIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
  endfunction: build_phase
  
  //build phase
//  function void build_phase(uvm_phase phase);
//    super.build_phase(phase);
//    `uvm_info("DRIVER_CLASS" , "Build phase" , UVM_HIGH)
//    
//    if(!(uvm_config_db #(virtual alu_interface)::get(this, "*" , "vif" , vif))) begin
//      `uvm_error("DRIVER_CLASS" , "failed to get vif from config db")
//    end
       
    
 // endfunction
  
  
  //connect phase
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("DRIVER_CLASS" , "Connect phase" , UVM_HIGH)
    
  endfunction
  
  
  //run phase
  task run_phase (uvm_phase phase);
    super.run_phase(phase);
    
    `uvm_info("DRIVER_CLASS" , "Run phase" , UVM_HIGH)

    forever begin

      item = alu_sequence_item::type_id::create("item"); 
      seq_item_port.get_next_item(item);
      drive(item);
      seq_item_port.item_done();

    end
    endtask


    //drive task
  task drive(alu_sequence_item item); 
    @(posedge vif.clk)
        vif.rst <= item.rst;
        vif.srcCy <= item.srcCy;
        vif.srcAc <= item.srcAc;
        vif.op_code <= item.op_code;
        vif.bit_in <= item.bit_in;
        vif.src1 <= item.src1;
        vif.src2 <= item.src2;
        vif.src3 <= item.src3;
    
    
  endtask
  
endclass