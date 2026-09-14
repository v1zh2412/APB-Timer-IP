module counter_control (
	input			clk			,
	input			rst_n		,
	input			div_en		,
	input	[3:0]		div_val	,
	input			halt_req	,
	input			timer_en	,
	output			cnt_en		,
	input			debug_mode
);

wire cnt_rst;
reg [7:0] int_cnt;
wire def_mode;
wire ctrl_mode0;
wire ctrl_mode_other;

// default mode
assign def_mode = (!div_en) & timer_en;
// control mode 0
assign ctrl_mode0 = div_en & timer_en & (div_val == 1'b0);

// control mode other
reg [7:0] limit = 4'b0001;
always @(*) begin
	case (div_val)
		4'b0000 : limit = 8'd0;
		4'b0001 : limit = 8'd1;
		4'b0010 : limit = 8'd3;
		4'b0011 : limit = 8'd7;
		4'b0100 : limit = 8'd15;
		4'b0101 : limit = 8'd31;
		4'b0110 : limit = 8'd63;
		4'b0111 : limit = 8'd127;
		4'b1000 : limit = 8'd255;
		default : limit = 0;
	endcase
end

wire [7:0] int_cnt_tmp;

assign cnt_rst = !div_en | !timer_en | (int_cnt == limit);
assign int_cnt_tmp = halt_req ? int_cnt :
		             cnt_rst  ? 8'h0    :
		             int_cnt + 1'b1 ;

always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		int_cnt <= 1'b0;
	end
	else begin
		int_cnt = int_cnt_tmp;
	end
end

assign ctrl_mode_other = (int_cnt == limit) & (div_val != 0)  & div_en & timer_en;
assign cnt_en = (def_mode | ctrl_mode0 | ctrl_mode_other) & !(halt_req & debug_mode);

endmodule
