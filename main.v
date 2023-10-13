module main

(
	input clk,
	output o_led
);

wire [7:0] red_sig;
wire [7:0] green_sig;
wire [7:0] blue_sig;
wire we_sig;
wire rst_sig;

rgb_controller rgb_controller_inst
(
	.clk(clk) ,	// input  clk_sig
	.red(red_sig) ,	// output [7:0] red_sig
	.green(green_sig) ,	// output [7:0] green_sig
	.blue(blue_sig) ,	// output [7:0] blue_sig
	.o_we(we_sig) 	// output  o_we_sig
);

ws2812 ws2812_inst
(
	.clk(clk),
	.red(red_sig),
	.green(green_sig),
	.blue(blue_sig),
	.we(we_sig),
	.rst(rst_sig),
	.led(o_led)
);

defparam ws2812_inst.ticks_0h = 15;
defparam ws2812_inst.ticks_0l = 40;
defparam ws2812_inst.ticks_1h = 40;
defparam ws2812_inst.ticks_1l = 15;
defparam ws2812_inst.ticks_rst = 4000;

endmodule