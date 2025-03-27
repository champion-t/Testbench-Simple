`include "test.sv"

module tb;
    reg clk;

    always #10 clk = ~clk;
    rif tif(clk);

    reg_ctrl dut(
        .clk(clk),
        .rstn(tif.rstn),
        .addr(tif.addr),
        .sel(tif.sel),
        .wr(tif.wr),
        .wdata(tif.wdata),
        .rdata(tif.rdata),
        .ready(tif.ready)
    );

    initial begin
        Test t0;

        clk <= 0;
        tif.rstn <= 0;
        tif.sel <= 0;
        #20 tif.rstn <= 1;

        t0 = new();
        t0.e0.vif = tif;
        t0.run();

        #1000 $finish;
    end

    initial begin
        $dumpvars;
        $dumpfile("dump.vcd");
    end
endmodule