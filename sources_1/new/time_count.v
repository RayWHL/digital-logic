`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/09/07 11:10:56
// Design Name: 
// Module Name: time_count
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module time_count(clk, inp, outp );
    input clk, inp;
    output outp;
    
    reg [31:0] count;
    
    always @(posedge clk) begin
        if(count==32'hffffffff)
            
    end
    
endmodule
