import uvm_pkg::*;
`include "uvm_macros.svh"
`ifndef flag
`include "sequence_item.sv"
`endif


`define flagsb 1


class alu_scoreboard extends uvm_test;
  `uvm_component_utils(alu_scoreboard)
  
  
  uvm_analysis_imp #(alu_sequence_item, alu_scoreboard) scoreboard_port;
  
  alu_sequence_item transactions[$];

  //constructor
  function new(string name = "alu_scoreboard" , uvm_component parent);
    super.new(name,parent);
    `uvm_info("TEST_CLASS" , "Inside constructor" , UVM_HIGH)
    
  endfunction
  
  
  //build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("SCB_CLASS" , "Build phase" , UVM_HIGH)

    scoreboard_port = new("scoreboard_port" , this);
    
    //env = alu_env::type_id::create("env",this);
  endfunction
  
  
  
  //connect phase
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("SCB_CLASS" , "connect phase" , UVM_HIGH)

    //connect monitor with scoreboard

    
  endfunction



  //write method
  function void write(alu_sequence_item item);
  transactions.push_back(item);

  endfunction

  
  
  //run phase
  task run_phase (uvm_phase phase);
    super.run_phase(phase);
    
    `uvm_info("SCB_CLASS" , "run phase" , UVM_HIGH)

    forever begin
        


        alu_sequence_item curr_trans;
        wait((transactions.size() != 0));
      curr_trans = transactions.pop_front();
      compare(curr_trans);
    end

    
    
  endtask

  task compare(alu_sequence_item curr_trans);
    logic [7:0] expected1,expected2,expected3;
    bit         expected4,expected5,expected6,da_tmp,da_tmp1;
    logic [7:0] actual1,actual2,actual3;
    logic       actual4,actual5,actual6;
    
    case(curr_trans.op_code)
      //0: begin //operation add
      //  expected1 = {({1'b0,curr_trans.src1[7]}+{1'b0,curr_trans.src2[7]}+{1'b0,({1'b0,curr_trans.src1[6:4]}+{1'b0,curr_trans.src2[6:4]}+{1'b0,1'b0,1'b0,({1'b0,curr_trans.src1[3:0]}+{1'b0,curr_trans.src2[3:0]}+{3'b000,curr_trans.srcCy})[4]})[3]})[0],({1'b0,curr_trans.src1[6:4]}+{1'b0,curr_trans.src2[6:4]}+{1'b0,1'b0,1'b0,({1'b0,curr_trans.src1[3:0]}+{1'b0,curr_trans.src2[3:0]}+{3'b000,curr_trans.srcCy})[4]})[2:0],({1'b0,curr_trans.src1[3:0]}+{1'b0,curr_trans.src2[3:0]}+{3'b000,curr_trans.srcCy})[3:0]};
        
     // expected2 = curr_trans.src1;
        
     // expected3 = curr_trans.src3+ {7'b0, ({1'b0,curr_trans.src1[7]}+{1'b0,curr_trans.src2[7]}+{1'b0,({1'b0,curr_trans.src1[6:4]}+{1'b0,curr_trans.src2[6:4]}+{1'b0,1'b0,1'b0,({1'b0,curr_trans.src1[3:0]}+{1'b0,curr_trans.src2[3:0]}+{3'b000,curr_trans.srcCy})[4]})[3]})[1]};
     // expected4 = ({1'b0,curr_trans.src1[7]}+{1'b0,curr_trans.src2[7]}+{1'b0,({1'b0,curr_trans.src1[6:4]}+{1'b0,curr_trans.src2[6:4]}+{1'b0,1'b0,1'b0,({1'b0,curr_trans.src1[3:0]}+{1'b0,curr_trans.src2[3:0]}+{3'b000,curr_trans.srcCy})[4]})[3]})[1];
     // expected5 = ({1'b0,curr_trans.src1[3:0]}+{1'b0,curr_trans.src2[3:0]}+{3'b000,curr_trans.srcCy})[4];
      
      //expected6 = ({1'b0,curr_trans.src1[7]}+{1'b0,curr_trans.src2[7]}+{1'b0,({1'b0,curr_trans.src1[6:4]}+{1'b0,curr_trans.src2[6:4]}+{1'b0,1'b0,1'b0,({1'b0,curr_trans.src1[3:0]}+{1'b0,curr_trans.src2[3:0]}+{3'b000,curr_trans.srcCy})[4]})[3]})[1] ^ ({1'b0,curr_trans.src1[6:4]}+{1'b0,curr_trans.src2[6:4]}+{1'b0,1'b0,1'b0,({1'b0,curr_trans.src1[3:0]}+{1'b0,curr_trans.src2[3:0]}+{3'b000,curr_trans.srcCy})[4]})[3];
     // end

      1: begin //operation subtract
        expected1 = curr_trans.sub_result;

      expected2 = 8'h00;
      expected3 = 8'h00;
      //expected4 = !({1'b1,curr_trans.src1[7]}-{1'b0,curr_trans.src2[7]}-{1'b0,!({1'b1,curr_trans.src1[6:4]}-{1'b0,curr_trans.src2[6:4]}-{1'b0,1'b0,1'b0, !({1'b1,curr_trans.src1[3:0]}-{1'b0,curr_trans.src2[3:0]}-{1'b0,1'b0,1'b0,curr_trans.srcCy})[4]})[3]}[1])[1];
     // expected5 = !({1'b1,curr_trans.src1[3:0]}-{1'b0,curr_trans.src2[3:0]}-{1'b0,1'b0,1'b0,curr_trans.srcCy})[4];
      //expected6 = !({1'b1,curr_trans.src1[7]}-{1'b0,curr_trans.src2[7]}-{1'b0,!({1'b1,curr_trans.src1[6:4]}-{1'b0,curr_trans.src2[6:4]}-{1'b0,1'b0,1'b0, !({1'b1,curr_trans.src1[3:0]}-{1'b0,curr_trans.src2[3:0]}-{1'b0,1'b0,1'b0,curr_trans.srcCy})[4]})[3]}[1]) ^ !({1'b1,curr_trans.src1[6:4]}-{1'b0,curr_trans.src2[6:4]}-{1'b0,1'b0,1'b0, !({1'b1,curr_trans.src1[3:0]}-{1'b0,curr_trans.src2[3:0]}-{1'b0,1'b0,1'b0,curr_trans.srcCy})[4]})[3];
      end

      2: begin //operation multiply
       
      expected2 = curr_trans.src1;
      
      expected4 = 1'b0;
      expected5 = 1'b0;
      end

      3: begin //operation divide
      
      expected2 = curr_trans.src1;
      
      expected5 = 1'b0;
      expected4 = 1'b0;
      
      end

      4: begin //operation decimal adjustment
        //if (curr_trans.srcAc==1'b1 | curr_trans.src1[3:0]>4'b1001) {da_tmp, expected1[3:0]} = {1'b0, curr_trans.src1[3:0]}+ 5'b00110;
      //else {da_tmp, expected1[3:0]} = {1'b0, curr_trans.src1[3:0]};
 
      //if (curr_trans.srcCy | da_tmp | curr_trans.src1[7:4]>4'b1001)
       // {da_tmp1, expected1[7:4]} = {curr_trans.srcCy, curr_trans.src1[7:4]}+ 5'b00110 + {4'b0, da_tmp};
      //else {da_tmp1, expected1[7:4]} = {curr_trans.srcCy, curr_trans.src1[7:4]} + {4'b0, da_tmp};
 
      //expected4 = da_tmp | da_tmp1;
      expected2 = curr_trans.src1;
      expected3 = 8'h00;
      expected5 = 1'b0;
      expected6 = 1'b0;
      end

      5: begin //operation not
              // bit operation not
        expected1 = ~curr_trans.src1 ;
        expected2 = ~curr_trans.src1 ;
        expected3 = 8'h00;
        expected4 = ~curr_trans.srcCy ;
        expected5 = 1'b0;
        expected6 = 1'b0;
      end

      6: begin //operation and
              //bit operation and
        expected1 = curr_trans.src1 & curr_trans.src2;
        expected2 = curr_trans.src1 & curr_trans.src2;
        expected3 = 8'h00;
        expected4 = curr_trans.srcCy & curr_trans.bit_in;
        expected5 = 1'b0;
        expected6 = 1'b0;
      end

      7: begin //operation xor
              // bit operation xor
        expected1 = curr_trans.src1 ^ curr_trans.src2;
        expected2 = curr_trans.src1 ^ curr_trans.src2;
        expected3 = 8'h00;
        expected4 = curr_trans.srcCy ^ curr_trans.bit_in;
        expected5 = 1'b0;
        expected6 = 1'b0;
      end

      8: begin //operation or
              // bit operation or
        expected1 = curr_trans.src1 | curr_trans.src2;
        expected2 = curr_trans.src1 | curr_trans.src2;
        expected3 = 8'h00;
        expected4 = curr_trans.srcCy | curr_trans.bit_in;
        expected5 = 1'b0;
        expected6 = 1'b0;
      end

      9: begin //operation rotate left
              // bit operation cy= cy or (not ram)
        expected1 = {curr_trans.src1[6:0], curr_trans.src1[7]};
        expected2 = curr_trans.src1;
        expected3 = 8'h00;
        expected4 = curr_trans.srcCy | ~curr_trans.bit_in;
        expected5 = 1'b0;
        expected6 = 1'b0;
      end

      10: begin //operation rotate left with carry and swap nibbles
        expected1 = {curr_trans.src1[6:0], curr_trans.srcCy};
        expected2 = curr_trans.src1;
        expected3 = {curr_trans.src1[3:0], curr_trans.src1[7:4]};
        expected4 = curr_trans.src1[7];
        expected5 = 1'b0;
        expected6 = 1'b0;
      end

      11: begin //operation rotate right
        expected1 = {curr_trans.src1, curr_trans.src1[7:1]};
        expected2 = curr_trans.src1;
        expected3 = 8'h00;
        expected4 = curr_trans.srcCy & !curr_trans.bit_in;
        expected5 = 1'b0;
        expected6 = 1'b0;
      end

      12: begin //operation rotate right with carry
        expected1 = {curr_trans.srcCy, curr_trans.src1[7:1]};
        expected2 = curr_trans.src1;
        expected3 = 8'h00;
        expected4 = curr_trans.src1[0];
        expected5 = 1'b0;
        expected6 = 1'b0;
      end

      13: begin //operation pcs Add
        //if (curr_trans.srcCy) begin
        //expected1 = ({curr_trans.src2, curr_trans.src1} - {15'h0, 1'b1})[7:0];
	//expected2 = ({curr_trans.src2, curr_trans.src1} - {15'h0, 1'b1})[7:0];
        //expected3 = ({curr_trans.src2, curr_trans.src1} - {15'h0, 1'b1})[15:8];
      //end else begin
        //expected1 = ({curr_trans.src2, curr_trans.src1} + {15'h0, 1'b1})[7:0];
	//expected2 = ({curr_trans.src2, curr_trans.src1} + {15'h0, 1'b1})[7:0];
        //expected3 = ({curr_trans.src2, curr_trans.src1} + {15'h0, 1'b1})[15:8];
     // end
      expected4 = 1'b0;
      expected5 = 1'b0;
      expected6 = 1'b0;
      end

      14: begin //operation exchange
        if (curr_trans.srcCy)
      begin
        expected1 = curr_trans.src2;
        expected2 = curr_trans.src2;
        expected3 = curr_trans.src1;
      end else begin
        expected1 = {curr_trans.src1[7:4],curr_trans.src2[3:0]};
        expected2 = {curr_trans.src1[7:4],curr_trans.src2[3:0]};
        expected3 = {curr_trans.src2[7:4],curr_trans.src1[3:0]};
      end
      expected4 = 1'b0;
      expected5 = 1'b0;
      expected6 = 1'b0;
      end

      15: begin //NO
        expected1 = curr_trans.src1;
        expected2 = curr_trans.src1;
        expected3 = curr_trans.src2;
        expected4 = curr_trans.srcCy;
        expected5 = curr_trans.srcAc;
        expected6 = 1'b0;

      end
    endcase
    
    actual1 = curr_trans.des_acc;
    actual2 = curr_trans.des1;
    actual3 = curr_trans.des2;
    actual4 = curr_trans.desCy;
    actual5 = curr_trans.desAc;
    actual6 = curr_trans.desOv;
    
    
    if(actual1 != expected1 ) begin
      `uvm_error("COMPARE", $sformatf("Transaction failed! ACT=%d, EXP=%d", actual1, expected1))
    end
    else if(actual2 != expected2 ) begin
      `uvm_error("COMPARE", $sformatf("Transaction failed! ACT=%d, EXP=%d", actual2, expected2))
    end
    else if(actual3 != expected3 ) begin
      `uvm_error("COMPARE", $sformatf("Transaction failed! ACT=%d, EXP=%d", actual3, expected3))
    end
    else if(actual4 != expected4 ) begin
      `uvm_error("COMPARE", $sformatf("Transaction failed! ACT=%d, EXP=%d", actual4, expected4))
    end
    else if(actual5 != expected5 ) begin
      `uvm_error("COMPARE", $sformatf("Transaction failed! ACT=%d, EXP=%d", actual5, expected5))
    end
    else if(actual6 != expected6 ) begin
      `uvm_error("COMPARE", $sformatf("Transaction failed! ACT=%d, EXP=%d", actual6, expected6))
    end

    else begin
       
      `uvm_info("COMPARE", $sformatf("Transaction Passed! ACT=%d, EXP=%d", actual1, expected1), UVM_LOW)
      `uvm_info("COMPARE", $sformatf("Transaction Passed! ACT=%d, EXP=%d", actual2, expected2), UVM_LOW)
      `uvm_info("COMPARE", $sformatf("Transaction Passed! ACT=%d, EXP=%d", actual3, expected3), UVM_LOW)
      `uvm_info("COMPARE", $sformatf("Transaction Passed! ACT=%d, EXP=%d", actual4, expected4), UVM_LOW)
      `uvm_info("COMPARE", $sformatf("Transaction Passed! ACT=%d, EXP=%d", actual5, expected5), UVM_LOW)
      `uvm_info("COMPARE", $sformatf("Transaction Passed! ACT=%d, EXP=%d", actual6, expected6), UVM_LOW)
    end
    
  endtask

  
  
endclass