module tb;
    import my_pkg::*;

    reg clk;
    
    always #10 clk = ~clk;

    sif tif(clk);

    switch dut(
        .clk(clk),
        .rstn(tif.rstn),
        .vld(tif.vld),
        .addr(tif.addr),
        .data(tif.data),
        .addr_a(tif.addr_a),
        .data_a(tif.data_a),
        .addr_b(tif.addr_b),
        .data_b(tif.data_b)
    );

    test t0;

    initial begin
        {clk, tif.rstn} <= 0;
        #20 tif.rstn <= 1;

        t0 = new;
        t0.e0.vif = tif;
        t0.run();

        #50 $finish;
    end

    initial begin
        $dumpvars;
        $dumpfile("dump.vcd");
    end
endmodule