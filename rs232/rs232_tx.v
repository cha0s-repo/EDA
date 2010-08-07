// clk: Baud Clock
// data: Data needs to transfer
// ctrl: When ctrl HIGHT transfer launches
// tx_data: Transfer data Port

module rs232_tx(clk,data,ctrl,tx_data);
	input clk;
	input [7:0] data;
	input ctrl;
	output tx_data;

	wire Dclk;
	reg tx_data;
	reg [3:0] stat;

	initial begin
		tx_data=1;
		stat=4'd10;
	end

	always @(posedge clk or posedge ctrl) begin
		if(ctrl==1) begin
			stat<=0;
		end
		else begin
			case (stat)
				4'd0:	stat<=4'd1;
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
