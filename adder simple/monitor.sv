class monitor;
    virtual aif vif;
    virtual aclk vclk;
    mailbox scb_mbx;

    extern task run();
endclass

task monitor::run();
    $display("[T=%0t] [MONITOR] starting ...", $time);

    forever begin
        packet pkt = new();
        @(posedge vclk.clk);
        pkt.rstn = vif.rstn;
        pkt.a = vif.a;
        pkt.b = vif.b;
        pkt.sum = vif.sum;
        pkt.carry = vif.carry;
        pkt.print("[MONITOR]");
        scb_mbx.put(pkt);
    end
endtask