/*
----------------------------------------
Stereoscopic Vision System
Senior Design Project - Team 11
California State University, Sacramento
Spring 2015 / Fall 2015
----------------------------------------
TMDS Encoder
Authors:  Miad Rouhani
Description:
  TMDS TMDSdecoder
*/

module tmds_decoder (
  input clk, 
  input [9:0] datain,
  output reg  de,     
  output reg [7:0] tmdsout, output reg [1:0] ctrl);
  
  parameter CRTPAR0 =10'b1101010100;
  parameter CRTPAR1 =10'b0010101011;
  parameter CRTPAR2 =10'b0101010100;
  parameter CRTPAR3 =10'b1010101011;

  wire [7:0] data;
  assign data = (datain[9]) ? ~datain[7:0] : datain[7:0]; 

  always @ (posedge clk)
	begin
			if(datain==CRTPAR0) begin
				  ctrl[0] <= 1'b0;
				  ctrl[1]<= 1'b0;
				  de <= 1'b0;


			end else if (datain==CRTPAR1) begin
				  ctrl[0] <= 1'b1;
				  ctrl[1] <= 1'b0;
				  de <= 1'b0;
			   

			end else if (datain==CRTPAR2) begin
				  ctrl[0] <= 1'b0;
				  ctrl[1] <= 1'b1;
				  de <= 1'b0;
			 
		  
			end else if (datain==CRTPAR3) begin
				  ctrl[0] <= 1'b1;
				  ctrl[1] <= 1'b1;
				  de <= 1'b0;
			   
				
			end else begin 
				  tmdsout[0] <= data[0];
				  tmdsout[1] <= (datain[8]) ? (data[1] ^ data[0]) : (data[1] ~^ data[0]);
				  tmdsout[2] <= (datain[8]) ? (data[2] ^ data[1]) : (data[2] ~^ data[1]);
				  tmdsout[3] <= (datain[8]) ? (data[3] ^ data[2]) : (data[3] ~^ data[2]);
				  tmdsout[4] <= (datain[8]) ? (data[4] ^ data[3]) : (data[4] ~^ data[3]);
				  tmdsout[5] <= (datain[8]) ? (data[5] ^ data[4]) : (data[5] ~^ data[4]);
				  tmdsout[6] <= (datain[8]) ? (data[6] ^ data[5]) : (data[6] ~^ data[5]);
				  tmdsout[7] <= (datain[8]) ? (data[7] ^ data[6]) : (data[7] ~^ data[6]);

				  de <= 1'b1;
			end  
    
	end

endmodule
