// Structures Exercise
module tb_struct;
  // Question 1
  typedef struct {
  	string       str;
    integer      num;
    byte         by;
    struct packed {
      bit [5:0] bit_a;
    } p_struc;
    struct {
      event event_b;
      real  real_b;
    } unp_struc_1;
  }unp_struc_2;
  
  // As a workaround to assign the event as the event only to be assigned to another event and cannot be assigned to a value
  event b;
  
  initial begin
    // Part 1
    unp_struc_2 unp_str_inst;
    /*
     * workaround to have a randomized real number 
     * link: https://verificationacademy.com/forums/systemverilog/what-best-way-get-randomized-real-value
     * link: https://stackoverflow.com/questions/45249797/randomization-of-real-numbers-in-systemverilog
     * not working as expected the real part always equal tp .000
     * suspecting an issue on the casting "real'(({$random}%999))" part
    */
    // unp_str_inst.unp_str.real_b = ({$random}%999) + real'(({$random}%999)); 
    unp_str_inst.unp_struc_1.real_b = 789.897;
    $display("Real data of unpacked in unpacked struct %3.3f", unp_str_inst.unp_struc_1.real_b);
    $display("---------------------------------------------------------------------------");
    
    // Part 2
    // The following didn't work due to using of = need to use : as with the other elements of the main/bigger struct.
    // unp_str_inst = '{str:"Hello", num:({$random}%999), by:({$random} %(2**8) -1), p_str='{bit_a:({$random} %(2**6) -1)}, unp_str='{event_b:1, real_b:321.987}};
    unp_str_inst = '{str:"Hello", num:({$random}%999), by:({$random} %(2**8) -1), p_struc:'{bit_a:({$random} %(2**6) -1)}, unp_struc_1:'{event_b:b, real_b:321.987}};
    $display("Data of unpacked struct %p", unp_str_inst);
    $display("---------------------------------------------------------------------------");
  end
  
  /////////////////////////////////////////////////////////////////////////////
  initial begin
    $display("/////////////////////////////////////////////////////////////////////////////");
  end
  /////////////////////////////////////////////////////////////////////////////
  
  // Question 2
  typedef struct packed{
    bit [5:0] a;
    bit [6:0] b;
  }p_struct;
  
  initial begin
    p_struct p_struct_inst;
    p_struct_inst = $random;
    $display("Data of packed struct %p", p_struct_inst);
    $display("First element (MSB) is %d - %h", p_struct_inst.a, p_struct_inst.a);
    $display("Scond element (LSB) is %d - %h", p_struct_inst.b, p_struct_inst.b);
  end
  
  /////////////////////////////////////////////////////////////////////////////
  initial begin
    $display("/////////////////////////////////////////////////////////////////////////////");
  end
  /////////////////////////////////////////////////////////////////////////////
  
endmodule // tb_struct