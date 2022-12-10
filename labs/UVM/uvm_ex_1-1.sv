// UVM Exercise 1
// Question 1
// Define a pakage with mentioned list of classes
package my_pack;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  /////////////////////////////////////////////////////////////////////
  // Transaction Class
  ////////////////////////////////////////////////////////////////////
  class my_transaction extends uvm_sequence_item;

    // Constructor
    function new(string name="my_transaction");
      super.new(name);
      `uvm_info("Transaction", "Hi from my_transaction class", UVM_NONE)
    endfunction: new

  endclass: my_transaction

  /////////////////////////////////////////////////////////////////////
  // Driver Class
  ////////////////////////////////////////////////////////////////////
  class my_driver extends uvm_driver #(my_transaction);

    // Constructor
    function new(string name="my_driver", uvm_component parent=null);
      super.new(name, parent);
      `uvm_info("Driver", "Hi from my_driver class", UVM_NONE)
    endfunction: new

  endclass: my_driver 

  /////////////////////////////////////////////////////////////////////
  // Monitor Class
  ////////////////////////////////////////////////////////////////////
  class my_monitor extends uvm_monitor;

    // Constructor
    function new(string name="my_monitor", uvm_component parent=null);
      super.new(name, parent);
      `uvm_info("Monitor", "Hi from my_monitor class", UVM_NONE)
    endfunction: new

  endclass: my_monitor

  /////////////////////////////////////////////////////////////////////
  // Agent Class
  ////////////////////////////////////////////////////////////////////
  class my_agent extends  uvm_agent;

    // Constructor
    function new(string name="my_agent", uvm_component parent=null);
      super.new(name, parent);
      `uvm_info("Agent", "Hi from my_agent class", UVM_NONE)
    endfunction: new

  endclass: my_agent

  /////////////////////////////////////////////////////////////////////
  // Scoreboard Class
  ////////////////////////////////////////////////////////////////////
  class my_scoreboard extends uvm_scoreboard; 

    // Constructor
    function new(string name="my_scoreboard", uvm_component parent=null);
      super.new(name, parent);
      `uvm_info("Scoreboard", "Hi from my_scoreboard class", UVM_NONE)
    endfunction: new

  endclass: my_scoreboard 

  /////////////////////////////////////////////////////////////////////
  // Subscriber Class
  ////////////////////////////////////////////////////////////////////
  class my_subscriber extends uvm_subscriber #(my_transaction);  

    // Constructor
    function new(string name="my_subscriber", uvm_component parent=null);
      super.new(name, parent);
      `uvm_info("Subscriber", "Hi from my_subscriber class", UVM_NONE)
    endfunction: new
    
    // Function: write
    // pure virtual method that is declared in the uvm_subscriber
    // The following isn't working on Questa
    // function void write (my_transaction trans);
    // Link: https://verificationacademy.com/forums/uvm/any-one-please-resolve-code-error-uvm-subscriber-write-function
    function void write (my_transaction t);
    endfunction: write
  endclass: my_subscriber 

  /////////////////////////////////////////////////////////////////////
  // Environment Class
  ////////////////////////////////////////////////////////////////////
  class my_env extends uvm_env;

    // Constructor
    function new(string name="my_env");
      super.new(name);
      `uvm_info("Environment", "Hi from my_env class", UVM_NONE)
    endfunction

  endclass: my_env 

  /////////////////////////////////////////////////////////////////////
  // Test Class
  ////////////////////////////////////////////////////////////////////
  class my_test extends uvm_test;
	// Fixing the following error 
    //  "UVM_WARNING @ 0: reporter [BDTYP] Cannot create a component of type 'my_test' because it is not registered with the factory."
    //  "UVM_FATAL @ 0: reporter [INVTST] Requested test from call to run_test(my_test) not found."
    // link: https://verificationacademy.com/forums/uvm/cannot-create-component-type-test2-because-it-not-registered-factory
    // Registering the my_test on the factory
    `uvm_component_utils(my_test)
    
    // Constructor
    function new(string name="my_test", uvm_component parent=null);
      super.new(name, parent);
      `uvm_info("Test", "Hi from my_test class", UVM_NONE)
    endfunction
    
  endclass: my_test

endpackage: my_pack