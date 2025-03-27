`include "packet.sv"

class Driver;
    virtual rif vif;
    event drv_done;
    mailbox drv_mbx;

    extern task run();
endclass

task Driver::run();
    $display("[T=%0t] [DRIVER] waiting for item ...", $time);
    @(posedge vif.clk);

    forever begin
        Packet pkt;

        $display("[T=%0t] [DRIVER] waiting for item ...", $time);
        drv_mbx.get(pkt);
        pkt.print("Driver");
        vif.sel     <=  1;
        vif.addr    <=  pkt.addr;
        vif.wdata   <=  pkt.wdata;
        vif.wr      <=  pkt.wr;

        @(posedge vif.clk);
        while(!vif.ready) begin
            $display("[T=%0t] [DRIVER] wait until ready is high", $time);
            @(posedge vif.clk);
        end

        vif.sel <= 0;
        ->drv_done;
    end
endtask