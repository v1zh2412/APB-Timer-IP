task run_test();
	reg [31:0] task_rdata;
	begin
		$display("==================================================");
		$display("============= Test Case: DEBUG MODE =============");
		$display("==================================================");

		$display("*** Start timer");
		test_bench.write(ADDR_TCR, 32'h1);

		$display("*** wait 100 clk");
		repeat(93) begin
			@(posedge clk);
		end

		$display("*** Debug mode");
		test_bench.write(ADDR_THCSR, 32'h1);
		test_bench.dbg_mode = 1'b1;

		$display("*** check cnt");
		test_bench.read(ADDR_TDR0, task_rdata);
		test_bench.cmp(task_rdata, 32'h65);

		$display("*** wait 10 clk & check");
		repeat(10) begin
			@(posedge clk);
		end

		test_bench.read(ADDR_TDR0, task_rdata);
		test_bench.cmp(task_rdata, 32'h65);

		$display("*** Exit debug mode");
		test_bench.write(ADDR_THCSR, 32'h0);
		test_bench.dbg_mode = 1'b0;

		$display("*** wait 10 clk & check");
		repeat(6) begin
			@(posedge clk);
		end

		test_bench.read(ADDR_TDR0, task_rdata);
		test_bench.cmp(task_rdata, 32'h71);

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
