module reg_ctrl #(
    parameter ADDR_WIDTH    = 8,
    parameter DATA_WIDTH    = 16,
    parameter DEPTH         = 256,
    parameter RESET_VAL     = 16'h1507
) (
    input                       clk,
    input                       rstn,
    input                       sel,
    input                       wr,
    input      [ADDR_WIDTH-1:0] addr,
    input      [DATA_WIDTH-1:0] wdata,
    output reg [DATA_WIDTH-1:0] rdata,
    output reg                  ready
);

    reg [DATA_WIDTH-1:0] ctrl [DEPTH];
    reg  ready_dly;
    wire ready_pe;

    always @(posedge clk or negedge rstn) begin
        if(!rstn) begin
            for (int i = 0; i < DEPTH; i++) begin
                ctrl[i] <= RESET_VAL;
            end
        end
        else begin
            if (sel & ready & wr) begin
                ctrl[addr] <= wdata;
            end

            if (sel & ready & !wr) begin
                rdata <= ctrl[addr];
            end
            else begin
                rdata <= 0;
            end
        end
    end

    always @(posedge clk or negedge rstn) begin
        if(!rstn) begin
            ready <= 1;
        end
        else begin
            if (sel & ready_pe) begin
                ready <= 1;
            end

            if (sel & ready & !wr) begin
                ready <= 0;
            end
        end
    end

    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            ready_dly <= 1;
        end
        else begin
            ready_dly <= ready;
        end
    end

    assign ready_pe = ~ready & ready_dly;
endmodule