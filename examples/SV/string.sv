// Code your testbench here
// Useful links:
// - https://stackoverflow.com/questions/53738390/atobin-and-atohex-in-systemverilog
// - http://www.testbench.in/SV_04_STRINGS.html
module tb;
  string s1;
  int x, y;
  logic [15:0] z;
  
  initial begin
    s1 = "10";
    // Questa & VCS didn't recognize the following syntax atoi(s1)
    // But both were able to recognize the below syntax
    x = s1.atoi();
    y = s1.len();
    z = s1.atohex();
    
    $display("x is %0d", x); // prints 10
    $display("y is %0d", y); // prints 2
    // What atohex do is convert an ASCII string in a particular radix to an integral value. atohex assumes the string is formatted in hexadecimal.
    //     from LRM:
        // — str.atoi() returns the integer corresponding to the ASCII decimal representation in str.
        // — atohex interprets the string as hexadecimal.
        // — atooct interprets the string as octal.
        // — atobin interprets the string as binary.
        // NOTE—These ASCII conversion functions return a 32-bit integer value
    $display("z is %0h", z); // prints 10 not A
    
  end

endmodule



