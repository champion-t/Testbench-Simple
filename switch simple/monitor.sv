class monitor;
    virtual sif vif;
    mailbox scb_mbx;
    semaphore sem;

    extern function new();
    extern task run();
    extern task sample_port(string tag="");
endclass

function monitor::new();
    sem = new(1);
endfunction

task monitor::run();
    $display("[T=%0t] [MONITOR] starting ...", $time);

    fork
        sample_port("Thread0");
        sample_port("Thread1");
    join
endtask

task monitor::sample_port(string tag="");
    forever begin
        @(posedge vif.clk);
        if (vif.rstn & vif.vld) begin
            packet pkt = new;
            sem.get();
            pkt.addr = vif.addr;
            pkt.data = vif.data;
            $display("[T=%0t] [MONITOR] %s First part over", $time, tag);

            @(posedge vif.clk);
            sem.put();
            pkt.addr_a = vif.addr_a;
            pkt.data_a = vif.data_a;
            pkt.addr_b = vif.addr_b;
            pkt.data_b = vif.data_b;
            $display("[T=%0t] [MONITOR] %s Second part over", $time, tag);

            scb_mbx.put(pkt);
            pkt.print({"MONITOR_", tag});
        end
    end
endtask