// Code your testbench here
// Useful links: 
// https://www.theartofverification.com/event-vs-waitevent-triggered-in-systemverilog/
// https://verificationguide.com/systemverilog/systemverilog-events/
// https://www.chipverify.com/systemverilog/systemverilog-event
module tb;
  event event_a;
  
  initial begin
    #20 -> event_a;
    $display("[%0t] Thread1: triggered event_a", $time);
  end
  
  initial begin
    $display("[%0t] Thread2: waiting for trigger", $time);
    #20 @(event_a); // never recieved a trigger, due to race condition between @ and -> operations
    $display("[%0t] Thread2: received event_a trigger", $time);
  end
  
  initial begin
    $display("[%0t] Thread3: waiting for trigger", $time);
    #20 wait(event_a.triggered);
    $display("[%0t] Thread3: received event_a trigger", $time);
  end
  
  initial begin
    $display("[%0t] Thread4: waiting for trigger", $time);
    #20 @(event_a.triggered); // never recieved a trigger, due to race condition between @ and -> operations
    $display("[%0t] Thread4: received event_a trigger", $time);
  end
endmodule

