task run_test();
	reg [31:0] task_rdata;
	begin
		$display("==================================================");
		$display("============= Test Case: TOGGLE COV ==============");
		$display("==================================================");

		$display("=== force all reserved bits to 1 ===");
		force test_bench.u_top.address		= 32'hFFFF_FFFF;
		force test_bench.u_top.u_reg.addr	= 32'hFFFF_FFFF;
		force test_bench.u_top.u_reg.tcr_tmp	= 32'hFFFF_FFFF;
		force test_bench.u_top.u_reg.tcr	= 32'hFFFF_FFFF;
		force test_bench.u_top.u_reg.tier	= 32'hFFFF_FFFF;
		force test_bench.u_top.u_reg.tisr	= 32'hFFFF_FFFF;
		force test_bench.u_top.u_reg.thcsr_tmp	= 32'hFFFF_FFFF;
		force test_bench.u_top.u_reg.thcsr	= 32'hFFFF_FFFF;
		repeat(2) @(posedge test_bench.clk);

		$display("=== force all reserved bits to 0 ===");
		force test_bench.u_top.address		= 32'h0000_0000;
		force test_bench.u_top.u_reg.addr	= 32'h0000_0000;
		force test_bench.u_top.u_reg.tcr_tmp	= 32'h0000_0000;
		force test_bench.u_top.u_reg.tcr	= 32'h0000_0000;
		force test_bench.u_top.u_reg.tier	= 32'h0000_0000;
		force test_bench.u_top.u_reg.tisr	= 32'h0000_0000;
		force test_bench.u_top.u_reg.thcsr_tmp	= 32'h0000_0000;
		force test_bench.u_top.u_reg.thcsr	= 32'h0000_0000;
		repeat(2) @(posedge test_bench.clk);

		$display("=== release ===");
		release test_bench.u_top.address;
		release test_bench.u_top.u_reg.addr;
		release test_bench.u_top.u_reg.tcr_tmp;
		release test_bench.u_top.u_reg.tcr;
		release test_bench.u_top.u_reg.tier;
		release test_bench.u_top.u_reg.tisr;
		release test_bench.u_top.u_reg.thcsr_tmp;
		release test_bench.u_top.u_reg.thcsr;
		repeat(2) @(posedge test_bench.clk);

		#100;
		$display("=== assert reset ===");

		test_bench.rst_n = 1'b0;
		#100;
		@(posedge test_bench.clk);
		#1;
		$display("=== release reset ===");
		test_bench.rst_n = 1'b1;

		// sanity check: DUT is back to normal after force/release + reset
		$display("=== sanity check after reset ===");
		test_bench.read(ADDR_TCR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0100);
		test_bench.read(ADDR_TIER, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0000);
		test_bench.read(ADDR_TISR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0000);
		test_bench.read(ADDR_THCSR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0000);

		test_bench.write(ADDR_TDR0, 32'h1234_5678);
		test_bench.read(ADDR_TDR0, task_rdata);
		test_bench.cmp(task_rdata, 32'h1234_5678);

		if(test_bench.err != 0)
			$display("Test_result FAILED");
		else
			$display("Test_result PASSED");


	end
endtask
