`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/09/07 09:43:00
// Design Name: 
// Module Name: deal
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

//按键消抖
module deal(clk, inp, outp);
    input inp, clk;
    output outp;
    
    reg delay1, delay2;
    reg [19:0] count;
    reg clk_20;
    //对clk分频到20ms
    always @(posedge clk) begin
        if(count==20'hffff) begin
            clk_20<=~clk_20;
            count<=0;
        end
        else
            count<=count+1;
    end
    //消除20ms以下的脉冲
    always @(posedge clk_20) begin
        delay1<=inp;
        delay2<=delay1;
    end
    
    assign outp=delay1&delay2;
    
endmodule
