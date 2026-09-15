task run_test();
	reg [31:0] task_rdata;
	begin
		$display("==================================================");
		$display("============= Test Case: COUNT DEFAULT =============");
		$display("==================================================");

		$display("timer_en = 1");
		test_bench.write(ADDR_TCR, 32'h1);

		$display("wait 10 posedge clk");
		repeat(10) begin
			@(posedge clk);
		end

		test_bench.read(ADDR_TDR0, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0010);
		test_bench.read(ADDR_TDR1, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0000);

		$display("wait 100 posedge clk");
		repeat(100) begin
			@(posedge clk);
		end

		test_bench.read(ADDR_TDR0, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_007E);
		test_bench.read(ADDR_TDR1, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0000);

		$display("timer_en = 0 => count reset");
		test_bench.write(ADDR_TCR, 32'h0);
		test_bench.read(ADDR_TDR0, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0000);
		test_bench.read(ADDR_TDR1, task_rdata);
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
