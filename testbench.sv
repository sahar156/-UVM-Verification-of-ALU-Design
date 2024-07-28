`timescale 1ns/1ns

import uvm_pkg::*;
`include "uvm_macros.svh"

`ifndef flagi
`include "interface.sv"
`endif

`include "test.sv"

`ifndef flage
`include "env.sv"
`endif

`ifndef flaga
`include "agent.sv"
`endif

`ifndef flagd
`include "driver.sv"
`endif

`ifndef flagm
`include "monitor.sv"
`endif

`ifndef flags
`include "sequencer.sv" 
`endif

`ifndef flag
`include "sequence_item.sv" 
`endif

`ifndef flagse
`include "sequence.sv"
`endif

`ifndef flagsb
`include "scoreboard.sv"
`endif




module top;
  
  logic clk;
  
  alu_interface intf(.clk(clk));
  
  //instantiation
  oc8051_alu dut(.clk(intf.clk),.rst(intf.rst),.op_code(intf.op_code), .src1(intf.src1), .src2(intf.src2), .src3(intf.src3), .srcCy(intf.srcCy), .srcAc(intf.srcAc), .bit_in(intf.bit_in), .des1(intf.des1), .des2(intf.des2), .des_acc(intf.des_acc), .desCy(intf.desCy), .desAc(intf.desAc), .desOv(intf.desOv), .sub_result(intf.sub_result)
                );
  
  covergroup cvg @(posedge intf.clk) ;
    rst_cvp  : coverpoint  intf.rst ;
    
    src1_cvp : coverpoint intf.src1 ;
    src2_cvp : coverpoint intf.src2 ;
    src3_cvp : coverpoint intf.src3 ;
    srcCy_cvp : coverpoint intf.srcCy ;
    srcAc_cvp : coverpoint intf.srcAc ;
    bit_in_cvp : coverpoint intf.bit_in ; 
    

    op_code_cvp : coverpoint intf.op_code;

    des1_cvp : coverpoint intf.des1 ;
    des2_cvp : coverpoint intf.des2 ;
    des_acc_cvp : coverpoint intf.des_acc ;
    desCy_cvp : coverpoint intf.desCy ;
    desAc_cvp : coverpoint intf.desAc ;
    desOv_cvp : coverpoint intf.desOv ;
    sub_result_cvp : coverpoint intf.sub_result ;


endgroup

cvg cvg_inst=new();


//alu_interface intf(clk,rst); 
initial begin 
    uvm_config_db#(virtual alu_interface)::set(uvm_root::get(),"*","vif",intf);
  end


  //interface setting
//  initial begin
//    uvm_config_db #(virtual alu_interface)::set(null , "*", "vif" , intf);
//  end
  
  //start the test
  initial begin
    run_test("alu_test");
  end
  
  
  
  initial begin
    
    clk=0;
    #5;
    forever begin
      clk=!clk;
      #2;
    end
  end
  
  initial begin
    #5000;
    $display("ran out of clock cycles");
    $finish();
  end
  
  initial begin
    $dumpfile("d.vcd");
    $dumpvars();
  end
  
endmodule : top