interface rif(input bit clk);
    logic           rstn;
    logic           sel;
    logic           wr;
    logic   [7:0]   addr;
    logic   [15:0]  wdata;  
    logic   [15:0]  rdata;
    logic           ready;
endinterface