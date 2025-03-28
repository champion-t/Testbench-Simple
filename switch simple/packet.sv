// `ifndef PACKET_SV
// `define PACKET_SV

class packet;
    rand bit [7:0]  addr;
    rand bit [15:0] data;
    bit [7:0]       addr_a;
    bit [15:0]      data_a;
    bit [7:0]       addr_b;
    bit [15:0]      data_b;

    extern function void print(string tag="");
endclass

function void packet::print(string tag="");
    $display("[T=%0t] [%s] addr=0x%0h data=0x%0h addr_a=0x%0h data_a=0x%0h addr_b=0x%0h data_b=0x%0h", $time, tag, addr, data, addr_a, data_a, addr_b, data_b);
endfunction

// `endif