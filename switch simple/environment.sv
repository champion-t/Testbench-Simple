class env;
    driver d0;
    monitor m0;
    generator g0;
    scoreboard s0;

    mailbox drv_mbx;
    mailbox scb_mbx;
    event drv_done;

    virtual sif vif;

    extern function new();
    extern task run();
endclass

function env::new();
    d0 = new;
    m0 = new;
    g0 = new;
    s0 = new;
    drv_mbx = new();
    scb_mbx = new();

    g0.drv_mbx = drv_mbx;
    d0.drv_mbx = drv_mbx;
    m0.scb_mbx = scb_mbx;
    s0.scb_mbx = scb_mbx;

    g0.drv_done = drv_done;
    d0.drv_done = drv_done;
endfunction

task env::run();
    d0.vif = vif;
    m0.vif = vif;

    fork
        d0.run();
        m0.run();
        g0.run();
        s0.run();
    join_any
endtask