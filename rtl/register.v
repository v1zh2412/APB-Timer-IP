module register(
	input			clk			,
	input			rst_n		,
	input			wr_en		,
	input			rd_en		,
	input	[31:0]	addr		,
	input	[31:0]	wdata		,
	output	[31:0]	rdata		,
	input	[3:0]	pstrb		,
	output			pslverr		,
	input	[63:0]	cnt			,
	output			div_en		,
	output			tdr0_wr_sel	,
	output			tdr1_wr_sel	,
	output			timer_en	,
	output	[3:0]	div_val		,
	output			tim_int		,
	input			debug_mode	,
	output			halt_req	,
	output	[31:0]	wdata_o		,
	output			timer_en_neg
);

parameter ADDR_TCR	= 12'h00;
parameter ADDR_TDR0	= 12'h04;
parameter ADDR_TDR1	= 12'h08;
parameter ADDR_TCMP0	= 12'h0C;
parameter ADDR_TCMP1	= 12'h10;
parameter ADDR_TIER	= 12'h14;
parameter ADDR_TISR	= 12'h18;
parameter ADDR_THCSR	= 12'h1C;

parameter TCR_DEFAULT	= 32'h0000_0100;
parameter TDR0_DEFAULT	= 32'h0;
parameter TDR1_DEFAULT	= 32'h0;
parameter TCMP0_DEFAULT	= 32'hFFFF_FFFF;
parameter TCMP1_DEFAULT	= 32'hFFFF_FFFF;
parameter TIER_DEFAULT	= 32'h0;
parameter TISR_DEFAULT	= 32'h0;
parameter THCSR_DEFAULT	= 32'h0;

reg	[7:0]	reg_sel;
wire	[11:0]	addr_tmp;

assign addr_tmp = addr[11:0];

always @(*) begin
	case (addr_tmp)
		ADDR_TCR	: reg_sel = 8'b00000001;
		ADDR_TDR0	: reg_sel = 8'b00000010;
		ADDR_TDR1	: reg_sel = 8'b00000100;
		ADDR_TCMP0	: reg_sel = 8'b00001000;
		ADDR_TCMP1	: reg_sel = 8'b00010000;
		ADDR_TIER	: reg_sel = 8'b00100000;
		ADDR_TISR	: reg_sel = 8'b01000000;
		ADDR_THCSR	: reg_sel = 8'b10000000;
		default		: reg_sel = 8'b00000000;
	endcase
end

// TDR0
wire [31:0] low_cnt;
wire [31:0] high_cnt;

assign low_cnt  = cnt[31:0];
assign high_cnt = cnt[63:32];

