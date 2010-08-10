// clk:External Clock
// rx: Receive Port
// tx: Transfer Port
// ledr: When rx got a data, ledr reversed once. This signal will be used as stage state
// dbus: LED show data bus
// sbus: LED show select bus

module rs232(clk,rst,rx,tx,ledr,dbus,sbus);
	input clk,rst;
	input rx;
	output ledr;
	output tx;
	output [3:0] dbus,sbus;

	wire Dclk;
	wire ledr;
	wire [7:0] data;

	reg [7:0] sum[0:3];
	reg [3:0] stat,loop;
	reg [7:0] temp;

	divclk dclk(clk,Dclk,1000);

	rs232_rx rever(clk,rst,rx,ledr,data);	
	rs232_tx transer(clk,rst,data,ledr,tx);

	LedShow shownum(temp,stat,dbus,sbus);	

	always @(posedge Dclk or negedge rst) begin
			if(!rst) begin
				stat<=4'd0;
			end
			else begin
				case (stat)
					4'd0: stat<=4'd1;
					4'd1: stat<=4'd2;
					4'd2: stat<=4'd3;
					4'd3: stat<=4'd0;
					default: stat<=4'd0;
				endcase

				case (stat)
					4'd0: temp<=sum[1];
					4'd1: temp<=sum[2];
					4'd2: temp<=sum[3];
					4'd3: temp<=sum[0];
					default: temp<=4'd8;	
				endcase	
			end
	end
	always@(posedge ledr or negedge rst) begin
		if(!rst)
			{sum[3],sum[2],sum[1],sum[0]}<=32'd0;
		else begin
				sum[3]<=sum[2];
				sum[2]<=sum[1];
				sum[1]<=sum[0];
				sum[0]<=data;
		end
	end
endmodule
