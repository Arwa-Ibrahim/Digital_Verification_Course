// Code your testbench here
// The point here is that for packed struct when assigning the value to the struct as a whole
// the memory is represented as MSBs (first member of the struct) -> LSBs (last member on the struct)
// so on the first case we have the 10 is enough to be represented on the 1st 4 LSB so the b is the only member that is affected
// so if we need to give both members the value 10 either to write 26'h1400A or to use another representation.
module tb;
  struct packed {
    bit [12:0] a;
    bit [12:0] b;
  } ps;
  
  initial begin
   	ps = 10;
    $display("a is %0d, %0h", ps.a, ps.a);
    $display("b is %0d, %0h", ps.b, ps.b);
    
    
    ps = 26'h1400A;
    $display("a is %0d, %0h", ps.a, ps.a);
    $display("b is %0d, %0h", ps.b, ps.b);
    
    ps = '{10, 10}; // assignment pattern positional
    $display("a is %0d, %0h", ps.a, ps.a);
    $display("b is %0d, %0h", ps.b, ps.b);
    
    ps = '{a:10, b:10}; // assignment pattern by name
    $display("a is %0d, %0h", ps.a, ps.a);
    $display("b is %0d, %0h", ps.b, ps.b);
    
    ps.a = 10;
    ps.b = 10;
    $display("a is %0d, %0h", ps.a, ps.a);
    $display("b is %0d, %0h", ps.b, ps.b);
  end

endmodule



