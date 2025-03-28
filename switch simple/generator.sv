class generator;
    int num = 20;
    mailbox drv_mbx;
    event drv_done;

    extern task run();
endclass

task generator::run();
    for (int i = 0; i < num; i++) begin
        packet pkt = new;
        pkt.randomize();
        $display("[T=%0t] [GENERATOR] Packet[%0d] Create next packet", $time, i+1);
        drv_mbx.put(pkt);
        @(drv_done);
    end
    $display("[T=%0t] [GENERATOR] Done generator of %0d packets", $time, num);
endtask