class env;
    generator g0;
    driver d0;
    monitor m0;
    scoreboard s0;
    mailbox scb_mbx;
    mailbox drv_mbx;
    virtual aif vif;
    virtual aclk vclk;
    event drv_done;

    extern function new();
    extern virtual task run();
endclass

function env::new();
    g0 = new;
    d0 = new;
    m0 = new;
    s0 = new;
    scb_mbx = new();
    drv_mbx = new();
endfunction

task env::run();
    d0.vif = vif;
    d0.vclk = vclk;
    m0.vif = vif;
    m0.vclk = vclk;

    g0.drv_done = drv_done;
    d0.drv_done = drv_done;

    g0.drv_mbx = drv_mbx;
    d0.drv_mbx = drv_mbx;

    m0.scb_mbx = scb_mbx;
    s0.scb_mbx = scb_mbx;

    fork
        g0.run();
        d0.run();
        m0.run();
        s0.run();
    join_any
endtask