module tb;
    import pkg::*;
    reg clk;

    aclk tclk();
    aif tif();
    adder dut(tif);

    initial begin
        test t0;
        t0 = new;
        t0.e0.vif = tif;
        t0.e0.vclk = tclk;
        t0.run();

        #200 $finish;
    end

    initial begin
        $dumpvars;
        $dumpfile("dump.vcd");
    end
endmodule