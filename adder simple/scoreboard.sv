class scoreboard;
    mailbox scb_mbx;

    extern task run();
endclass

task scoreboard::run();
    forever begin
        packet pkt, ref_pkt;
        scb_mbx.get(pkt);
        pkt.print("[SCOREBOARD]");

        ref_pkt = new();
        ref_pkt.copy(pkt);

        if (ref_pkt.rstn) begin
            {ref_pkt.carry, ref_pkt.sum} = ref_pkt.a + ref_pkt.b;
        end
        else begin
            {ref_pkt.carry, ref_pkt.sum} = 0;
        end

        if (ref_pkt.carry != pkt.carry) begin
            $display("[T=%0t] [SCOREBOARD] [ERROR] Carry mismatch ref_pkt=0x%0h pkt=0x%0h", $time, ref_pkt.carry, pkt.carry);
        end
        else begin
            $display("[T=%0t] [SCOREBOARD] [PASS] Carry match ref_pkt=0x%0h pkt=0x%0h", $time, ref_pkt.carry, pkt.carry);
        end

        if (ref_pkt.sum != pkt.sum) begin
            $display("[T=%0t] [SCOREBOARD] [ERROR] Sum mismatch ref_pkt=0x%0h pkt=0x%0h", $time, ref_pkt.sum, pkt.sum);
        end
        else begin
            $display("[T=%0t] [SCOREBOARD] [PASS] Sum match ref_pkt=0x%0h pkt=0x%0h", $time, ref_pkt.sum, pkt.sum);
        end
    end
endtask