class packet;
    rand bit        rstn;
    rand bit [7:0]  a;
    rand bit [7:0]  b;
    bit [8:0]       sum;
    bit             carry;

    extern function void print(string tag="");
    extern function void copy(packet tmp);
endclass

function void packet::print(string tag="");
    $display("[T=%0t] [%s] a=0x%0h b=0x%0h sum=0x%0h carry=0x%0h", $time, tag, a, b, sum, carry);
endfunction

function void packet::copy(packet tmp);
    this.rstn = tmp.rstn;
    this.a = tmp.a;
    this.b = tmp.b;
    this.sum = tmp.sum;
    this.carry = tmp.carry;
endfunction