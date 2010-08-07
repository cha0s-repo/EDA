module ledtest(clk,dbus,sbus);
	input clk;
	output [3:0] dbus,sbus;
	
	wire clk,dclk;
	
	reg [3:0] counter,sec;
	reg [17:0] switch;
	
	divclk todivclk1(clk, dclk,1'b1);
	
	
	always @(posedge dclk) begin			//Seconds plus
		if(counter==9) begin
			counter<=0;
			
			if(sec==5) 
				sec<=0;
			else 
				sec<=sec+1;
				
			
		end
		else counter<=counter+1;
		
	end
	
	always @(posedge clk) begin				// Reflash LED
		if(switch<18'h1ffff) begin
			 ledshow (sec,1,dbus,sbus);
		
		 end
		 else begin
			 ledshow (counter,0,dbus,sbus);
			
		 end
		
		switch<=switch+1;
	end	

	

	task ledshow;
			input [3:0] dat,sel;
			output [3:0] datbus,selbus;
				
				case (sel)
					0: selbus<=4'b1110;
					1: selbus<=4'b1101;
					2: selbus<=4'b1011;
					3: selbus<=4'b0111;
				endcase
				
				datbus[3:0]<=dat;
	endtask



endmodule

module divclk(inclk,outclk,stage);
	input inclk,stage;
	output outclk;
	
	reg outclk;
	reg [28:0] div;

// 61a8 > 1ms; 3d090 > 10ms; bebc20 > 1s
	
	always @(posedge inclk) begin
		if(div==28'hbebc20*stage) begin
			div<=0;
			outclk<=~outclk;
		end else
			div<=div+1;
	end
endmodule