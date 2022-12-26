// UVM Exercise 5
// Question 2
// Instantiate uvm_nonblocking_slave_port/imp in two different components and connect them in the test class
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

// Class: component1
// Represents the first component (driver for example?!)
class component1 extends uvm_component;
  // Registering the class on the factory
  `uvm_component_utils(component1)

  // Define the uvm_get_peek_port
  uvm_nonblocking_slave_port#(packet) m_peek_port;
  
  // Define the pkt
  packet pkt;

  // Constructor
  function new (string name="component1", uvm_component parent=null);
    super.new(name, parent);
  endfunction: new

  // Function: Build_Phase
  // Implements the build phase of the class
  virtual function void build_phase (uvm_phase phase);
    pkt = packet::type_id::create("pkt");
    m_peek_port = new("m_peek_port", this);
  endfunction: build_phase

  // Task: Run_Phase
  // Implements the run phase of the class
  virtual task run_phase (uvm_phase phase);
    phase.raise_objection(this);
    m_peek_port.try_put(pkt);
    m_peek_port.can_put();
    m_peek_port.try_get(pkt);
    m_peek_port.can_get();
    m_peek_port.try_peek(pkt);
    m_peek_port.can_peek();
    phase.drop_objection(this);
  endtask: run_phase
endclass: component1

// Class: component2
// Represents the first component (sequencer for example?!)
class component2 extends uvm_component;
  // Registering the class on the factory
  `uvm_component_utils(component2)

  // Define the uvm_get_peek_imp
  uvm_nonblocking_slave_imp#(packet, ,component2) m_peek_imp;

  // Constructor
  function new (string name="component2", uvm_component parent=null);
    super.new(name, parent);
  endfunction: new

  // Function: Build_Phase
  // Implements the build phase of the class
  virtual function void build_phase (uvm_phase phase);
    m_peek_imp = new("m_peek_imp", this);
  endfunction: build_phase

  // -------------------------------------------------------- //
  // -------------------- Important Note -------------------- //
  // Must implementing all the tasks of the uvm_get_peek_port.
  // -------------------------------------------------------- //
  // Task: try_put
  // Implements the try_get of the imp TLM
  virtual function try_put (packet pkt);
    pkt.print("Hello from the try_put function of the component2!!");
  endfunction: try_put

  // Task: can_put
  // Implements the can_put of the imp TLM
  virtual function can_put ();
    // This will throw an error as there is no pkt is seen from it (doesn't take an argument)
    // pkt.print("Hello from the can_put task of the component2!!");
    $display("Hello from the can_put function of the component2!!");
  endfunction: can_put

  // Task: try_get
  // Implements the try_get of the imp TLM
  virtual function try_get (packet pkt);
    pkt.print("Hello from the try_get function of the component2!!");
  endfunction: try_get

  // Task: can_get
  // Implements the can_get of the imp TLM
  virtual function can_get ();
    // This will throw an error as there is no pkt is seen from it (doesn't take an argument)
    // pkt.print("Hello from the can_get task of the component2!!");
    $display("Hello from the can_get function of the component2!!");
  endfunction: can_get

  // Task: try_peek
  // Implements the try_peek of the imp TLM
  virtual function try_peek (packet pkt);
    pkt.print("Hello from the try_peek function of the component2!!");
  endfunction: try_peek

  // Task: can_peek
  // Implements the can_peek of the imp TLM
  virtual function can_peek ();
    // This will throw an error as there is no pkt is seen from it (doesn't take an argument)
    // pkt.print("Hello from the can_peek task of the component2!!");
    $display("Hello from the can_peek function of the component2!!");
  endfunction: can_peek

endclass: component2

// Class: my_test
class my_test extends uvm_test;
  // Registering the my_test on the factory
  `uvm_component_utils(my_test)
  
  // Intances of component classes
  component1 comp1;
  component2 comp2;

  // Constructor
  function new(string name="my_test", uvm_component parent=null);
    super.new(name, parent);
    `uvm_info("Test", "Hi from my_test class", UVM_NONE)
  endfunction: new

  // Function: build_phase
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("Test", "Build Phase", UVM_NONE)

    // Create instance of component classes 
    comp1 = component1::type_id::create("comp1", this);
    comp2 = component2::type_id::create("comp2", this);
    
    // Print the info about the classes registered on factory
    // factory.print();

    // Print the info of the configuration db
    // uvm_resources.dump();
  endfunction: build_phase

  // Function: connect_phase
  function void connect_phase (uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("Test", "Connect Phase", UVM_NONE)
    comp1.m_peek_port.connect(comp2.m_peek_imp);
  endfunction: connect_phase

  // Task: run_phase
  task run_phase (uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("Test", "Run Phase", UVM_NONE)
  endtask: run_phase
    
endclass: my_test
