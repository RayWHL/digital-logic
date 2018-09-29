`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/09/04 08:39:04
// Design Name: 
// Module Name: display_tab
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


module display_tab();
    
    reg op_start, charge_ind, clk, buy_one, buy_two, light;
    reg [5:0] coin_val;
    wire [7:0] seg, an;
    
    display dut(clk, light, op_start, charge_ind, coin_val,buy_one, buy_two, seg, an);
    
    initial begin
        clk<=0;
        op_start<=0;
        light<=1;
        coin_val<=0;
        charge_ind<=0;
        buy_one<=0;
        buy_two<=0;
        
        #100 coin_val<=1;
        op_start<=1;
        
        #100 coin_val<=2;
        #100 coin_val<=3;
        #100 coin_val<=4;
        #100 coin_val<=5;
        #100 coin_val<=6;
        #100 coin_val<=7;
        #100 coin_val<=12;
        
        #200 buy_one<=1;
        
        #200 charge_ind<=1;
        
        #200 coin_val<=0;
        
        
    end
    
    always #5 clk<=~clk;
    
endmodule
