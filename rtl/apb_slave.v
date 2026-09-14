module apb_slave(
	input	clk,
	input	rst_n,
	input	pwrite,
	input	psel,
	input	penable,
	output	wr_en,
	output	rd_en,
	output	reg pready
);

assign wr_en = psel &  pwrite & penable;
assign rd_en = psel & !pwrite & penable;

// pready
// after 1 cycle when receiving penable and psel (1;1) then pready = 1
reg pready_next;

always @(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		pready		<= 1'b0;
		pready_next <= 1'b0;
	end else begin
		pready		<= pready_next;
		pready_next <= (psel & penable);
	end
end

endmodule
