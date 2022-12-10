// UVM Exercise 1
// Question 2
// Create a top level module and import the pakages, call run_test method

// include all other coding files
`include "uvm_ex_1-1.sv"

module top;
  
  // Why we need to re-import the uvm_pkg?
  //  - it's already imported on the custom pkg that will be imported!!!
  import my_pack::*; 

  initial begin
    $display("Hello from the top module");
    $display("Starting the action!");
    run_test("my_test");
  end // initial block

endmodule: top