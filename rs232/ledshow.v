// data: Data which to show
// sel: Which digit to show
// dbus: Data bus
// sbus: Digit bus

module LedShow(data,sel,dbus,sbus);
	input [7:0] data;
	input [3:0] sel;
	output [3:0] dbus,sbus;

	assign sbus=select(sel);
	assign dbus=switch(data);
	
	function [3:0] switch;				// ASCII code switching
		input [7:0] dt;
		case (dt)
			8'o60: switch=4'd0;
			8'o61: switch=4'd1;
			8'o62: switch=4'd2;
			8'o63: switch=4'd3;
			8'o64: switch=4'd4;
			8'o65: switch=4'd5;
			8'o66: switch=4'd6;
			8'o67: switch=4'd7;
			8'o70: switch=4'd8;
			8'o71: switch=4'd9;
			default: switch=4'd8;
		endcase
	endfunction	
	
	function [3:0] select;
		input [3:0] which;
		case (which)
			4'd0: select=4'b1110;
			4'd1: select=4'b1101;
			4'd2: select=4'b1011;
			4'd3: select=4'b0111;
			default: select=4'b1110;
		endcase
	endfunction
endmodule
