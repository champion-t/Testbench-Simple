class test;
    env e0;

    extern function new();
    extern virtual task run();
endclass

function test::new();
    e0 = new();
endfunction

task test::run();
    e0.run();
endtask