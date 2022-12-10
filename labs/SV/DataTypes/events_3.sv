// Code your testbench here
module tb;
  event event_a;
  event event_b;
  event event_c;
  
//   initial begin
//     #20;
//     -> event_a;
//     -> event_b;
//     -> event_c;
//   end
  
  initial begin
    #10 -> event_a;
    #10 -> event_b;
    #10 -> event_c;
  end
  
  initial begin
    wait_order (event_a,event_b,event_c)
      $display("[%0t] Events were executed in the correct order", $time);
    else
      $display("[%0t] Events weren't executed in the correct order!", $time);
  end
  
endmodule

