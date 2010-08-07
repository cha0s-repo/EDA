// inclk: External Clock
// outclk: Output Clock
// ratio: Divide Ratio
module divclk(inclk,outclk,ratio);
	input inclk;
	input [28:0] ratio;
	output outclk;
	
	reg outclk;
	reg [28:0] div;

// 61a8 > 1ms; 3d090 > 10ms; bebc20 > 1s
	
	always @(posedge inclk) begin
		if(div==ratio) begin
			div<=0;
			outclk<=~outclk;
		end else
			div<=div+1;
	end
endmodule
