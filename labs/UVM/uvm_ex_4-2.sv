// UVM Exercise 4

// include all other coding files
`include "uvm_ex_4-1.sv"

module top;
  
  // Why we need to re-import the uvm_pkg?
  //  - it's already imported on the custom pkg that will be imported!!!
  // VCS will work fine, but questa will raise an error
  // either need to export the uvm_pkg on my_pack or to 
  // import it here on the top module as well
  import uvm_pkg::*;
  import my_pack::*; 

  // instantiate the interface 
  virtual intf in1;

  initial begin
    $display("Hello from the top module");
    $display("Starting the action!");

    // Set interface on the configuration database
    uvm_config_db#(virtual intf)::set(null, "uvm_test_top", "vif", in1);

    // run my_test 
    run_test("my_test");
  end // initial block

endmodule: top