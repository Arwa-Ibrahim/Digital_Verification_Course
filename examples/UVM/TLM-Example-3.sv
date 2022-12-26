// UVM TLM Example 3
// -------------------------------------------------------------------//

// Importing the uvm package
import uvm_pkg::*;

// Importing the uvm macros
`include "uvm_macros.svh"

// Class: packet
// Represents the transaction class
class packet extends uvm_object;
  // Registering the class on the factory
  `uvm_object_utils(packet)

  // Constructor
  function new (string name="packet");
    super.new(name);
  endfunction: new

  // Function: Print
  // Printing Hello from the packet
  function print (string str);
    `uvm_info("Packet",$sformatf("%s", str), UVM_NONE)
  endfunction: print
endclass: packet

// Class: componentA
// Represents the first component (driver for example?!)
class componentA extends uvm_component;
  // Registering the class on the factory
  `uvm_component_utils(componentA)

  // Define the uvm_get_peek_port
  uvm_blocking_master_port#(packet,packet) m_put_port;

  // Define the pkt
  packet pkt;

  // Constructor
  function new (string name="componentA", uvm_component parent=null);
    super.new(name, parent);
  endfunction: new

  // Function: Build_Phase
  // Implements the build phase of the class
  virtual function void build_phase (uvm_phase phase);
    pkt = packet::type_id::create("pkt");
    m_put_port = new("m_put_port", this);
  endfunction: build_phase

  // Task: Run_Phase
  // Implements the run phase of the class
  virtual task run_phase (uvm_phase phase);
    phase.raise_objection(this);
    m_put_port.put(pkt);
    m_put_port.get(pkt);
    m_put_port.peek(pkt);
    phase.drop_objection(this);
  endtask: run_phase
endclass: componentA

// Class: componentB
// Represents the first component (sequencer for example?!)
class componentB extends uvm_component;
  // Registering the class on the factory
  `uvm_component_utils(componentB)

  // Define the uvm_get_peek_imp
  uvm_blocking_slave_imp#(packet, ,componentB) m_put_imp;

  // Constructor
  function new (string name="componentB", uvm_component parent=null);
    super.new(name, parent);
  endfunction: new

  // Function: Build_Phase
  // Implements the build phase of the class
  virtual function void build_phase (uvm_phase phase);
    m_put_imp = new("m_put_imp", this);
  endfunction: build_phase

  // -------------------------------------------------------- //
  // -------------------- Important Note -------------------- //
  // Must implementing all the tasks of the uvm_put_port.
  // -------------------------------------------------------- //
  virtual task put (packet pkt);
    pkt.print("Hello from the componentB.put!!");
  endtask: put

  virtual task get (packet pkt);
    $display("Hello from the componentB.get!!");
  endtask: get

  virtual task peek (packet pkt);
    $display("Hello from the componentB.peek!!");
  endtask: peek

endclass: componentB

// Class: my_test
class my_test extends uvm_test;
  // Registering the my_test on the factory
  `uvm_component_utils(my_test)
  
  // Intances of component classes
  componentA compA;
  componentB compB;

  // Constructor
  function new(string name="my_test", uvm_component parent=null);
    super.new(name, parent);
  endfunction: new

  // Function: build_phase
  function void build_phase (uvm_phase phase);

    // Create instance of component classes 
    compA = componentA::type_id::create("compA", this);
    compB = componentB::type_id::create("compB", this);
  
  endfunction: build_phase

  // Function: connect_phase
  function void connect_phase (uvm_phase phase);
    // ----------------------- Error ----------------------- //
    // Questa: 
    // ------ Error: (vsim-7065) Illegal assignment to class
    // VCS: 
    // ------ UVM_ERROR @ 0: uvm_test_top.compA.m_put_port [Connection Error] uvm_test_top.compB.m_put_imp (of type uvm_blocking_slave_imp) 
    //                       does not provide the complete interface required of this port (type uvm_blocking_master_port)
    // ------ UVM_ERROR @ 0: uvm_test_top.compA.m_put_port [Connection Error] connection count of 0 does not meet required minimum of 1
    // ------ UVM_FATAL @ 0: reporter [BUILDERR] stopping due to build errors
    compA.m_put_port.connect(compB.m_put_imp);
  endfunction: connect_phase
    
endclass: my_test