reg timer_en_1d;
always @(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		timer_en_1d <= 1'b0;
	end else begin
		timer_en_1d <= timer_en;
	end
end

assign timer_en_neg = ~timer_en & timer_en_1d;

// reg_sel[1]
wire [31:0] tdr0_tmp;
wire [31:0] tdr0_nxt;
reg  [31:0] tdr0_r;

assign tdr0_tmp[7:0]	= (wr_en && reg_sel[1]) & pstrb[0] ? wdata[7:0]   : low_cnt[7:0];
assign tdr0_tmp[15:8]	= (wr_en && reg_sel[1]) & pstrb[1] ? wdata[15:8]  : low_cnt[15:8];
assign tdr0_tmp[23:16]	= (wr_en && reg_sel[1]) & pstrb[2] ? wdata[23:16] : low_cnt[23:16];
assign tdr0_tmp[31:24]	= (wr_en && reg_sel[1]) & pstrb[3] ? wdata[31:24] : low_cnt[31:24];

assign tdr0_nxt = ~timer_en_neg ? tdr0_tmp : TDR0_DEFAULT;

always @(*) begin
	if (!rst_n) begin
		tdr0_r <= TDR0_DEFAULT;
	end
	else begin
		tdr0_r <= tdr0_nxt;
	end
end

// TDR1
// reg_sel[2]
wire [31:0] tdr1_tmp;
wire [31:0] tdr1_nxt;
reg  [31:0] tdr1_r;

assign tdr1_tmp[7:0]	= (wr_en && reg_sel[2]) & pstrb[0] ? wdata[7:0]   : high_cnt[7:0];
assign tdr1_tmp[15:8]	= (wr_en && reg_sel[2]) & pstrb[1] ? wdata[15:8]  : high_cnt[15:8];
assign tdr1_tmp[23:16]	= (wr_en && reg_sel[2]) & pstrb[2] ? wdata[23:16] : high_cnt[23:16];
assign tdr1_tmp[31:24]	= (wr_en && reg_sel[2]) & pstrb[3] ? wdata[31:24] : high_cnt[31:24];

assign tdr1_nxt = ~timer_en_neg ? tdr1_tmp : TDR1_DEFAULT;

always @(*) begin
	if (!rst_n) begin
		tdr1_r <= TDR1_DEFAULT;
	end
	else begin
		tdr1_r <= tdr1_nxt;
	end
end

assign tdr0_wr_sel = (wr_en && reg_sel[1]);
assign tdr1_wr_sel = (wr_en && reg_sel[2]);

assign wdata_o = tdr0_wr_sel ? tdr0_r :
		 tdr1_wr_sel ? tdr1_r :
			       32'h0  ;

// TCR
// reg_sel[0]
// timer_en	bit 0
reg [31:0] tcr;
wire timer_en_tmp;

assign timer_en = tcr[0];
assign timer_en_tmp = (wr_en & reg_sel[0]) & pstrb[0] & ~pslverr ? wdata[0] : timer_en;

always @(*) begin
	if(!rst_n) begin
		tcr[0] <= 1'b0;
	end
	else begin
		tcr[0] <= timer_en_tmp;
	end
end

// div_en	bit 1
wire div_en_tmp;
wire err_div_en;

assign div_en = tcr[1];
assign err_div_en = (wr_en & reg_sel[0]) & (wdata[1] != div_en) & pstrb[0] & timer_en;
assign div_en_tmp = (wr_en & reg_sel[0]) & pstrb[0] & ~pslverr ? wdata[1] : div_en;

always @(*) begin
	if(!rst_n) begin
		tcr[1] <= 1'b0;
	end
	else begin
		tcr[1] <= div_en_tmp;
	end
end

// div_val	bit 11:8
wire [3:0] div_val_tmp;
wire err_div_val_1;
wire err_div_val_2;

assign div_val = tcr[11:8];
assign div_val_wr_en = (wdata[11:8] <= 4'h8);
assign div_val_wr_sel = div_val_wr_en & (wr_en & reg_sel[0]) & pstrb[1];
assign div_val_tmp = div_val_wr_sel & ~pslverr ? wdata[11:8] : div_val;

assign err_div_val_1 = (wr_en & reg_sel[0]) & (wdata[11:8] > 8) & pstrb[1];
assign err_div_val_2 = (wr_en & reg_sel[0]) & (wdata[11:8] != div_val) & pstrb[1] & timer_en;

always @(*) begin
	if(!rst_n) begin
		tcr[11:8] <= 1'b1;
	end
	else begin
		tcr[11:8] <= div_val_tmp;
	end
end

// TCR
wire [31:0] tcr_tmp;

assign tcr_tmp = {20'h0, div_val_tmp, 6'h0, div_en_tmp, timer_en_tmp};

always @(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		tcr <= TCR_DEFAULT;
	end
	else begin
		tcr <= tcr_tmp;
	end
end

// TCMP0
// sel_reg[3]
reg [31:0] tcmp0;
wire [31:0] tcmp0_tmp;

assign tcmp0_tmp[7:0]	= (wr_en && reg_sel[3]) & pstrb[0] ? wdata[7:0]   : tcmp0[7:0];
assign tcmp0_tmp[15:8]	= (wr_en && reg_sel[3]) & pstrb[1] ? wdata[15:8]  : tcmp0[15:8];
assign tcmp0_tmp[23:16]	= (wr_en && reg_sel[3]) & pstrb[2] ? wdata[23:16] : tcmp0[23:16];
assign tcmp0_tmp[31:24]	= (wr_en && reg_sel[3]) & pstrb[3] ? wdata[31:24] : tcmp0[31:24];

always @(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		tcmp0 <= TCMP0_DEFAULT;
	end
	else begin
		tcmp0 <= tcmp0_tmp;
	end
end

// TCMP1
// sel_reg[4]
reg [31:0] tcmp1;
wire [31:0] tcmp1_tmp;

assign tcmp1_tmp[7:0]	= (wr_en && reg_sel[4]) & pstrb[0] ? wdata[7:0]   : tcmp1[7:0];
assign tcmp1_tmp[15:8]	= (wr_en && reg_sel[4]) & pstrb[1] ? wdata[15:8]  : tcmp1[15:8];
assign tcmp1_tmp[23:16]	= (wr_en && reg_sel[4]) & pstrb[2] ? wdata[23:16] : tcmp1[23:16];
assign tcmp1_tmp[31:24]	= (wr_en && reg_sel[4]) & pstrb[3] ? wdata[31:24] : tcmp1[31:24];

always @(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		tcmp1 <= TCMP0_DEFAULT;
	end
	else begin
		tcmp1 <= tcmp1_tmp;
	end
end

// {tcmp1, tcmp0} == counter_value => interrupt = 1
wire [63:0] tcmp;
wire tcmp_int;

assign tcmp = {tcmp1, tcmp0};
assign tcmp_int = (tcmp == cnt);

// TIER
wire int_en;
reg [31:0] tier;

assign int_en = tier[0];
assign int_en_tmp = (wr_en & reg_sel[5]) & pstrb[0] ? wdata[0] : int_en;
assign tier_tmp = {31'h0, int_en_tmp};

always @(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		tier <= TIER_DEFAULT;
	end
	else begin
		tier <= tier_tmp;
	end
end

// TISR
// reg_sel[6]
reg [31:0] tisr;
wire int_clear;

assign int_st = tisr[0];
assign int_clear = ((wr_en & reg_sel[6]) & pstrb[0]) & (wdata[0] == 1'b1);
assign int_set = tcmp_int;
assign int_st_tmp = int_clear ? 1'b0 :
		    int_set   ? 1'b1 : int_st;
assign tisr_tmp = {31'h0, int_st_tmp};

always @(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		tisr <= TISR_DEFAULT;
	end
	else begin
		tisr <= tisr_tmp;
	end
end

assign tim_int = int_en_tmp & int_st_tmp;

// THCSR
// reg_sel[7]
reg [31:0] thcsr;
wire [31:0] thcsr_tmp;

assign halt_req = thcsr[0];
assign halt_req_tmp = ((wr_en & reg_sel[7]) & pstrb[0]) ? wdata[0] : halt_req;
assign halt_ack = thcsr[1];
assign halt_ack_tmp = halt_req_tmp & debug_mode;
assign thcsr_tmp = {30'h0, halt_ack_tmp, halt_req_tmp};

always @(*) begin
	if (!rst_n) begin
		thcsr <= THCSR_DEFAULT;
	end
	else begin
		thcsr <= thcsr_tmp;
	end
end

assign pslverr = err_div_en | err_div_val_1 | err_div_val_2;

// READ access
reg [31:0] rdata_r;

always @(*) begin
	if (rd_en) begin
		case (addr_tmp)
			ADDR_TCR	: rdata_r = tcr		;
			ADDR_TDR0	: rdata_r = tdr0_r	;
			ADDR_TDR1	: rdata_r = tdr1_r	;
			ADDR_TCMP0	: rdata_r = tcmp0	;
			ADDR_TCMP1	: rdata_r = tcmp1	;
			ADDR_TIER	: rdata_r = tier	;
			ADDR_TISR	: rdata_r = tisr	;
			ADDR_THCSR	: rdata_r = thcsr	;
			default		: rdata_r = 32'h0	;
		endcase
	end
	else begin
		rdata_r = 32'h0;
	end
end

assign rdata = rdata_r;

endmodule
