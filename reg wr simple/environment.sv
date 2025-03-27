`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"

class Env;
    Driver      d0;
    Monitor     m0;
    Scoreboard  s0;
    mailbox     scb_mbx;
    virtual rif  vif;

    extern function new();
    extern virtual task run();
endclass

function Env::new();
    d0 = new;
    m0 = new;
    s0 = new;
    scb_mbx = new();
endfunction

task Env::run();
    d0.vif = vif;
    m0.vif = vif;
    m0.scb_mbx = scb_mbx;
    s0.scb_mbx = scb_mbx;

    fork
        s0.run();
        d0.run();
        m0.run();
    join_any
endtask