module test_bench;

	parameter ADDR_TCR	= 12'h000;
	parameter ADDR_TDR0	= 12'h004;
	parameter ADDR_TDR1	= 12'h008;
	parameter ADDR_TCMP0	= 12'h00C;
	parameter ADDR_TCMP1	= 12'h010;
	parameter ADDR_TIER	= 12'h014;
	parameter ADDR_TISR	= 12'h018;
	parameter ADDR_THCSR	= 12'h01C;

	reg	clk, rst_n;
	reg	psel, pwrite, penable, dbg_mode;
	reg	[11:0]	paddr;
	reg	[31:0]	pwdata;
	reg	[3:0]	pstrb;
	wire	[31:0]	prdata;
	wire		pready;
	wire		tin_int;
	wire		pslverr;
	integer		err;


	timer_top u_top
	(
		.sys_clk	(clk		),
		.sys_rst_n	(rst_n		),
		.tim_psel	(psel		),
		.tim_pwrite	(pwrite		),
		.tim_penable	(penable	),
		.tim_paddr	(paddr		),
		.tim_pwdata	(pwdata		),
		.tim_prdata	(prdata		),
		.tim_pstrb	(pstrb		),
		.tim_pready	(pready		),
		.tim_pslverr	(pslverr	),
		.tim_int	(tim_int	),
		.dbg_mode	(dbg_mode	)
	);

	`include "run_test.v"

	initial begin
		clk =1;
		forever #25 clk=~clk;
	end

	initial begin
		rst_n = 1'b0;
		#25 rst_n = 1'b1;
	end

	initial begin
		#100;
		run_test();
		#100;
		$finish;
	end

	reg [31:0] read_data;

	initial begin
		paddr = 0;
		pwdata =0;
		psel = 0;
		penable = 0;
		pwrite = 0;
		dbg_mode = 0;
		pstrb = 0;
		err = 0;
		//#100;

		pstrb = 4'b1111;

		#1000;
	end

	task write(input [31:0] address, input [31:0] w_data); begin
		$display("Write data 'h%h to address 'h%h", w_data, address);
		@(posedge clk);
		#1;
		pwrite	= 1;
		psel	= 1;
		paddr	= address;
		pwdata	= w_data;
		#1;
		@(posedge clk);
		penable = 1;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);

		pwrite	= 0;
		psel	= 0;
		penable = 0;
		$display("Write done !");

		end
	endtask

	task read(input [31:0] address, output [31:0] r_data); begin
		$display("Read data from address 'h%h", address);
		@(posedge clk);
		#1;
		paddr	= address;
		pwrite	= 0;
		psel	= 1;
		penable = 0;

		@(posedge clk);
		penable = 1;

		@(posedge clk);
		@(posedge clk);
		r_data = prdata;

		$display("Read data 'h%h from address 'h%h", r_data, address);
		@(posedge clk);
		pwrite	= 0;
		psel	= 0;
		penable = 0;
		$display("Read done");
	end
	endtask

	task cmp(input [31:0] r_data, input [31:0] exp_data); begin
		if(r_data == exp_data)
			$display("PASS");
		else begin
			$display("FAIL - expect: 'h%h - actual: 'h%h", exp_data, r_data);
			err = err + 1;
		end
		$display("====================");

	end
	endtask

endmodule
