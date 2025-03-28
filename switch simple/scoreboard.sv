class scoreboard;
    mailbox scb_mbx;

    extern task run();
endclass

task scoreboard::run();
    forever begin
        packet pkt;
        scb_mbx.get(pkt);

        if (pkt.addr inside {[0:8'h3F]}) begin
            if (pkt.addr_a != pkt.addr | pkt.data_a != pkt.data)
                $display("[T=%0t] [SCOREBOARD] [ERROR] Mismatch addr=0x%0h addr_a=0x%0h data=0x%0h data_a=0x%0h", $time, pkt.addr, pkt.addr_a, pkt.data, pkt.data_a);
            else
                $display("[T=%0t] [SCOREBOARD] [PASS] Match addr=0x%0h addr_a=0x%0h data=0x%0h data_a=0x%0h", $time, pkt.addr, pkt.addr_a, pkt.data, pkt.data_a);
        end
        else begin
            if (pkt.addr_b != pkt.addr | pkt.data_b != pkt.data)
                $display("[T=%0t] [SCOREBOARD] [ERROR] Mismatch addr=0x%0h addr_b=0x%0h data=0x%0h data_b=0x%0h", $time, pkt.addr, pkt.addr_b, pkt.data, pkt.data_b);
            else
                $display("[T=%0t] [SCOREBOARD] [PASS] Match addr=0x%0h addr_b=0x%0h data=0x%0h data_b=0x%0h", $time, pkt.addr, pkt.addr_b, pkt.data, pkt.data_b);
        end
    end
endtask