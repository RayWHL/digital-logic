`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/08/30 20:14:52
// Design Name: 
// Module Name: divider
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

//分配模块
module divider(clk, clk_N);
    input clk;
    output reg clk_N;
    parameter N=200_000;
    reg [31:0] counter;
    //对clk上升沿计数，达到N/2-1时，clk_N翻转一次
    always @ (posedge clk) begin
    counter=counter+1;
    if(counter==N/2-1)
      begin
      clk_N =~clk_N;
      counter<=0;
       end
    end
endmodule
