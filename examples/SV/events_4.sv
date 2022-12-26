// Code your testbench here
module tb;
  event event_a;
  event event_b;
  
  initial begin
    fork
      
      begin
        @(event_a.triggered);
        $display("[%0t] Thread1: wait for event_a is over", $time);
      end
      
      begin
        @(event_b.triggered);
        $display("[%0t] Thread2: wait for event_b is over", $time);
      end
      
      //Thread3
      #20 ->event_a;
      
      //Thread4
      #30 ->event_b;
      
      begin
        //Thread5
        // commenting the next line will result in 
            // # [20] Thread1: wait for event_a is over
            // # [30] Thread2: wait for event_b is over
        // with the next line running 
            //  # [20] Thread1: wait for event_a is over
            // while expecting to get. ToDo: Ask about it
            // # [20] Thread1: wait for event_a is over
            // # [20] Thread2: wait for event_b is over
        #10 event_b = event_a; 
      end
    join
  end

endmodule

