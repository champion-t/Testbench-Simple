class driver;
    virtual sif vif;
    event drv_done;
    mailbox drv_mbx;

    extern task run();
endclass

task driver::run();
    $display("[T=%0t] [DRIVER] starting ...", $time);
    @(posedge vif.clk);

    forever begin
        packet pkt;
        $display("[T=%0t] [DRIVER] waiting for packet ...", $time);
        drv_mbx.get(pkt);
        pkt.print("DRIVER");
        vif.vld  <= 1;
        vif.addr <= pkt.addr;
        vif.data <= pkt.data;

        @(posedge vif.clk);
        vif.vld <= 0;
        ->drv_done;
    end
endtask