task run_test();
	reg [31:0] task_rdata;
	begin
		$display("==================================================");
		$display("============= Test Case: Register INIT =============");
		$display("==================================================");

		$display("*** TCR ***");
		test_bench.read(ADDR_TCR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0100);

		$display("*** TDR0 ***");
		test_bench.read(ADDR_TDR0, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0000);

		$display("*** TDR1 ***");
		test_bench.read(ADDR_TDR1, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0000);

		$display("*** TCMP0 ***");
		test_bench.read(ADDR_TCMP0, task_rdata);
		test_bench.cmp(task_rdata, 32'hFFFF_FFFF);

		$display("*** TCMP1 ***");
		test_bench.read(ADDR_TCMP1, task_rdata);
		test_bench.cmp(task_rdata, 32'hFFFF_FFFF);

		$display("*** TIER ***");
		test_bench.read(ADDR_TIER, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0000);

		$display("*** TISR ***");
		test_bench.read(ADDR_TISR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0000);

		$display("*** THCSR ***");
		test_bench.read(ADDR_THCSR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0000);

		#100;
		$display("=== assert reset ===");

		test_bench.rst_n = 1'b0;
		#100;
		@(posedge test_bench.clk);
		#1;
		$display("=== release reset ===");
		test_bench.rst_n = 1'b1;

		if(test_bench.err != 0)
			$display("Test_result FAILED");
		else
			$display("Test_result PASSED");

	end
endtask
