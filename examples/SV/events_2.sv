// Code your testbench here
program main;
  event blocking_e_1;
  event blocking_e_2;
  event non_blocking_e_1;
  event non_blocking_e_2;
  process process_b_1;
  process process_b_2;
  process process_nb_1;
  process process_nb_2;

  initial begin
    fork
      begin
        process_b_1 = process::self();
        -> blocking_e_1;
        @(blocking_e_1); // race condition
      end
      begin
        process_b_2 = process::self();
        -> blocking_e_2;
        wait(blocking_e_2.triggered);
      end
      begin
        process_nb_1 = process::self();
        ->> non_blocking_e_1;
        @(non_blocking_e_1);
      end
      begin
        process_nb_2 = process::self();
        ->> non_blocking_e_2;
        wait(non_blocking_e_2.triggered);
      end
    join_none
    #10;
    $display("process_b_1.status:%s and process_b_2.status:%s", process_b_1.status, process_b_2.status);
    $display("process_nb_1.status:%s and process_nb2.status:%s", process_nb_1.status, process_nb_2.status);
  end
endprogram : main

