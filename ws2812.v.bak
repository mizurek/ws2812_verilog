module ws2812

#(
	// Parameter Declarations
	parameter ticks_0h = 15,
	parameter ticks_0l = 40,
	
	parameter ticks_1h = 40,
	parameter ticks_1l = 15,
	
	parameter ticks_rst = 4000
)

(
	input clk,
	input wire [7:0] red,
	input wire [7:0] green,
	input wire [7:0] blue,
	input we,
	input rst,
	output led
);

reg ser_running; //data is being transmitted
reg rst_running;

reg [7:0] r_red;
reg [7:0] r_green;
reg [7:0] r_blue;

reg [3:0] color_cnt;
reg [5:0] bit_cnt;
reg tick_state;
reg [9:0] tick_cnt;

reg [11:0] reset_cnt;

reg [1:0] we_sr; //we inputs values shift register
reg [1:0] rst_sr; //rst inputs values shift register

/* 
If 
color_cnt == 0 means current color is green
color_cnt == 1 means current color is red
color_cnt anything else means current color is blue
*/

//debug
wire color_g_bit = r_green[7 - bit_cnt];
wire color_r_bit = r_red[7 - bit_cnt];
wire color_b_bit = r_blue[7 - bit_cnt];
//end debug

wire color_bit = (color_cnt == 0) ? (r_green[7 - bit_cnt]) : ( (color_cnt == 1) ? (r_red[7 - bit_cnt]) : (r_blue[7 - bit_cnt]) );
wire [9:0] ticks_num = tick_state ? (color_bit ? ticks_1l : ticks_0l) : (color_bit ? ticks_1h : ticks_0h );
assign led = (rst_running || (~ser_running)) ? 0 : (~tick_state); //tick_cnt == 0 always outputs 1, tick_cnt == 1 always outputs 0, only duty changes

assign we_event = (we_sr == 1);
assign rst_event = (rst_sr == 1);

initial 
begin
	r_red <= 0;
	r_green <= 0;
	r_blue <= 0;
	ser_running <= 0;
	rst_running <= 0;
	reset_cnt <= 0;
	color_cnt <= 0;
	bit_cnt <= 0;
	tick_cnt <= 0;
	we_sr <= 0;
	rst_sr <= 0;
	tick_state <= 0;
end

always@(posedge clk)
begin
	we_sr <= (we_sr << 1) | we;
	rst_sr <= (rst_sr << 1) | rst;
end

always@(posedge clk)
begin

	if (rst_running)
	begin
		if (reset_cnt < ticks_rst)
		begin
			reset_cnt <= reset_cnt + 1;
		end
		else
		begin
			rst_running <= 0;
		end
	end
	else
	begin
		if (rst_event)
		begin
			rst_running <= 1;
		end
	end

	if (ser_running)
	begin
		if (tick_cnt < (ticks_num - 1))
		begin
			tick_cnt <= tick_cnt + 1;
		end
		else
		begin
			tick_cnt <= 0;
			if (tick_state < 1)
			begin
				tick_state <= ~tick_state;
			end
			else
			begin
				tick_state <= 0;
				if (bit_cnt < 7)
				begin
					bit_cnt <= bit_cnt + 1;
				end
				else
				begin
					bit_cnt <= 0;
					if (color_cnt < 2)
					begin
						color_cnt <= color_cnt + 1;
					end
					else
					begin
						ser_running <= 0;
					end
				end
			end
		end
	end
	else
	begin
		if (we_event)
		begin
			r_red <= red;
			r_green <= green;
			r_blue <= blue;
			color_cnt <= 0;
			bit_cnt <= 0;
			tick_cnt <= 0;
			ser_running <= 1;
		end
	end
end

endmodule
