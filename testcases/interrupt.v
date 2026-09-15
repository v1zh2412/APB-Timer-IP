task run_test();
	reg [31:0] task_rdata;
	begin
		$display("==================================================");
		$display("============= Test Case: INTERRRUPT =============");
		$display("==================================================");

		$display("*** Clear TISR");
		test_bench.write(ADDR_TISR, 32'h1);

		$display("*** Enable interrupt");
		test_bench.write(ADDR_TIER, 32'h1);

		$display("*** Set interrupt at cnt = 100");
		test_bench.write(ADDR_TCMP0, 32'h64);
		test_bench.write(ADDR_TCMP1, 32'h0);

		$display("*** Start timer - timer_en = 1");
		test_bench.write(ADDR_TCR, 32'h1);

		repeat(100) begin
			@(posedge clk);
		end

		$display("*** Read data cnt");
		test_bench.read(ADDR_TDR0, task_rdata);

		$display("*** interrupt check");
		test_bench.cmp(test_bench.tim_int, 1'b1);

		$display("============================");

		$display("*** Clear interrupt");
		test_bench.write(ADDR_TISR, 32'h1);
		test_bench.cmp(test_bench.tim_int, 1'b0);

		$display("*** Reset cnt");
		test_bench.write(ADDR_TCR, 32'h0);

		$display("*** Interrupt at cnt = 200");
		test_bench.write(ADDR_TCMP0, 32'hC8);
		test_bench.write(ADDR_TCMP1, 32'h0);

		$display("*** Start timer - timer_en = 1");
		test_bench.write(ADDR_TCR, 32'h1);

		repeat(200) begin
			@(posedge clk);
		end

		$display("*** Read data cnt");
		test_bench.read(ADDR_TDR0, task_rdata);

		$display("*** interrupt check");
		test_bench.cmp(test_bench.tim_int, 1'b1);

		test_bench.write(ADDR_TIER, 32'h0);




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
