module counter(
	input			clk			,
	input			rst_n		,
	input			cnt_en		,
	input			tdr0_wr_sel	,
	input			tdr1_wr_sel	,
	input	[31:0]		wdata	,
	output	[63:0]		cnt		,
	input			timer_en_neg
);

parameter DEFAULT_CNT = 32'h0;

wire	[63:0]	cnt_plus_1;
reg	[31:0]	cnt0_nxt;
reg	[31:0]	cnt1_nxt;
wire	[31:0]	cnt0;
wire	[31:0]	cnt1;

// counter 31 - 0
assign cnt0 = tdr0_wr_sel ? wdata :
	          cnt_en	  ? cnt_plus_1[31:0]
			  : cnt[31:0];

always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		cnt0_nxt <= DEFAULT_CNT;
	end
	else begin
		cnt0_nxt <= cnt0;
	end
end

// counter 63 - 32
assign cnt1 = tdr1_wr_sel ? wdata :
	          cnt_en	  ? cnt_plus_1[63:32]
			  : cnt[63:32];

always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		cnt1_nxt <= DEFAULT_CNT;
	end
	else begin
		cnt1_nxt <= cnt1;
	end
end

assign cnt_plus_1 = cnt + 1;
assign cnt = timer_en_neg ? 64'h0 : {cnt1_nxt, cnt0_nxt};

endmodule
