# ws2812_verilog
Verilog support of WS2812 LEDs

# Usage
Build under Quartus (I am using Quartus 18.0.0)<br>
CLK is 50 MHz. If changed, the number of parameter cycles may change to create nice timings.
I am using EP4CE6E22C8 device on a Chinese C402 board.<br/>
RGB order seems to be somehow changed - datasheet says GRB but LEDs colors changes properly with RGB order, GRB order had R and G swapped.

# License
Do what you want, write me or acknowledge if you like it

# Author
Michal Zurek