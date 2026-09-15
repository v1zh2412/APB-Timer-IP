task run_test();
	reg [31:0] task_rdata;
	reg error;
	begin
		$display("==================================================");
		$display("============= Test Case: Register Slave ERROR =============");
		$display("==================================================");

		$display("------------- TCR error ---------------------");
		$display("*** div_en err");
		$display("timer_en = 1");
		test_bench.write(ADDR_TCR, 32'h1);
		$display("div_en change");
		test_bench.write(ADDR_TCR, 32'h3);

		if(test_bench.pslverr == 1) begin
			$display("SLAVE ERROR");
		end
		else begin
			$display("FAIL");
			error = error + 1;
		end

		$display("*** div_val err 1 - div_val = prohibit settings");
		test_bench.write(ADDR_TCR, 32'h0);
		test_bench.write(ADDR_TCR, 32'h2);
		test_bench.write(ADDR_TCR, 32'h902);

		if(test_bench.pslverr == 1) begin
			$display("SLAVE ERROR");
		end
		else begin
			$display("FAIL");
			error = error + 1;
		end

		$display("*** div_val err 2 - change when timer_en is high");
		test_bench.write(ADDR_TCR, 32'h0);
		test_bench.write(ADDR_TCR, 32'h2);
		test_bench.write(ADDR_TCR, 32'h3);
		test_bench.write(ADDR_TCR, 32'h403);

		if(test_bench.pslverr == 1) begin
			$display("SLAVE ERROR");
		end
		else begin
			$display("FAIL");
			error = error + 1;
		end

		test_bench.psel = 0;
		test_bench.pwrite = 1;
		test_bench.penable = 1;
		#1 test_bench.pwrite = 0;

		#100;
		$display("=== assert reset ===");

		test_bench.rst_n = 1'b0;
		#100;
		@(posedge test_bench.clk);
		#1;
		$display("=== release reset ===");
		test_bench.rst_n = 1'b1;


		if(error != 0)
			$display("Test_result FAILED");
		else
			$display("Test_result PASSED");
	end
endtask
