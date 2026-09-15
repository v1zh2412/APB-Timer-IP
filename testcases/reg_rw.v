task run_test();
	reg [31:0] task_rdata;
	begin
		$display("==================================================");
		$display("============= Test Case: Register RW =============");
		$display("==================================================");

		//$display("*** TCR => Timer_en = 1 ***");
		//test_bench.write(ADDR_TCR, 32'h1);

		$display("*** TISR ***");
		test_bench.write(ADDR_TISR, 0);
		test_bench.read(ADDR_TISR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0);

		test_bench.write(ADDR_TISR, 32'hFFFF_FFFF);
		test_bench.read(ADDR_TISR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0);

		test_bench.write(ADDR_TISR, 32'h5555_5555);
		test_bench.read(ADDR_TISR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0);

		test_bench.write(ADDR_TISR, 32'hAAAA_AAAA);
		test_bench.read(ADDR_TISR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0);

		test_bench.write(ADDR_TISR, 32'h5AA5_A55A);
		test_bench.read(ADDR_TISR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0);

		$display("*** TDR0 ***");
		$display("When timer_en changes from H->L");
		test_bench.write(ADDR_TDR0, 0);
		test_bench.write(ADDR_TCR, 1);
		test_bench.write(ADDR_TCR, 0);
		test_bench.read(ADDR_TDR0, task_rdata);
		test_bench.cmp(task_rdata, 32'h0);

		test_bench.write(ADDR_TDR0, 32'hFFFF_FFFF);
		test_bench.write(ADDR_TCR, 1);
		test_bench.write(ADDR_TCR, 0);
		test_bench.read(ADDR_TDR0, task_rdata);
		test_bench.cmp(task_rdata, 32'h0);

		test_bench.write(ADDR_TDR0, 32'h5555_5555);
		test_bench.write(ADDR_TCR, 1);
		test_bench.write(ADDR_TCR, 0);
		test_bench.read(ADDR_TDR0, task_rdata);
		test_bench.cmp(task_rdata, 32'h0);

		test_bench.write(ADDR_TDR0, 32'hAAAA_AAAA);
		test_bench.write(ADDR_TCR, 1);
		test_bench.write(ADDR_TCR, 0);
		test_bench.read(ADDR_TDR0, task_rdata);
		test_bench.cmp(task_rdata, 32'h0);

		test_bench.write(ADDR_TDR0, 32'h5AA5_A55A);
		test_bench.write(ADDR_TCR, 1);
		test_bench.write(ADDR_TCR, 0);
		test_bench.read(ADDR_TDR0, task_rdata);
		test_bench.cmp(task_rdata, 32'h0);

		$display("*** TDR1 ***");
		$display("When timer_en changes from H->L");
		test_bench.write(ADDR_TDR1, 0);
		test_bench.write(ADDR_TCR, 1);
		test_bench.write(ADDR_TCR, 0);
		test_bench.read(ADDR_TDR1, task_rdata);
		test_bench.cmp(task_rdata, 32'h0);

		test_bench.write(ADDR_TDR1, 32'hFFFF_FFFF);
		test_bench.write(ADDR_TCR, 1);
		test_bench.write(ADDR_TCR, 0);
		test_bench.read(ADDR_TDR1, task_rdata);
		test_bench.cmp(task_rdata, 32'h0);

		test_bench.write(ADDR_TDR1, 32'h5555_5555);
		test_bench.write(ADDR_TCR, 1);
		test_bench.write(ADDR_TCR, 0);
		test_bench.read(ADDR_TDR1, task_rdata);
		test_bench.cmp(task_rdata, 32'h0);

		test_bench.write(ADDR_TDR1, 32'hAAAA_AAAA);
		test_bench.write(ADDR_TCR, 1);
		test_bench.write(ADDR_TCR, 0);
		test_bench.read(ADDR_TDR1, task_rdata);
		test_bench.cmp(task_rdata, 32'h0);

		test_bench.write(ADDR_TDR1, 32'h5AA5_A55A);
		test_bench.write(ADDR_TCR, 1);
		test_bench.write(ADDR_TCR, 0);
		test_bench.read(ADDR_TDR1, task_rdata);
		test_bench.cmp(task_rdata, 32'h0);

		$display("*** TCMP0 ***");
		test_bench.write(ADDR_TCMP0, 0);
		test_bench.read(ADDR_TCMP0, task_rdata);
		test_bench.cmp(task_rdata, 32'h0);

		test_bench.write(ADDR_TCMP0, 32'hFFFF_FFFF);
		test_bench.read(ADDR_TCMP0, task_rdata);
		test_bench.cmp(task_rdata, 32'hFFFF_FFFF);

		test_bench.write(ADDR_TCMP0, 32'h5555_5555);
		test_bench.read(ADDR_TCMP0, task_rdata);
		test_bench.cmp(task_rdata, 32'h5555_5555);

		test_bench.write(ADDR_TCMP0, 32'hAAAA_AAAA);
		test_bench.read(ADDR_TCMP0, task_rdata);
		test_bench.cmp(task_rdata, 32'hAAAA_AAAA);

		test_bench.write(ADDR_TCMP0, 32'h5AA5_A55A);
		test_bench.read(ADDR_TCMP0, task_rdata);
		test_bench.cmp(task_rdata, 32'h5AA5_A55A);

		$display("*** TCMP1 ***");
		test_bench.write(ADDR_TCMP1, 0);
		test_bench.read(ADDR_TCMP1, task_rdata);
		test_bench.cmp(task_rdata, 32'h0);

		test_bench.write(ADDR_TCMP1, 32'hFFFF_FFFF);
		test_bench.read(ADDR_TCMP1, task_rdata);
		test_bench.cmp(task_rdata, 32'hFFFF_FFFF);

		test_bench.write(ADDR_TCMP1, 32'h5555_5555);
		test_bench.read(ADDR_TCMP1, task_rdata);
		test_bench.cmp(task_rdata, 32'h5555_5555);

		test_bench.write(ADDR_TCMP1, 32'hAAAA_AAAA);
		test_bench.read(ADDR_TCMP1, task_rdata);
		test_bench.cmp(task_rdata, 32'hAAAA_AAAA);

		test_bench.write(ADDR_TCMP1, 32'h5AA5_A55A);
		test_bench.read(ADDR_TCMP1, task_rdata);
		test_bench.cmp(task_rdata, 32'h5AA5_A55A);

		$display("*** TIER ***");
		test_bench.write(ADDR_TIER, 0);
		test_bench.read(ADDR_TIER, task_rdata);
		test_bench.cmp(task_rdata, 32'h0);

		test_bench.write(ADDR_TIER, 32'hFFFF_FFFF);
		test_bench.read(ADDR_TIER, task_rdata);
		test_bench.cmp(task_rdata, 32'h1);

		test_bench.write(ADDR_TIER, 32'h5555_5555);
		test_bench.read(ADDR_TIER, task_rdata);
		test_bench.cmp(task_rdata, 32'h1);

		test_bench.write(ADDR_TIER, 32'hAAAA_AAAA);
		test_bench.read(ADDR_TIER, task_rdata);
		test_bench.cmp(task_rdata, 32'h0);

		test_bench.write(ADDR_TIER, 32'h5AA5_A55A);
		test_bench.read(ADDR_TIER, task_rdata);
		test_bench.cmp(task_rdata, 32'h0);

		$display("*** THCSR ***");
		test_bench.write(ADDR_THCSR, 0);
		test_bench.read(ADDR_THCSR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0);

		test_bench.write(ADDR_THCSR, 32'hFFFF_FFFF);
		test_bench.read(ADDR_THCSR, task_rdata);
		test_bench.cmp(task_rdata, 32'h1);

		test_bench.write(ADDR_THCSR, 32'h5555_5555);
		test_bench.read(ADDR_THCSR, task_rdata);
		test_bench.cmp(task_rdata, 32'h1);

		test_bench.write(ADDR_THCSR, 32'hAAAA_AAAA);
		test_bench.read(ADDR_THCSR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0);

		test_bench.write(ADDR_THCSR, 32'h5AA5_A55A);
		test_bench.read(ADDR_THCSR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0);

		$display("*** TCR ***");
		$display("When timer_en is Low");
		test_bench.write(ADDR_TCR, 0);
		test_bench.read(ADDR_TCR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0);

		test_bench.write(ADDR_TCR, 32'hFFFF_FFFE);
		test_bench.read(ADDR_TCR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0);

		test_bench.write(ADDR_TCR, 32'h5555_5554);
		test_bench.read(ADDR_TCR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0500);

		test_bench.write(ADDR_TCR, 32'hAAAA_AAAA);
		test_bench.read(ADDR_TCR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0500);

		test_bench.write(ADDR_TCR, 32'h5AA5_A55A);
		test_bench.read(ADDR_TCR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0502);

		$display("div_val_check");
		$display("clear to all 0");
		test_bench.write(ADDR_TCR, 0);
		test_bench.read(ADDR_TCR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0);

		$display("write div_val = 8");
		test_bench.write(ADDR_TCR, 32'h0000_0802);
		test_bench.read(ADDR_TCR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0802);

		$display("write div_val = 9");
		test_bench.write(ADDR_TCR, 32'h0000_0902);
		test_bench.read(ADDR_TCR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0802);

		$display("write div_val = 7");
		test_bench.write(ADDR_TCR, 32'h0000_0702);
		test_bench.read(ADDR_TCR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0702);

		$display("*** TCR ***");
		$display("When timer_en is HIGH");
		test_bench.write(ADDR_TCR, 0);
		test_bench.read(ADDR_TCR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0);

		test_bench.write(ADDR_TCR, 32'hFFFF_FFFF);
		test_bench.read(ADDR_TCR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0);

		test_bench.write(ADDR_TCR, 32'h5555_5555);
		test_bench.read(ADDR_TCR, task_rdata);
		test_bench.cmp(task_rdata, 32'h501);

		test_bench.write(ADDR_TCR, 32'hAAAA_AAAB);
		test_bench.read(ADDR_TCR, task_rdata);
		test_bench.cmp(task_rdata, 32'h501);
		test_bench.write(ADDR_TCR, 32'h5AA5_A55B);
		test_bench.read(ADDR_TCR, task_rdata);
		test_bench.cmp(task_rdata, 32'h501);

		$display("div_val_check");
		$display("clear to all 0");
		test_bench.write(ADDR_TCR, 0);
		test_bench.read(ADDR_TCR, task_rdata);
		test_bench.cmp(task_rdata, 32'h501);


		$display("write div_val = 8");
		test_bench.write(ADDR_TCR, 32'h0000_0803);
		test_bench.read(ADDR_TCR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0501);

		$display("write div_val = 9");
		test_bench.write(ADDR_TCR, 32'h0000_0903);
		test_bench.read(ADDR_TCR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0501);

		$display("write div_val = 7");
		test_bench.write(ADDR_TCR, 32'h0000_0703);
		test_bench.read(ADDR_TCR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0501);

		$display("*** TDR0 ***");
		$display("When timer_en changes from L->H");
		test_bench.write(ADDR_TCR, 32'h1);

		test_bench.write(ADDR_TDR0, 0);
		test_bench.read(ADDR_TDR0, task_rdata);
		test_bench.cmp(task_rdata, 32'h3);

		test_bench.write(ADDR_TDR0, 32'hFFFF_FFFF);
		test_bench.read(ADDR_TDR0, task_rdata);
		test_bench.cmp(task_rdata, 32'h2);

		test_bench.write(ADDR_TDR0, 32'h5555_5555);
		test_bench.read(ADDR_TDR0, task_rdata);
		test_bench.cmp(task_rdata, 32'h5555_5558);

		test_bench.write(ADDR_TDR0, 32'hAAAA_AAAA);
		test_bench.read(ADDR_TDR0, task_rdata);
		test_bench.cmp(task_rdata, 32'hAAAA_AAAD);

		test_bench.write(ADDR_TDR0, 32'h5AA5_A55A);
		test_bench.read(ADDR_TDR0, task_rdata);
		test_bench.cmp(task_rdata, 32'h5AA5_A55D);

		$display("*** TDR1 ***");
		$display("When timer_en changes from H->L");
		test_bench.write(ADDR_TDR1, 0);
		test_bench.read(ADDR_TDR1, task_rdata);
		test_bench.cmp(task_rdata, 32'h0);

		test_bench.write(ADDR_TDR1, 32'hFFFF_FFFF);
		test_bench.read(ADDR_TDR1, task_rdata);
		test_bench.cmp(task_rdata, 32'hFFFF_FFFF);

		test_bench.write(ADDR_TDR1, 32'h5555_5555);
		test_bench.read(ADDR_TDR1, task_rdata);
		test_bench.cmp(task_rdata, 32'h5555_5555);

		test_bench.write(ADDR_TDR1, 32'hAAAA_AAAA);
		test_bench.read(ADDR_TDR1, task_rdata);
		test_bench.cmp(task_rdata, 32'hAAAA_AAAA);

		test_bench.write(ADDR_TDR1, 32'h5AA5_A55A);
		test_bench.read(ADDR_TDR1, task_rdata);
		test_bench.cmp(task_rdata, 32'h5AA5_A55A);

		//toggle
		test_bench.read(32'h100, task_rdata);

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
