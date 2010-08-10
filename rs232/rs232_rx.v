// clk: Baud Clock
// rx_data: Receive data port
// ctrl : When a valid data received ctrl reversed
// data: Received data stored here

module rs232_rx(clk,rst,rx_data,ctrl,data);
	input clk,rst;
	input rx_data;
	output ctrl;
	output [7:0] data;

	wire Dclk;
	reg [7:0] data;
	reg ctrl;
	reg [3:0] stat;

	always @(posedge clk or negedge rst) begin
		if(!rst) begin
			ctrl<=0;
			stat<=4'd10;
		end
		else begin
			if(rx_data==0 && stat>=10) begin
				stat<=1;
			end
			else begin
				case (stat)
					4'd1:	stat<=4'd2;
					4'd2:	stat<=4'd3;
					4'd3:	stat<=4'd4;
					4'd4:	stat<=4'd5;
					4'd5:	stat<=4'd6;
					4'd6:	stat<=4'd7;
					4'd7:	stat<=4'd8;	
					4'd8:	stat<=4'd9;	
					4'd9:	stat<=4'd10;
					default:stat<=4'd10;
				endcase


				case (stat)
					4'd1:	data[0]<=rx_data;
					4'd2:	data[1]<=rx_data;
					4'd3:	data[2]<=rx_data;
					4'd4:	data[3]<=rx_data;
					4'd5:	data[4]<=rx_data;
					4'd6:	data[5]<=rx_data;
					4'd7:	data[6]<=rx_data;
					4'd8:	data[7]<=rx_data;
					4'd9:	ctrl<=1;
					default:	ctrl<=0;
				endcase	
			end
		end
	end						
endmodule
