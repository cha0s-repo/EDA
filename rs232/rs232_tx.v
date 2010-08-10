// clk: External Clock
// data: Data needs to transfer
// ctrl: When ctrl HIGHT transfer launches
// tx_data: Transfer data Port

module rs232_tx(clk,rst,data,ctrl,tx_data);
	input clk,rst;
	input [7:0] data;
	input ctrl;
	output tx_data;

	wire baud;
	reg tx_data;
	reg [3:0] stat;
	
	divclk rx_clk(clk,baud,115200);
	
	always @(posedge clk or negedge rst) begin
		if(!rst) begin
			tx_data<=1;
			stat<=4'd11;
		end
		else begin 
				case (stat)
					4'd11: if(ctrl) stat<=4'd10;
					4'd10: if(baud) stat<=4'd0;				// Last at least one BAUD clock
					4'd0: if(baud) stat<=4'd1;
					4'd1: if(baud) stat<=4'd2;
					4'd2: if(baud) stat<=4'd3;
					4'd3: if(baud) stat<=4'd4;
					4'd4: if(baud) stat<=4'd5;
					4'd5: if(baud) stat<=4'd6;
					4'd6: if(baud) stat<=4'd7;
					4'd7: if(baud) stat<=4'd8;	
					4'd8: if(baud) stat<=4'd9;
					4'd9: if(baud) stat<=4'd11;	
					default:stat<=4'd11;
				endcase


				case (stat)
					4'd0:	tx_data<=0;
					4'd1:	tx_data<=data[0];
					4'd2:	tx_data<=data[1];
					4'd3:	tx_data<=data[2];
					4'd4:	tx_data<=data[3];
					4'd5:	tx_data<=data[4];
					4'd6:	tx_data<=data[5];
					4'd7:	tx_data<=data[6];
					4'd8:	tx_data<=data[7];
					//4'd9:	tx_data<=1;
					default:tx_data<=1;
				endcase	
			end
	
	end						
endmodule
