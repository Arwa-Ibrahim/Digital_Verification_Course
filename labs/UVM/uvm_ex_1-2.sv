// UVM Exercise 1
// Question 2
// Create a top level module and import the pakages, call run_test method

// include all other coding files
`include "uvm_ex_1-1.sv"

module top;
  
  // Why we need to re-import the uvm_pkg?
  //  - it's already imported on the custom pkg that will be imported!!!
  // VCS will work fine, but questa will raise an error
  // either need to export the uvm_pkg on my_pack or to 
  // import it here on the top module as well
  import uvm_pkg::*;
  import my_pack::*; 

  initial begin
    $display("Hello from the top module");
    $display("Starting the action!");
    run_test("my_test");
  end // initial block

endmodule: top