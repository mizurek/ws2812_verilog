module rgb_controller

#(
	// Parameter Declarations
	parameter ticks_delay = 500000
)

(
	input clk,
	output wire [7:0] red,
	output wire [7:0] green,
	output wire [7:0] blue,
	output o_we
);

reg r_we;
reg [7:0] r_red;
reg [7:0] r_green;
reg [7:0] r_blue;
reg [31:0] ticks_cnt;

assign o_we = r_we;
assign red = r_red;
assign green = r_green;
assign blue = r_blue;

initial
begin
	r_we <= 0;
	r_red <= 0;
	r_green <= 0;
	r_blue <= 0;
	ticks_cnt <= 0;
end

always@(posedge clk)
begin
	if (ticks_cnt < ticks_delay)
	begin
		ticks_cnt <= ticks_cnt + 1;
	end
	else
	begin
		ticks_cnt <= 0;
		r_red <= r_red + 1;
		r_green <= r_green + 1;
		r_blue <= r_blue + 1;
		r_we <= ~r_we;
	end
end

endmodule