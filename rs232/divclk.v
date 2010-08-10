// inclk: External Clock
// outclk: Output Clock
// ratio: Desired Frequency
module divclk(inclk,outclk,ratio);
	input inclk;
	input [31:0] ratio;
	output outclk;
	
	parameter RatioWidth = 16;
	parameter ClkFrq = 25000000;
	
	reg [RatioWidth:0] RatioAcc;

	wire [RatioWidth:0] RatioInc=((ratio<<(RatioWidth-4)) + (ClkFrq>>5)) / (ClkFrq>>4);
	
	wire outclk = RatioAcc[RatioWidth];
	
	always @(posedge inclk) begin
		RatioAcc <= RatioAcc[RatioWidth-1:0] + RatioInc;					// Generated a posedge,lasts a clk period
	end
endmodule
