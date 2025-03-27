`include "environment.sv"

class Test;
    Env e0;
    mailbox drv_mbx;

    extern function new();
    extern virtual task run();
    extern virtual task apply_stim();
endclass

function Test::new();
    e0 = new();
    drv_mbx = new();
endfunction

task Test::run();
    e0.d0.drv_mbx = drv_mbx;

    fork
        e0.run();
    join_none

    apply_stim();
endtask

task Test::apply_stim();
    Packet pkt;

    $display("[T=%0t] [TEST] Starting stimulus ...", $time);
    repeat (20) begin
        pkt = new;
        pkt.randomize();
        drv_mbx.put(pkt);
    end
    
    // pkt = new;
    // pkt.randomize() with {addr == 8'haa; wr == 0;};
    // drv_mbx.put(pkt);
endtask