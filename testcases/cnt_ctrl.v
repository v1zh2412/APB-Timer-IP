task run_test();
	reg [31:0] task_rdata;

	begin
		$display("==================================================");
		$display("============= Test Case: COUNT CONTROL =============");
		$display("==================================================");

		$display("*** div_en = 1, div_val = 4'b0");
		test_bench.write(ADDR_TCR, 32'h0000_0002);
		test_bench.read(ADDR_TCR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0002);

		$display("timer_en = 1");
		test_bench.write(ADDR_TCR, 32'h0000_0003);
		test_bench.read(ADDR_TCR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0003);

		$display("wait 100 posedge clk");
		repeat(100) begin
			@(posedge clk);
		end

		test_bench.read(ADDR_TDR0, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_006F);
		test_bench.read(ADDR_TDR1, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0000);


		$display("***---------------------------***");
		$display("*** div_en = 1, div_val = 4'b1");
		test_bench.write(ADDR_TCR, 32'h0000_0002);
		test_bench.write(ADDR_TCR, 32'h0000_0102);
		test_bench.read(ADDR_TCR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0102);

		$display("timer_en = 1");
		test_bench.write(ADDR_TCR, 32'h0000_0103);
		test_bench.read(ADDR_TCR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0103);

		$display("wait 100 posedge clk");
		repeat(100) begin
			@(posedge clk);
		end

		test_bench.read(ADDR_TDR0, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0037);
		test_bench.read(ADDR_TDR1, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0000);

		$display("***---------------------------***");
		$display("*** div_en = 1, div_val = 4'b2");
		test_bench.write(ADDR_TCR, 32'h0000_0102);
		test_bench.write(ADDR_TCR, 32'h0000_0202);
		test_bench.read(ADDR_TCR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0202);

		$display("timer_en = 1");
		test_bench.write(ADDR_TCR, 32'h0000_0203);
		test_bench.read(ADDR_TCR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0203);

		$display("wait 100 posedge clk");
		repeat(100) begin
			@(posedge clk);
		end

		test_bench.read(ADDR_TDR0, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_001b);
		test_bench.read(ADDR_TDR1, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0000);

		$display("***---------------------------***");
		$display("*** div_en = 1, div_val = 4'b3");
		test_bench.write(ADDR_TCR, 32'h0000_0202);
		test_bench.write(ADDR_TCR, 32'h0000_0302);
		test_bench.read(ADDR_TCR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0302);

		$display("timer_en = 1");
		test_bench.write(ADDR_TCR, 32'h0000_0303);
		test_bench.read(ADDR_TCR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0303);

		$display("wait 100 posedge clk");
		repeat(100) begin
			@(posedge clk);
		end

		test_bench.read(ADDR_TDR0, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_000D);
		test_bench.read(ADDR_TDR1, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0000);

		$display("***---------------------------***");
		$display("*** div_en = 1, div_val = 4'b4");
		test_bench.write(ADDR_TCR, 32'h0000_0302);
		test_bench.write(ADDR_TCR, 32'h0000_0402);
		test_bench.read(ADDR_TCR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0402);

		$display("timer_en = 1");
		test_bench.write(ADDR_TCR, 32'h0000_0403);
		test_bench.read(ADDR_TCR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0403);

		$display("wait 100 posedge clk");
		repeat(100) begin
			@(posedge clk);
		end

		test_bench.read(ADDR_TDR0, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0006);
		test_bench.read(ADDR_TDR1, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0000);

		$display("***---------------------------***");
		$display("*** div_en = 1, div_val = 4'b5");
		test_bench.write(ADDR_TCR, 32'h0000_0402);
		test_bench.write(ADDR_TCR, 32'h0000_0502);
		test_bench.read(ADDR_TCR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0502);

		$display("timer_en = 1");
		test_bench.write(ADDR_TCR, 32'h0000_0503);
		test_bench.read(ADDR_TCR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0503);

		$display("wait 500 posedge clk");
		repeat(500) begin
			@(posedge clk);
		end

		test_bench.read(ADDR_TDR0, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_000F);
		test_bench.read(ADDR_TDR1, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0000);

		$display("***---------------------------***");
		$display("*** div_en = 1, div_val = 4'b6");
		test_bench.write(ADDR_TCR, 32'h0000_0502);
		test_bench.write(ADDR_TCR, 32'h0000_0602);
		test_bench.read(ADDR_TCR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0602);

		$display("timer_en = 1");
		test_bench.write(ADDR_TCR, 32'h0000_0603);
		test_bench.read(ADDR_TCR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0603);

		$display("wait 1000 posedge clk");
		repeat(1000) begin
			@(posedge clk);
		end

		test_bench.read(ADDR_TDR0, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_000f);
		test_bench.read(ADDR_TDR1, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0000);

		$display("***---------------------------***");
		$display("*** div_en = 1, div_val = 4'b7");
		test_bench.write(ADDR_TCR, 32'h0000_0602);
		test_bench.write(ADDR_TCR, 32'h0000_0702);
		test_bench.read(ADDR_TCR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0702);

		$display("timer_en = 1");
		test_bench.write(ADDR_TCR, 32'h0000_0703);
		test_bench.read(ADDR_TCR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0703);

		$display("wait 1500 posedge clk");
		repeat(1500) begin
			@(posedge clk);
		end

		test_bench.read(ADDR_TDR0, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_000B);
		test_bench.read(ADDR_TDR1, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0000);

		$display("***---------------------------***");
		$display("*** div_en = 1, div_val = 4'b8");
		test_bench.write(ADDR_TCR, 32'h0000_0702);
		test_bench.write(ADDR_TCR, 32'h0000_0802);
		test_bench.read(ADDR_TCR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0802);

		$display("timer_en = 1");
		test_bench.write(ADDR_TCR, 32'h0000_0803);
		test_bench.read(ADDR_TCR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0803);

		$display("wait 2000 posedge clk");
		repeat(2000) begin
			@(posedge clk);
		end

		test_bench.read(ADDR_TDR0, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0007);
		test_bench.read(ADDR_TDR1, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0000);

		$display("===============================================");
		$display("TDR0/1 count");
		$display("Reset TCR");
		test_bench.write(ADDR_TCR, 32'h0000_0802);
		test_bench.write(ADDR_TCR, 32'h0000_0102);
		test_bench.write(ADDR_TCR, 32'h0000_0100);
		test_bench.write(ADDR_TCR, 32'h0000_0101);
		test_bench.read(ADDR_TCR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0101);

		test_bench.write(ADDR_TDR0, 32'hFFFF_FFF0);
		test_bench.read(ADDR_TDR0, task_rdata);
		test_bench.cmp(task_rdata, 32'hFFFF_FFF3);
		test_bench.write(ADDR_TDR1, 32'h0000_0100);
		test_bench.read(ADDR_TDR1, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0100);

		$display("wait 100 posedge clk");
		repeat(100) begin
			@(posedge clk);
		end

		test_bench.read(ADDR_TDR0, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0066);
		test_bench.read(ADDR_TDR1, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0101);

		//toggle
		test_bench.write(ADDR_TCR, 32'h0000_0902);

		#100;
		$display("=== assert reset ===");

		test_bench.rst_n = 1'b0;
		#100;
		@(posedge test_bench.clk);
		#1;
		$display("=== release reset ===");
		test_bench.rst_n = 1'b1;

		if(test_bench.err != 0 )
			$display("Test_result FAILED");
		else
			$display("Test_result PASSED");



	end
endtask
