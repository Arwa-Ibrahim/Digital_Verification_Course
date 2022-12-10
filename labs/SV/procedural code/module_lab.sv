module mid1;
endmodule // mid1

module mid2;
endmodule // mid2

module bot;
endmodule // bot

module top #(P1 = 10);
  if (P1 == 10) begin
    bot m_bot [0:2] ();
  end else if (P1 == 20) begin
    for(genvar i=0; i<3; i++) begin
      bot m_bot ();
    end
  end
endmodule // top

module wrapper #(P1 = 10);
  mid1 m_mid1();
  // need to be those istances on the top module not separate ones
  bind m_mid1 mid2 m_mid2 (); 
  generate;
    case (P1)
      10: bot bot2();
      20: bot bot3();
    endcase
  endgenerate
endmodule // wrapper