`ifndef PACKET_SV
`define PACKET_SV

class Packet;
    rand    bit [7:0]   addr;
    rand    bit [15:0]  wdata;
    rand    bit         wr;
            bit [15:0]  rdata;

    extern function void print(string tag="");
endclass

function void Packet::print(string tag="");
    $display("[T=%0t] [%s] addr=0x%0h wr=0x%0h wdata=0x%0h rdata=0x%0h", $time, tag, addr, wr, wdata, rdata);
endfunction

`endif