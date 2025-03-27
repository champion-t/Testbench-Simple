`include "packet.sv"

class Scoreboard;
    mailbox scb_mbx;
    Packet rpkt[256];

    extern task run();
endclass

task Scoreboard::run();
    forever begin
        Packet pkt;
        scb_mbx.get(pkt);
        pkt.print("Scoreboard");

        if (pkt.wr) begin
            if(rpkt[pkt.addr] == null)
                rpkt[pkt.addr] = new;

            rpkt[pkt.addr] = pkt;
            $display("[T=%0t] [SCOREBOARD] Store addr=0x%0h wr=0x%0h data=0x%0h", $time, pkt.addr, pkt.wr, pkt.wdata); 
        end

        if (!pkt.wr) begin
            if(rpkt[pkt.addr] == null) begin
                if (pkt.rdata != 16'h1507)
                    $display("[T=%0t] [SCOREBOARD] [ERROR] First time read, addr=0x%0h exp=16'h1507 act=0x%0h", $time, pkt.addr, pkt.rdata);
                else 
                    $display("[T=%0t] [SCOREBOARD] [PASS] First time read, addr=0x%0h exp=16'h1507 act=0x%0h", $time, pkt.addr, pkt.rdata);
            end
            else begin
                if (pkt.rdata != rpkt[pkt.addr].wdata)
                    $display("[T=%0t] [SCOREBOARD] [ERROR] addr=0x%0h exp=0x%0h act=0x%0h", $time, pkt.addr, rpkt[pkt.addr].wdata, pkt.rdata);
                else
                    $display("[T=%0t] [SCOREBOARD] [PASS] addr=0x%0h exp=0x%0h act=0x%0h", $time, pkt.addr, rpkt[pkt.addr].wdata, pkt.rdata);
            end
        end
    end
endtask