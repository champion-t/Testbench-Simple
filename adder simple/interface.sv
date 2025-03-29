interface aif;
    logic       rstn;
    logic [7:0] a;
    logic [7:0] b;
    logic [8:0] sum;
    logic       carry;
endinterface

interface aclk;
    logic clk;
    initial begin
        clk <= 0;
    end
    always #10 clk = ~clk;
endinterface