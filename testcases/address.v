task run_test();
    reg [31:0]  task_rdata;
    reg         err;
    begin
            err = 0;
        $display("=====================================");
        $display("=== Test Case: APB Un-aligned Test===");
        $display("=====================================");

        //normal APB
        test_bench.write(ADDR_TDR0, 32'h3333_3333);
        test_bench.read( ADDR_TDR0, task_rdata);
        test_bench.cmp(task_rdata, 32'h3333_3333);

        //un-aligned: offset 0x1
        $display("un-aligned: offset 0x1");
        test_bench.write(ADDR_TDR0+1, 32'h4444_4444);

        test_bench.read( ADDR_TDR0+1, task_rdata);
        test_bench.cmp(task_rdata, 32'h0);

        test_bench.read( ADDR_TDR0, task_rdata);
        test_bench.cmp(task_rdata, 32'h3333_3333);

        //un-aligned: offset 0x2
        $display("un-aligned: offset 0x2");
        test_bench.write(ADDR_TDR0+2, 32'h4444_4444);

        test_bench.read( ADDR_TDR0+2, task_rdata);
        test_bench.cmp(task_rdata, 32'h0);

        test_bench.read( ADDR_TDR0, task_rdata);
        test_bench.cmp(task_rdata, 32'h3333_3333);

        //un-aligned: offset 0x3
        $display("un-aligned: offset 0x3");
        test_bench.write(ADDR_TDR0+2, 32'h4444_4444);

        test_bench.read( ADDR_TDR0+3, task_rdata);
        test_bench.cmp(task_rdata, 32'h0);

        test_bench.read( ADDR_TDR0, task_rdata);
        test_bench.cmp(task_rdata, 32'h3333_3333);

        //toggle
        test_bench.write(12'hFFF, 32'hFFFF_FFFF);
        test_bench.write(12'h000, 32'hFFFF_FFFF);

        if( test_bench.err != 0 )
            $display("Test_result FAILED");
        else
            $display("Test_result PASSED");

    end


endtask
