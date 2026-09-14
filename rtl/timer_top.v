module timer_top (
	input  wire			sys_clk		,
	input  wire			sys_rst_n	,
	input  wire			tim_psel	,
	input  wire			tim_pwrite	,
	input  wire			tim_penable	,
	input  wire [11:0]	tim_paddr	,
	input  wire [31:0]	tim_pwdata	,
	output wire [31:0]	tim_prdata	,
	input  wire [3:0]	tim_pstrb	,
	output wire			tim_pready	,
	output wire			tim_pslverr	,
	output wire			tim_int		,
	input  wire			dbg_mode
);

wire		wr_en	;
wire		rd_en	;
wire		timer_en;
wire		div_en	;
wire		cnt_en	;
wire	[ 3:0]	div_val	;
wire	[63:0]	cnt	;
wire	[31:0]	wdata_o	;
wire [31:0] address;

assign address = {20'h4000_1, tim_paddr};

apb_slave u_apb_slave (
	.clk		(sys_clk	),
	.rst_n		(sys_rst_n	),
	.psel		(tim_psel	),
	.pwrite		(tim_pwrite	),
	.penable	(tim_penable),
	.pready		(tim_pready	),
	.wr_en		(wr_en		),
	.rd_en		(rd_en		)
);

register u_reg (
	.clk		(sys_clk	),
	.rst_n		(sys_rst_n	),
	.wr_en		(wr_en		),
	.rd_en		(rd_en		),
	.addr		(address	),
	.wdata		(tim_pwdata	),
	.rdata		(tim_prdata	),
	.pstrb		(tim_pstrb	),
	.pslverr	(tim_pslverr),
	.cnt		(cnt		),
	.div_en		(div_en		),
	.tdr0_wr_sel(tdr0_wr_sel),
	.tdr1_wr_sel(tdr1_wr_sel),
	.timer_en	(timer_en	),
	.div_val	(div_val	),
	.tim_int	(tim_int	),
	.debug_mode	(dbg_mode	),
	.halt_req	(halt_req	),
	.wdata_o	(wdata_o	),
	.timer_en_neg	(timer_en_neg	)
);

counter_control u_cnt_ctrl (
	.clk		(sys_clk	),
	.rst_n		(sys_rst_n	),
	.div_en		(div_en		),
	.div_val	(div_val	),
	.halt_req	(halt_req	),
	.timer_en	(timer_en	),
	.cnt_en		(cnt_en		),
	.debug_mode	(dbg_mode	)
);

counter u_cnt (
	.clk		(sys_clk	),
	.rst_n		(sys_rst_n	),
	.cnt_en		(cnt_en		),
	.tdr0_wr_sel(tdr0_wr_sel),
	.tdr1_wr_sel(tdr1_wr_sel),
	.wdata		(wdata_o	),
	.cnt		(cnt		),
	.timer_en_neg	(timer_en_neg	)
);

endmodule
