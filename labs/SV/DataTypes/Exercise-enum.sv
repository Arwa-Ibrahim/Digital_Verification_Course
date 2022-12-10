// Enumeration Exercise
module tb_enum;
  // Question 1
  // or enum int but it's by default will from int type
  // needed to add typedef to be able to print it's value and use it on the initial.
  typedef enum {val_1, val_2=5, val_3=7, val_4=9} Q1;
  
  initial begin
    Q1 Q1_inst;
    Q1_inst = Q1_inst.first();
    for (int i=0; i < Q1_inst.num; i++) begin
    	$display("int enum element %0d: name - %s and value - %0d", i+1, Q1_inst.name(), Q1_inst);
    	Q1_inst = Q1_inst.next();
  	end
  end
  
  /////////////////////////////////////////////////////////////////////////////
  initial begin
    $display("/////////////////////////////////////////////////////////////////////////////");
  end
  /////////////////////////////////////////////////////////////////////////////
  
  // Question 2
  typedef enum time {el_1=1032, el_2=2003, el_3, el_4=5000} Q2;
  
  initial begin
    Q2 Q2_inst;
    Q2_inst = Q2_inst.first();
    for (int i=0; i < Q2_inst.num; i++) begin
      $display("time enum element %0d: name - %s and value - %0t", i+1, Q2_inst.name(), Q2_inst);
      Q2_inst = Q2_inst.next();
  	end
  end
  
  /////////////////////////////////////////////////////////////////////////////
  initial begin
    $display("/////////////////////////////////////////////////////////////////////////////");
  end
  /////////////////////////////////////////////////////////////////////////////
  
  // Question 3
  initial begin
    Q1 Q3_inst;
    Q3_inst = Q3_inst.first();
    $display("int enum with %0d elements",  Q3_inst.num());
    for (int i=0; i < Q3_inst.num; i++) begin
      $display("int enum element %0d: name - %s and value - %0d", i+1, Q3_inst.name(), Q3_inst);
      Q3_inst = Q3_inst.next();
  	end
  end
  
endmodule // tb_enum