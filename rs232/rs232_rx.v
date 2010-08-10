// clk: External Clock
// rx_data: Receive data port
// ctrl : When a valid data received ctrl reversed
// data: Received data stored here

module rs232_rx(clk,rst,rx_data,ctrl,data);
	input clk,rst;
	input rx_data;
	output ctrl;
	output [7:0] data;

	wire baud8;
	reg [7:0] data;
	reg ctrl;
	reg [3:0] stat;
	reg [3:0] step;
	
	divclk rx_clk(clk,baud8,921600);				// 921600=115200*8
	
	always @(posedge baud8 or negedge rst) begin
		if(!rst) begin
			ctrl<=0;
			stat<=4'd0;
		end
		else begin
				case (stat)
					4'd0: if(!rx_data) stat<=4'd1;
					4'd1: if(step[3]) stat<=4'd2;
					4'd2: if(step[3]) stat<=4'd3;
					4'd3: if(step[3]) stat<=4'd4;
					4'd4: if(step[3]) stat<=4'd5;
					4'd5: if(step[3]) stat<=4'd6;
					4'd6: if(step[3]) stat<=4'd7;
					4'd7: if(step[3]) stat<=4'd8;	
					4'd8: if(step[3]) stat<=4'd9;	
					4'd9: if(step[3]) stat<=4'd0;
					default:stat<=4'd0;
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

	always @(posedge baud8) begin
		if(stat==0)
			step<=4'd0;
		else
			step <= step[2:0] +1;
	end

endmodule
