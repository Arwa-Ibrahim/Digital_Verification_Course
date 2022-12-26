// UVM Exercise 4
// Question 1
// Define an empty body interface intf, instantiate it under the top module
// and then call the set method to set the virtual interface in the configuration database.
// -------------------------------------------------------------------//
// Question 2, 3, 4, 5
// Move on hirarchy and instantiate the interface, get it from the upper layer and
// set it for the lower layer.
// -------------------------------------------------------------------//
interface intf;
endinterface: intf

// Package: my_pack
// Encapsulates all the environment classes definition
package my_pack;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  /////////////////////////////////////////////////////////////////////
  // Transaction Class
  ////////////////////////////////////////////////////////////////////
  class my_transaction extends uvm_sequence_item;
    // Registering the my_transaction on the factory
    `uvm_object_utils(my_transaction)

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
    // Registering the my_driver on the factory
    `uvm_component_utils(my_driver)

    // instance of the interface
    virtual intf drvr_in1;

    // Constructor
    function new(string name="my_driver", uvm_component parent=null);
      super.new(name, parent);
      `uvm_info("Driver", "Hi from my_driver class", UVM_NONE)
    endfunction: new

    // Function: build_phase
    function void build_phase (uvm_phase phase);
      super.build_phase(phase);
      `uvm_info("Driver", "Build Phase", UVM_NONE)

      // Get interface on the configuration database
      if (!uvm_config_db#(virtual intf)::get(this, "", "vif", drvr_in1)) 
        `uvm_fatal(get_full_name(), "Error can't get the inteface from the config. db!")
      
      // Print the info of the configuration db
      // uvm_resources.dump();
    endfunction: build_phase

    // Function: connect_phase
    function void connect_phase (uvm_phase phase);
      super.connect_phase(phase);
      `uvm_info("Driver", "Connect Phase", UVM_NONE)
    endfunction: connect_phase

    // Task: run_phase
    task run_phase (uvm_phase phase);
      super.run_phase(phase);
      `uvm_info("Driver", "Run Phase", UVM_NONE)
    endtask: run_phase

  endclass: my_driver 

  /////////////////////////////////////////////////////////////////////
  // Monitor Class
  ////////////////////////////////////////////////////////////////////
  class my_monitor extends uvm_monitor;
    // Registering the my_monitor on the factory
    `uvm_component_utils(my_monitor)

    // instance of the interface
    virtual intf mon_in1;

    // Constructor
    function new(string name="my_monitor", uvm_component parent=null);
      super.new(name, parent);
      `uvm_info("Monitor", "Hi from my_monitor class", UVM_NONE)
    endfunction: new

    // Function: build_phase
    function void build_phase (uvm_phase phase);
      super.build_phase(phase);
      `uvm_info("Monitor", "Build Phase", UVM_NONE)

      // Get interface on the configuration database
      if (!uvm_config_db#(virtual intf)::get(this, "", "vif", mon_in1)) 
        `uvm_fatal(get_full_name(), "Error can't get the inteface from the config. db!")

      // Print the info of the configuration db
      // uvm_resources.dump();
    endfunction: build_phase

    // Function: connect_phase
    function void connect_phase (uvm_phase phase);
      super.connect_phase(phase);
      `uvm_info("Monitor", "Connect Phase", UVM_NONE)
    endfunction: connect_phase

    // Task: run_phase
    task run_phase (uvm_phase phase);
      super.run_phase(phase);
      `uvm_info("Monitor", "Run Phase", UVM_NONE)
    endtask: run_phase

  endclass: my_monitor

  /////////////////////////////////////////////////////////////////////
  // Agent Class
  ////////////////////////////////////////////////////////////////////
  class my_agent extends  uvm_agent;
    // Registering the my_agent on the factory
    `uvm_component_utils(my_agent)

    // Intances of Monitor, Driver and Sequencer classes
    my_driver drvr;
    my_monitor mon;
    uvm_sequencer #(my_transaction) sequr;

    // instance of the interface
    virtual intf agent_in1;

    // Constructor
    function new(string name="my_agent", uvm_component parent=null);
      super.new(name, parent);
      `uvm_info("Agent", "Hi from my_agent class", UVM_NONE)
    endfunction: new

    // Function: build_phase
    function void build_phase (uvm_phase phase);
      super.build_phase(phase);
      `uvm_info("Agent", "Build Phase", UVM_NONE)

      // Create instances of the monitor and driver for the phases
      // to be seen and for the messages to be printed
      sequr = uvm_sequencer#(my_transaction)::type_id::create("sequr", this);
      drvr  = my_driver::type_id::create("drvr", this);
      mon  = my_monitor::type_id::create("mon", this);

      // Set interface on the configuration database
      if (!uvm_config_db#(virtual intf)::get(this, "", "vif", agent_in1)) begin
        `uvm_fatal(get_full_name(), "Error can't get the inteface from the config. db!")
      end else begin
        uvm_config_db#(virtual intf)::set(this, "drvr", "vif", agent_in1);
        uvm_config_db#(virtual intf)::set(this, "mon", "vif", agent_in1);
      end

      // Print the info of the configuration db
      uvm_resources.dump();
    endfunction: build_phase

    // Function: connect_phase
    function void connect_phase (uvm_phase phase);
      super.connect_phase(phase);
      `uvm_info("Agent", "Connect Phase", UVM_NONE)
    endfunction: connect_phase

    // Task: run_phase
    task run_phase (uvm_phase phase);
      super.run_phase(phase);
      `uvm_info("Agent", "Run Phase", UVM_NONE)
    endtask: run_phase

  endclass: my_agent

  /////////////////////////////////////////////////////////////////////
  // Scoreboard Class
  ////////////////////////////////////////////////////////////////////
  class my_scoreboard extends uvm_scoreboard; 
    // Registering the my_scoreboard on the factory
    `uvm_component_utils(my_scoreboard)

    // Constructor
    function new(string name="my_scoreboard", uvm_component parent=null);
      super.new(name, parent);
      `uvm_info("Scoreboard", "Hi from my_scoreboard class", UVM_NONE)
    endfunction: new

    // Function: build_phase
    function void build_phase (uvm_phase phase);
      super.build_phase(phase);
      `uvm_info("Scoreboard", "Build Phase", UVM_NONE)
    endfunction: build_phase

    // Function: connect_phase
    function void connect_phase (uvm_phase phase);
      super.connect_phase(phase);
      `uvm_info("Scoreboard", "Connect Phase", UVM_NONE)
    endfunction: connect_phase

    // Task: run_phase
    task run_phase (uvm_phase phase);
      super.run_phase(phase);
      `uvm_info("Scoreboard", "Run Phase", UVM_NONE)
    endtask: run_phase

  endclass: my_scoreboard 

  /////////////////////////////////////////////////////////////////////
  // Subscriber Class
  ////////////////////////////////////////////////////////////////////
  class my_subscriber extends uvm_subscriber #(my_transaction);  
    // Registering the my_subscriber on the factory
    `uvm_component_utils(my_subscriber)

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

    // Function: build_phase
    function void build_phase (uvm_phase phase);
      super.build_phase(phase);
      `uvm_info("Subscriber", "Build Phase", UVM_NONE)
    endfunction: build_phase

    // Function: connect_phase
    function void connect_phase (uvm_phase phase);
      super.connect_phase(phase);
      `uvm_info("Subscriber", "Connect Phase", UVM_NONE)
    endfunction: connect_phase

    // Task: run_phase
    task run_phase (uvm_phase phase);
      super.run_phase(phase);
      `uvm_info("Subscriber", "Run Phase", UVM_NONE)
    endtask: run_phase

  endclass: my_subscriber 

  /////////////////////////////////////////////////////////////////////
  // Environment Class
  ////////////////////////////////////////////////////////////////////
  class my_env extends uvm_env;
    // Fixing the following error 
    //  "Error-[MFNF] Member not found uvm_classes.sv,
    //   261 "my_env::type_id" Could not find member 'type_id' in class 'my_env', at "uvm_classes.sv"
    // link: https://forums.accellera.org/topic/2158-type_id-not-in-scope-when-deriving-an-uvm_object/
    // Registering the my_env on the factory
    `uvm_component_utils(my_env)

    // Intances of Agent, Scoreboard and Subscriber classes
    my_agent      agent;
    my_scoreboard scb;
    my_subscriber sub;

    // instance of the interface
    virtual intf env_in1;

    // Constructor
    // For the environment class constuctor, as it's a component, 
    // need to add to the constuctor the name and the parent.
    // otherwise it will throw an error
    // link: https://verificationacademy.com/forums/uvm/error-tmatc
    function new(string name="my_env", uvm_component parent=null);
      super.new(name, parent);
      `uvm_info("Environment", "Hi from my_env class", UVM_NONE)
    endfunction: new

    // Function: build_phase
    function void build_phase (uvm_phase phase);
      super.build_phase(phase);
      `uvm_info("Environment", "Build Phase", UVM_NONE)
      
      // Create instances of the agent, scoreboard and subscriber 
      // for the phases to be seen and for the messages to be printed
      agent = my_agent::type_id::create("agent", this);
      scb   = my_scoreboard::type_id::create("scb", this);
      sub   = my_subscriber::type_id::create("sub", this);

      // Set interface on the configuration database
      if (!uvm_config_db#(virtual intf)::get(this, "", "vif", env_in1))
        `uvm_fatal(get_full_name(), "Error can't get the inteface from the config. db!")
      uvm_config_db#(virtual intf)::set(this, "agent", "vif", env_in1);

      // Print the info of the configuration db
      // uvm_resources.dump();
    endfunction: build_phase

    // Function: connect_phase
    function void connect_phase (uvm_phase phase);
      super.connect_phase(phase);
      `uvm_info("Environment", "Connect Phase", UVM_NONE)
    endfunction: connect_phase

    // Task: run_phase
    task run_phase (uvm_phase phase);
      super.run_phase(phase);
      `uvm_info("Environment", "Run Phase", UVM_NONE)
    endtask: run_phase

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
    
    // Intances of Environment classe
    my_env env;

    // instance of the interface
    virtual intf test_in1;

    // Constructor
    function new(string name="my_test", uvm_component parent=null);
      super.new(name, parent);
      `uvm_info("Test", "Hi from my_test class", UVM_NONE)
    endfunction: new

    // Function: build_phase
    function void build_phase (uvm_phase phase);
      super.build_phase(phase);
      `uvm_info("Test", "Build Phase", UVM_NONE)

      // Create instance of the environment 
      // for the phases to be seen and for the messages to be printed
      env = my_env::type_id::create("env", this);

      // Set interface on the configuration database
      if (!uvm_config_db#(virtual intf)::get(this, "", "vif", test_in1))
        `uvm_fatal(get_full_name(), "Error can't get the inteface from the config. db!")
      uvm_config_db#(virtual intf)::set(this, "env", "vif", test_in1);
      
      // Print the info about the classes registered on factory
      factory.print();

      // Print the info of the configuration db
      // uvm_resources.dump();
    endfunction: build_phase

    // Function: connect_phase
    function void connect_phase (uvm_phase phase);
      super.connect_phase(phase);
      `uvm_info("Test", "Connect Phase", UVM_NONE)
    endfunction: connect_phase

    // Task: run_phase
    task run_phase (uvm_phase phase);
      super.run_phase(phase);
      `uvm_info("Test", "Run Phase", UVM_NONE)
    endtask: run_phase
    
  endclass: my_test

endpackage: my_pack