`include "packet.sv"

class Monitor;
    virtual rif vif;
    mailbox scb_mbx;

    extern task run();
endclass

task Monitor::run();
    $display("[T=%0t] [MONITOR] starting ...", $time);

    forever begin
        @(posedge vif.clk);
        if (vif.sel) begin
            Packet pkt = new;
            pkt.addr    =   vif.addr;
            pkt.wr      =   vif.wr;
            pkt.wdata   =   vif.wdata;

            if (!vif.wr) begin
                @(posedge vif.clk);
                pkt.rdata = vif.rdata;
            end

            pkt.print("Monitor");
            scb_mbx.put(pkt);
        end
    end
endtask