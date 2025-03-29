class generator;
    int num = 10;
    event drv_done;
    mailbox drv_mbx;

    extern task run();
endclass

task generator::run();
    for (int i = 0; i < num; i++) begin
        packet pkt = new;
        pkt.randomize();
        $display("[T=%0t] [GENERATOR] Packet[%0d] create next packet", $time, i+1);
        drv_mbx.put(pkt);
        $display("[T=%0t] [GENERATOR] Wait for driver to bo done", $time);
        @(drv_done);
    end
endtask