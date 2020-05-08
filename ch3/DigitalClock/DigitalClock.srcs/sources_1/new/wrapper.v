// ABCDEFG
`define one 7'b1001111
`define two 7'b0010010
`define three 7'b0000110
`define four 7'b1001100
`define five 7'b0100100
`define six 7'b0100000
`define seven 7'b0001111
`define eight 7'b0000000
`define nine 7'b0000100
`define zero 7'b0000001

// refresh freq
`define RefreshFreq 1000

module wrapper(
	input CLK100MHZ,
	input reset,
	output led,

	output reg [6:0] C,
	output reg [5:0] AN,
	output [1:0] DIS
);
	// create a 1hz clk
	reg clk;
	reg [31:0] counter;
	assign led = clk;

	always @(posedge CLK100MHZ or posedge reset) begin
		if (reset) begin
			// reset
			counter <= 0;
			clk <= 0;
		end
		else begin
			counter <= counter + 1;
			if (counter == 50000000) begin
				counter <= 0;
				clk <= ~clk;
			end
		end
	end

	// get hour:minute:second data
	wire [4:0] hour;
	wire [5:0] minute;
	wire [5:0] second;
	timer innerclk(.clock(clk), .reset(reset), .hour(hour), .minute(minute), .second(second));

	// create refresh clk
	reg refresh;
	reg [31:0] refreshCounter;
	always @(posedge CLK100MHZ or posedge reset) begin
		if (reset) begin
			// reset
			refreshCounter <= 0;
			refresh <= 0;
		end
		else begin
			refreshCounter <= refreshCounter + 1;
			if (refreshCounter == `RefreshFreq) begin
				refreshCounter <= 0;
				refresh <= ~refresh;
			end
		end
	end
	
	// convert binary number to 7-seg control signal
	reg [6:0] hour_1;
	reg [6:0] hour_0;
	reg [6:0] minute_1;
	reg [6:0] minute_0;
	reg [6:0] second_1;
	reg [6:0] second_0;

	always @(*) begin
		// set hour
		case (hour)
			0: begin
				hour_1 = `zero;
				hour_0 = `zero;
			end
			1: begin
				hour_1 = `zero;
				hour_0 = `one;
			end
			2: begin
				hour_1 = `zero;
				hour_0 = `two;
			end
			3: begin
				hour_1 = `zero;
				hour_0 = `three;
			end
			4: begin
				hour_1 = `zero;
				hour_0 = `four;
			end
			5: begin
				hour_1 = `zero;
				hour_0 = `five;
			end
			6: begin
				hour_1 = `zero;
				hour_0 = `six;
			end
			7: begin
				hour_1 = `zero;
				hour_0 = `seven;
			end
			8: begin
				hour_1 = `zero;
				hour_0 = `eight;
			end
			9: begin
				hour_1 = `zero;
				hour_0 = `nine;
			end
			10: begin
				hour_1 = `one;
				hour_0 = `zero;
			end
			11: begin
				hour_1 = `one;
				hour_0 = `one;
			end
			12: begin
				hour_1 = `one;
				hour_0 = `two;
			end
			default: begin
				hour_1 = `zero;
				hour_0 = `zero;
			end
		endcase
		// set minute
		case (minute)
			0: begin
				minute_1 = `zero;
				minute_0 = `zero;
			end
			1: begin
				minute_1 = `zero;
				minute_0 = `one;
			end
			2: begin
				minute_1 = `zero;
				minute_0 = `two;
			end
			3: begin
				minute_1 = `zero;
				minute_0 = `three;
			end
			4: begin
				minute_1 = `zero;
				minute_0 = `four;
			end
			5: begin
				minute_1 = `zero;
				minute_0 = `five;
			end
			6: begin
				minute_1 = `zero;
				minute_0 = `six;
			end
			7: begin
				minute_1 = `zero;
				minute_0 = `seven;
			end
			8: begin
				minute_1 = `zero;
				minute_0 = `eight;
			end
			9: begin
				minute_1 = `zero;
				minute_0 = `nine;
			end
			10: begin
				minute_1 = `one;
				minute_0 = `zero;
			end
			11: begin
				minute_1 = `one;
				minute_0 = `one;
			end
			12: begin
				minute_1 = `one;
				minute_0 = `two;
			end
			13: begin
				minute_1 = `one;
				minute_0 = `three;
			end
			14: begin
				minute_1 = `one;
				minute_0 = `four;
			end
			15: begin
				minute_1 = `one;
				minute_0 = `five;
			end
			16: begin
				minute_1 = `one;
				minute_0 = `six;
			end
			17: begin
				minute_1 = `one;
				minute_0 = `seven;
			end
			18: begin
				minute_1 = `one;
				minute_0 = `eight;
			end
			19: begin
				minute_1 = `one;
				minute_0 = `nine;
			end
			20: begin
				minute_1 = `two;
				minute_0 = `zero;
			end
			21: begin
				minute_1 = `two;
				minute_0 = `one;
			end
			22: begin
				minute_1 = `two;
				minute_0 = `two;
			end
			23: begin
				minute_1 = `two;
				minute_0 = `three;
			end
			24: begin
				minute_1 = `two;
				minute_0 = `four;
			end
			25: begin
				minute_1 = `two;
				minute_0 = `five;
			end
			26: begin
				minute_1 = `two;
				minute_0 = `six;
			end
			27: begin
				minute_1 = `two;
				minute_0 = `seven;
			end
			28: begin
				minute_1 = `two;
				minute_0 = `eight;
			end
			29: begin
				minute_1 = `two;
				minute_0 = `nine;
			end
			30: begin
				minute_1 = `three;
				minute_0 = `zero;
			end
			31: begin
				minute_1 = `three;
				minute_0 = `one;
			end
			32: begin
				minute_1 = `three;
				minute_0 = `two;
			end
			33: begin
				minute_1 = `three;
				minute_0 = `three;
			end
			34: begin
				minute_1 = `three;
				minute_0 = `four;
			end
			35: begin
				minute_1 = `three;
				minute_0 = `five;
			end
			36: begin
				minute_1 = `three;
				minute_0 = `six;
			end
			37: begin
				minute_1 = `three;
				minute_0 = `seven;
			end
			38: begin
				minute_1 = `three;
				minute_0 = `eight;
			end
			39: begin
				minute_1 = `three;
				minute_0 = `nine;
			end
			40: begin
				minute_1 = `four;
				minute_0 = `zero;
			end
			41: begin
				minute_1 = `four;
				minute_0 = `one;
			end
			42: begin
				minute_1 = `four;
				minute_0 = `two;
			end
			43: begin
				minute_1 = `four;
				minute_0 = `three;
			end
			44: begin
				minute_1 = `four;
				minute_0 = `four;
			end
			45: begin
				minute_1 = `four;
				minute_0 = `five;
			end
			46: begin
				minute_1 = `four;
				minute_0 = `six;
			end
			47: begin
				minute_1 = `four;
				minute_0 = `seven;
			end
			48: begin
				minute_1 = `four;
				minute_0 = `eight;
			end
			49: begin
				minute_1 = `four;
				minute_0 = `nine;
			end
			50: begin
				minute_1 = `five;
				minute_0 = `zero;
			end
			51: begin
				minute_1 = `five;
				minute_0 = `one;
			end
			52: begin
				minute_1 = `five;
				minute_0 = `two;
			end
			53: begin
				minute_1 = `five;
				minute_0 = `three;
			end
			54: begin
				minute_1 = `five;
				minute_0 = `four;
			end
			55: begin
				minute_1 = `five;
				minute_0 = `five;
			end
			56: begin
				minute_1 = `five;
				minute_0 = `six;
			end
			57: begin
				minute_1 = `five;
				minute_0 = `seven;
			end
			58: begin
				minute_1 = `five;
				minute_0 = `eight;
			end
			59: begin
				minute_1 = `five;
				minute_0 = `nine;
			end
			default: begin
				minute_1 = `zero;
				minute_0 = `zero;
			end
		endcase
		// set second
		case (second)
			0: begin
				second_1 = `zero;
				second_0 = `zero;
			end
			1: begin
				second_1 = `zero;
				second_0 = `one;
			end
			2: begin
				second_1 = `zero;
				second_0 = `two;
			end
			3: begin
				second_1 = `zero;
				second_0 = `three;
			end
			4: begin
				second_1 = `zero;
				second_0 = `four;
			end
			5: begin
				second_1 = `zero;
				second_0 = `five;
			end
			6: begin
				second_1 = `zero;
				second_0 = `six;
			end
			7: begin
				second_1 = `zero;
				second_0 = `seven;
			end
			8: begin
				second_1 = `zero;
				second_0 = `eight;
			end
			9: begin
				second_1 = `zero;
				second_0 = `nine;
			end
			10: begin
				second_1 = `one;
				second_0 = `zero;
			end
			11: begin
				second_1 = `one;
				second_0 = `one;
			end
			12: begin
				second_1 = `one;
				second_0 = `two;
			end
			13: begin
				second_1 = `one;
				second_0 = `three;
			end
			14: begin
				second_1 = `one;
				second_0 = `four;
			end
			15: begin
				second_1 = `one;
				second_0 = `five;
			end
			16: begin
				second_1 = `one;
				second_0 = `six;
			end
			17: begin
				second_1 = `one;
				second_0 = `seven;
			end
			18: begin
				second_1 = `one;
				second_0 = `eight;
			end
			19: begin
				second_1 = `one;
				second_0 = `nine;
			end
			20: begin
				second_1 = `two;
				second_0 = `zero;
			end
			21: begin
				second_1 = `two;
				second_0 = `one;
			end
			22: begin
				second_1 = `two;
				second_0 = `two;
			end
			23: begin
				second_1 = `two;
				second_0 = `three;
			end
			24: begin
				second_1 = `two;
				second_0 = `four;
			end
			25: begin
				second_1 = `two;
				second_0 = `five;
			end
			26: begin
				second_1 = `two;
				second_0 = `six;
			end
			27: begin
				second_1 = `two;
				second_0 = `seven;
			end
			28: begin
				second_1 = `two;
				second_0 = `eight;
			end
			29: begin
				second_1 = `two;
				second_0 = `nine;
			end
			30: begin
				second_1 = `three;
				second_0 = `zero;
			end
			31: begin
				second_1 = `three;
				second_0 = `one;
			end
			32: begin
				second_1 = `three;
				second_0 = `two;
			end
			33: begin
				second_1 = `three;
				second_0 = `three;
			end
			34: begin
				second_1 = `three;
				second_0 = `four;
			end
			35: begin
				second_1 = `three;
				second_0 = `five;
			end
			36: begin
				second_1 = `three;
				second_0 = `six;
			end
			37: begin
				second_1 = `three;
				second_0 = `seven;
			end
			38: begin
				second_1 = `three;
				second_0 = `eight;
			end
			39: begin
				second_1 = `three;
				second_0 = `nine;
			end
			40: begin
				second_1 = `four;
				second_0 = `zero;
			end
			41: begin
				second_1 = `four;
				second_0 = `one;
			end
			42: begin
				second_1 = `four;
				second_0 = `two;
			end
			43: begin
				second_1 = `four;
				second_0 = `three;
			end
			44: begin
				second_1 = `four;
				second_0 = `four;
			end
			45: begin
				second_1 = `four;
				second_0 = `five;
			end
			46: begin
				second_1 = `four;
				second_0 = `six;
			end
			47: begin
				second_1 = `four;
				second_0 = `seven;
			end
			48: begin
				second_1 = `four;
				second_0 = `eight;
			end
			49: begin
				second_1 = `four;
				second_0 = `nine;
			end
			50: begin
				second_1 = `five;
				second_0 = `zero;
			end
			51: begin
				second_1 = `five;
				second_0 = `one;
			end
			52: begin
				second_1 = `five;
				second_0 = `two;
			end
			53: begin
				second_1 = `five;
				second_0 = `three;
			end
			54: begin
				second_1 = `five;
				second_0 = `four;
			end
			55: begin
				second_1 = `five;
				second_0 = `five;
			end
			56: begin
				second_1 = `five;
				second_0 = `six;
			end
			57: begin
				second_1 = `five;
				second_0 = `seven;
			end
			58: begin
				second_1 = `five;
				second_0 = `eight;
			end
			59: begin
				second_1 = `five;
				second_0 = `nine;
			end
			default: begin
				second_1 = `zero;
				second_0 = `zero;
			end
		endcase
	end


	always @(posedge refresh or posedge reset) begin
		if (reset) begin
			// reset
			AN <= 6'b111111;
		end
		else begin
			case (AN)
				6'b111110: begin
					C <= second_1;
					AN <= 6'b111101;
				end
				6'b111101: begin
					C <= minute_0;
					AN <= 6'b111011;
				end
				6'b111011: begin
					C <= minute_1;
					AN <= 6'b110111;
				end
				6'b110111: begin
					C <= hour_0;
					AN <= 6'b101111;
				end
				6'b101111: begin
					C <= hour_1;
					AN <= 6'b011111;
				end
				6'b011111: begin
					C <= second_0;
					AN <= 6'b111110;
				end
				default: begin
					AN <= 6'b111110;
				end
			endcase
		end
	end

	assign DIS = 2'b11; // close left 2 numbers
endmodule
