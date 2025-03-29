class driver;
    virtual aif vif;
    virtual aclk vclk;
    event drv_done;
    mailbox drv_mbx;

    extern task run();
endclass

task driver::run();
    $display("[T=%0t] [DRIVER] starting ...", $time);

    forever begin
        packet pkt;
        $display("[T=%0t] [DRIVER] waiting for packet ...", $time);
        drv_mbx.get(pkt);
        @(posedge vclk.clk);
        pkt.print("[DRIVER]");
        vif.rstn <= pkt.rstn;
        vif.a <= pkt.a;
        vif.b <= pkt.b;
        ->drv_done;
    end
endtask