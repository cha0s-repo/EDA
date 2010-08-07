// clk:External Clock
// rx: Receive Port
// tx: Transfer Port
// ledr: When rx got a data, ledr reversed once. This signal will be used as stage state
// dbus: LED show data bus
// sbus: LED show select bus

module rs232(clk,rx,tx,ledr,dbus,sbus);
	input clk;
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

	parameter ClkFrq=25000000 ;
	parameter Baud	=9600;
	parameter DivScale	=ClkFrq/Baud/2;

	initial
		stat=4'd0;

	divclk dclk(clk,Dclk,DivScale);

	rs232_rx rever(Dclk,rx,ledr,data);	
	rs232_tx transer(Dclk,data,ledr,tx);

	LedShow shownum(temp,stat,dbus,sbus);	

	always @(posedge Dclk or posedge ledr) begin
		if(ledr==1) begin
			loop<=0;

		end
		else begin
			if(loop<=3) begin
				loop<=loop+1;
				case (loop)
					4'd0: sum[3]<=sum[2];
					4'd1: sum[2]<=sum[1];
					4'd2: sum[1]<=sum[0];
					4'd3: sum[0]<=data;
				endcase
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
	end	
endmodule
