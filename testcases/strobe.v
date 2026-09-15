task run_test();
	reg [31:0] task_rdata;
	begin
		$display("==================================================");
		$display("============= Test Case: Strobe ==== =============");
		$display("==================================================");

		$display("----------*** TDR0 ***-----------");
		$display(" 1111 ");
		test_bench.pstrb = 4'b1111;
		test_bench.write(ADDR_TDR0, 32'hFFFF_FFFF);
		test_bench.read(ADDR_TDR0, task_rdata);
		test_bench.cmp(task_rdata, 32'hFFFF_FFFF);

		$display(" 0001 ");
		test_bench.pstrb = 4'b0001;
		test_bench.write(ADDR_TDR0, 32'hAAAA_AAAA);
		test_bench.read(ADDR_TDR0, task_rdata);
		test_bench.cmp(task_rdata, 32'hFFFF_FFAA);

		$display(" 0010 ");
		test_bench.pstrb = 4'b0010;
		test_bench.write(ADDR_TDR0, 32'h5555_5555);
		test_bench.read(ADDR_TDR0, task_rdata);
		test_bench.cmp(task_rdata, 32'hFFFF_55AA);

		$display(" 0100 ");
		test_bench.pstrb = 4'b0100;
		test_bench.write(ADDR_TDR0, 32'hA5A5_A5A5);
		test_bench.read(ADDR_TDR0, task_rdata);
		test_bench.cmp(task_rdata, 32'hFFA5_55AA);

		$display(" 1000 ");
		test_bench.pstrb = 4'b1000;
		test_bench.write(ADDR_TDR0, 32'h5A5A_5A5A);
		test_bench.read(ADDR_TDR0, task_rdata);
		test_bench.cmp(task_rdata, 32'h5AA5_55AA);

		$display(" 0011 ");
		test_bench.pstrb = 4'b0011;
		test_bench.write(ADDR_TDR0, 32'hAA55_AA55);
		test_bench.read(ADDR_TDR0, task_rdata);
		test_bench.cmp(task_rdata, 32'h5AA5_AA55);

		$display(" 1100 ");
		test_bench.pstrb = 4'b1100;
		test_bench.write(ADDR_TDR0, 32'h55AA_55AA);
		test_bench.read(ADDR_TDR0, task_rdata);
		test_bench.cmp(task_rdata, 32'h55AA_AA55);

		$display(" 0110 ");
		test_bench.pstrb = 4'b0110;
		test_bench.write(ADDR_TDR0, 32'hA55A_A55A);
		test_bench.read(ADDR_TDR0, task_rdata);
		test_bench.cmp(task_rdata, 32'h555A_A555);

		$display(" 1001 ");
		test_bench.pstrb = 4'b1001;
		test_bench.write(ADDR_TDR0, 32'h5AA5_5AA5);
		test_bench.read(ADDR_TDR0, task_rdata);
		test_bench.cmp(task_rdata, 32'h5A5A_A5A5);

		 $display("----------*** TDR1 ***-----------");
		$display(" 1111 ");
		test_bench.pstrb = 4'b1111;
		test_bench.write(ADDR_TDR1, 32'hFFFF_FFFF);
		test_bench.read(ADDR_TDR1, task_rdata);
		test_bench.cmp(task_rdata, 32'hFFFF_FFFF);

		$display(" 0001 ");
		test_bench.pstrb = 4'b0001;
		test_bench.write(ADDR_TDR1, 32'hAAAA_AAAA);
		test_bench.read(ADDR_TDR1, task_rdata);
		test_bench.cmp(task_rdata, 32'hFFFF_FFAA);

		$display(" 0010 ");
		test_bench.pstrb = 4'b0010;
		test_bench.write(ADDR_TDR1, 32'h5555_5555);
		test_bench.read(ADDR_TDR1, task_rdata);
		test_bench.cmp(task_rdata, 32'hFFFF_55AA);

		$display(" 0100 ");
		test_bench.pstrb = 4'b0100;
		test_bench.write(ADDR_TDR1, 32'hA5A5_A5A5);
		test_bench.read(ADDR_TDR1, task_rdata);
		test_bench.cmp(task_rdata, 32'hFFA5_55AA);

		$display(" 1000 ");
		test_bench.pstrb = 4'b1000;
		test_bench.write(ADDR_TDR1, 32'h5A5A_5A5A);
		test_bench.read(ADDR_TDR1, task_rdata);
		test_bench.cmp(task_rdata, 32'h5AA5_55AA);

		$display(" 0011 ");
		test_bench.pstrb = 4'b0011;
		test_bench.write(ADDR_TDR1, 32'hAA55_AA55);
		test_bench.read(ADDR_TDR1, task_rdata);
		test_bench.cmp(task_rdata, 32'h5AA5_AA55);

		$display(" 1100 ");
		test_bench.pstrb = 4'b1100;
		test_bench.write(ADDR_TDR1, 32'h55AA_55AA);
		test_bench.read(ADDR_TDR1, task_rdata);
		test_bench.cmp(task_rdata, 32'h55AA_AA55);

		$display(" 0110 ");
		test_bench.pstrb = 4'b0110;
		test_bench.write(ADDR_TDR1, 32'hA55A_A55A);
		test_bench.read(ADDR_TDR1, task_rdata);
		test_bench.cmp(task_rdata, 32'h555A_A555);

		$display(" 1001 ");
		test_bench.pstrb = 4'b1001;
		test_bench.write(ADDR_TDR1, 32'h5AA5_5AA5);
		test_bench.read(ADDR_TDR1, task_rdata);
		test_bench.cmp(task_rdata, 32'h5A5A_A5A5);


		$display("----------*** TCR ***-----------");
		$display(" 1111 ");
		test_bench.pstrb = 4'b1111;
		test_bench.write(ADDR_TCR, 32'hFFFF_FFFF);
		test_bench.read(ADDR_TCR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0100);

		$display(" 0001 ");
		test_bench.pstrb = 4'b0001;
		test_bench.write(ADDR_TCR, 32'hAAAA_AAAA);
		test_bench.read(ADDR_TCR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0102);

		$display(" 0010 ");
		test_bench.pstrb = 4'b0010;
		test_bench.write(ADDR_TCR, 32'h5555_5555);
		test_bench.read(ADDR_TCR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0502);

		$display(" 0100 ");
		test_bench.pstrb = 4'b0100;
		test_bench.write(ADDR_TCR, 32'hA5A5_A5A5);
		test_bench.read(ADDR_TCR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0502);

		$display(" 1000 ");
		test_bench.pstrb = 4'b1000;
		test_bench.write(ADDR_TCR, 32'h5A5A_5A5A);
		test_bench.read(ADDR_TCR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0502);

		$display(" 0011 ");
		test_bench.pstrb = 4'b0011;
		test_bench.write(ADDR_TCR, 32'hAA55_AA55);
		test_bench.read(ADDR_TCR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0502);

		$display(" 1100 ");
		test_bench.pstrb = 4'b1100;
		test_bench.write(ADDR_TCR, 32'h55AA_55AA);
		test_bench.read(ADDR_TCR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0502);

		$display(" 0110 ");
		test_bench.pstrb = 4'b0110;
		test_bench.write(ADDR_TCR, 32'hA55A_A55A);
		test_bench.read(ADDR_TCR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0502);

		$display(" 1001 ");
		test_bench.pstrb = 4'b1001;
		test_bench.write(ADDR_TCR, 32'h5AA5_5AA5);
		test_bench.read(ADDR_TCR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0501);

		test_bench.pstrb = 4'b0000;
		test_bench.write(ADDR_TCR, 32'h5AA5_FFFF);

		$display("----------*** CMP0 ***-----------");
		$display(" 1111 ");
		test_bench.pstrb = 4'b1111;
		test_bench.write(ADDR_TCMP0, 32'hFFFF_FFFF);
		test_bench.read(ADDR_TCMP0, task_rdata);
		test_bench.cmp(task_rdata, 32'hFFFF_FFFF);

		$display(" 0001 ");
		test_bench.pstrb = 4'b0001;
		test_bench.write(ADDR_TCMP0, 32'hAAAA_AAAA);
		test_bench.read(ADDR_TCMP0, task_rdata);
		test_bench.cmp(task_rdata, 32'hFFFF_FFAA);

		$display(" 0010 ");
		test_bench.pstrb = 4'b0010;
		test_bench.write(ADDR_TCMP0, 32'h5555_5555);
		test_bench.read(ADDR_TCMP0, task_rdata);
		test_bench.cmp(task_rdata, 32'hFFFF_55AA);

		$display(" 0100 ");
		test_bench.pstrb = 4'b0100;
		test_bench.write(ADDR_TCMP0, 32'hA5A5_A5A5);
		test_bench.read(ADDR_TCMP0, task_rdata);
		test_bench.cmp(task_rdata, 32'hFFA5_55AA);

		$display(" 1000 ");
		test_bench.pstrb = 4'b1000;
		test_bench.write(ADDR_TCMP0, 32'h5A5A_5A5A);
		test_bench.read(ADDR_TCMP0, task_rdata);
		test_bench.cmp(task_rdata, 32'h5AA5_55AA);

		$display(" 0011 ");
		test_bench.pstrb = 4'b0011;
		test_bench.write(ADDR_TCMP0, 32'hAA55_AA55);
		test_bench.read(ADDR_TCMP0, task_rdata);
		test_bench.cmp(task_rdata, 32'h5AA5_AA55);

		$display(" 1100 ");
		test_bench.pstrb = 4'b1100;
		test_bench.write(ADDR_TCMP0, 32'h55AA_55AA);
		test_bench.read(ADDR_TCMP0, task_rdata);
		test_bench.cmp(task_rdata, 32'h55AA_AA55);

		$display(" 0110 ");
		test_bench.pstrb = 4'b0110;
		test_bench.write(ADDR_TCMP0, 32'hA55A_A55A);
		test_bench.read(ADDR_TCMP0, task_rdata);
		test_bench.cmp(task_rdata, 32'h555A_A555);

		$display(" 1001 ");
		test_bench.pstrb = 4'b1001;
		test_bench.write(ADDR_TCMP0, 32'h5AA5_5AA5);
		test_bench.read(ADDR_TCMP0, task_rdata);
		test_bench.cmp(task_rdata, 32'h5A5A_A5A5);

		 $display("----------*** CMP1 ***-----------");
		$display(" 1111 ");
		test_bench.pstrb = 4'b1111;
		test_bench.write(ADDR_TCMP1, 32'hFFFF_FFFF);
		test_bench.read(ADDR_TCMP1, task_rdata);
		test_bench.cmp(task_rdata, 32'hFFFF_FFFF);

		$display(" 0001 ");
		test_bench.pstrb = 4'b0001;
		test_bench.write(ADDR_TCMP1, 32'hAAAA_AAAA);
		test_bench.read(ADDR_TCMP1, task_rdata);
		test_bench.cmp(task_rdata, 32'hFFFF_FFAA);

		$display(" 0010 ");
		test_bench.pstrb = 4'b0010;
		test_bench.write(ADDR_TCMP1, 32'h5555_5555);
		test_bench.read(ADDR_TCMP1, task_rdata);
		test_bench.cmp(task_rdata, 32'hFFFF_55AA);

		$display(" 0100 ");
		test_bench.pstrb = 4'b0100;
		test_bench.write(ADDR_TCMP1, 32'hA5A5_A5A5);
		test_bench.read(ADDR_TCMP1, task_rdata);
		test_bench.cmp(task_rdata, 32'hFFA5_55AA);

		$display(" 1000 ");
		test_bench.pstrb = 4'b1000;
		test_bench.write(ADDR_TCMP1, 32'h5A5A_5A5A);
		test_bench.read(ADDR_TCMP1, task_rdata);
		test_bench.cmp(task_rdata, 32'h5AA5_55AA);

		$display(" 0011 ");
		test_bench.pstrb = 4'b0011;
		test_bench.write(ADDR_TCMP1, 32'hAA55_AA55);
		test_bench.read(ADDR_TCMP1, task_rdata);
		test_bench.cmp(task_rdata, 32'h5AA5_AA55);

		$display(" 1100 ");
		test_bench.pstrb = 4'b1100;
		test_bench.write(ADDR_TCMP1, 32'h55AA_55AA);
		test_bench.read(ADDR_TCMP1, task_rdata);
		test_bench.cmp(task_rdata, 32'h55AA_AA55);

		$display(" 0110 ");
		test_bench.pstrb = 4'b0110;
		test_bench.write(ADDR_TCMP1, 32'hA55A_A55A);
		test_bench.read(ADDR_TCMP1, task_rdata);
		test_bench.cmp(task_rdata, 32'h555A_A555);

		$display(" 1001 ");
		test_bench.pstrb = 4'b1001;
		test_bench.write(ADDR_TCMP1, 32'h5AA5_5AA5);
		test_bench.read(ADDR_TCMP1, task_rdata);
		test_bench.cmp(task_rdata, 32'h5A5A_A5A5);

		 $display("----------*** TIER ***-----------");
		$display(" 1111 ");
		test_bench.pstrb = 4'b1111;
		test_bench.write(ADDR_TIER, 32'hFFFF_FFFF);
		test_bench.read(ADDR_TIER, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0001);

		$display(" 0001 ");
		test_bench.pstrb = 4'b0001;
		test_bench.write(ADDR_TIER, 32'hAAAA_AAAA);
		test_bench.read(ADDR_TIER, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0000);

		$display(" 0010 ");
		test_bench.pstrb = 4'b0010;
		test_bench.write(ADDR_TIER, 32'h5555_5555);
		test_bench.read(ADDR_TIER, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0000);

		$display(" 0100 ");
		test_bench.pstrb = 4'b0100;
		test_bench.write(ADDR_TIER, 32'hA5A5_A5A5);
		test_bench.read(ADDR_TIER, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0000);

		$display(" 1000 ");
		test_bench.pstrb = 4'b1000;
		test_bench.write(ADDR_TIER, 32'h5A5A_5A5A);
		test_bench.read(ADDR_TIER, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0000);

		$display(" 0011 ");
		test_bench.pstrb = 4'b0011;
		test_bench.write(ADDR_TIER, 32'hAA55_AA55);
		test_bench.read(ADDR_TIER, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0001);

		$display(" 1100 ");
		test_bench.pstrb = 4'b1100;
		test_bench.write(ADDR_TIER, 32'h55AA_55AA);
		test_bench.read(ADDR_TIER, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0001);

		$display(" 0110 ");
		test_bench.pstrb = 4'b0110;
		test_bench.write(ADDR_TIER, 32'hA55A_A55A);
		test_bench.read(ADDR_TIER, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0001);

		$display(" 1001 ");
		test_bench.pstrb = 4'b1001;
		test_bench.write(ADDR_TIER, 32'h5AA5_5AA5);
		test_bench.read(ADDR_TIER, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0001);

		$display("----------*** TISR ***-----------");
		$display(" 1111 ");
		test_bench.pstrb = 4'b1111;
		test_bench.write(ADDR_TISR, 32'hFFFF_FFFF);
		test_bench.read(ADDR_TISR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0000);

		$display(" 0001 ");
		test_bench.pstrb = 4'b0001;
		test_bench.write(ADDR_TISR, 32'hAAAA_AAAA);
		test_bench.read(ADDR_TISR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0000);

		$display(" 0010 ");
		test_bench.pstrb = 4'b0010;
		test_bench.write(ADDR_TISR, 32'h5555_5555);
		test_bench.read(ADDR_TISR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0000);

		$display(" 0100 ");
		test_bench.pstrb = 4'b0100;
		test_bench.write(ADDR_TISR, 32'hA5A5_A5A5);
		test_bench.read(ADDR_TISR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0000);

		$display(" 1000 ");
		test_bench.pstrb = 4'b1000;
		test_bench.write(ADDR_TISR, 32'h5A5A_5A5A);
		test_bench.read(ADDR_TISR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0000);

		$display(" 0011 ");
		test_bench.pstrb = 4'b0011;
		test_bench.write(ADDR_TISR, 32'hAA55_AA55);
		test_bench.read(ADDR_TISR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0000);

		$display(" 1100 ");
		test_bench.pstrb = 4'b1100;
		test_bench.write(ADDR_TISR, 32'h55AA_55AA);
		test_bench.read(ADDR_TISR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0000);

		$display(" 0110 ");
		test_bench.pstrb = 4'b0110;
		test_bench.write(ADDR_TISR, 32'hA55A_A55A);
		test_bench.read(ADDR_TISR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0000);

		$display(" 1001 ");
		test_bench.pstrb = 4'b1001;
		test_bench.write(ADDR_TISR, 32'h5AA5_5AA5);
		test_bench.read(ADDR_TISR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0000);

		$display("----------*** THCSR ***-----------");
		$display(" 1111 ");
		test_bench.pstrb = 4'b1111;
		test_bench.write(ADDR_THCSR, 32'hFFFF_FFFF);
		test_bench.read(ADDR_THCSR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0001);

		$display(" 0001 ");
		test_bench.pstrb = 4'b0001;
		test_bench.write(ADDR_THCSR, 32'hAAAA_AAAA);
		test_bench.read(ADDR_THCSR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0000);

		$display(" 0010 ");
		test_bench.pstrb = 4'b0010;
		test_bench.write(ADDR_THCSR, 32'h5555_5555);
		test_bench.read(ADDR_THCSR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0000);

		$display(" 0100 ");
		test_bench.pstrb = 4'b0100;
		test_bench.write(ADDR_THCSR, 32'hA5A5_A5A5);
		test_bench.read(ADDR_THCSR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0000);

		$display(" 1000 ");
		test_bench.pstrb = 4'b1000;
		test_bench.write(ADDR_THCSR, 32'h5A5A_5A5A);
		test_bench.read(ADDR_THCSR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0000);

		$display(" 0011 ");
		test_bench.pstrb = 4'b0011;
		test_bench.write(ADDR_THCSR, 32'hAA55_AA55);
		test_bench.read(ADDR_THCSR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0001);

		$display(" 1100 ");
		test_bench.pstrb = 4'b1100;
		test_bench.write(ADDR_THCSR, 32'h55AA_55AA);
		test_bench.read(ADDR_THCSR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0001);

		$display(" 0110 ");
		test_bench.pstrb = 4'b0110;
		test_bench.write(ADDR_THCSR, 32'hA55A_A55A);
		test_bench.read(ADDR_THCSR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0001);

		$display(" 1001 ");
		test_bench.pstrb = 4'b1001;
		test_bench.write(ADDR_THCSR, 32'h5AA5_5AA5);
		test_bench.read(ADDR_THCSR, task_rdata);
		test_bench.cmp(task_rdata, 32'h0000_0001);

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
