`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/09/04 08:23:30
// Design Name: 
// Module Name: FSM_tab
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

//状态机模块仿真
module FSM_tab();
    reg clk, reset, cancle_flag, get_ind,buy_flag;
    reg [9:0] coin_val;
    wire op_start, light, light_one, light_two, hold_ind, not_enough;
    
    FSM dut(clk, reset, cancle_flag, coin_val, get_ind,buy_flag,
                 op_start, light, light_one, light_two, hold_ind, not_enough);
    
    initial begin
        clk<=0;
        reset<=0;
        cancle_flag<=0;
        coin_val<=0;
        get_ind<=0;
        buy_flag<=0;
        
        #200 reset<=1;      //复位开关置1，开始工作
        #200 coin_val<=2;   
        #200 coin_val<=4;
        #200 coin_val<=6;   //投币3元
        #200 coin_val<=26;  //投币13元
        #200 coin_val<=16;  //购买商品2
            buy_flag<=1;    //购买信号置1
        #200 coin_val<=11;  //购买商品1
        #200 coin_val<=1;   //购买商品2
        #200 get_ind<=1;    //找零
             coin_val<=0;   //币值清零
             buy_flag<=0;   //购买信号置零
        #200 get_ind<=0;    
        #200 coin_val<=2;   //投币1元
        #200 coin_val<=4;   //投币2元
        #200 coin_val<=6;
        #200 cancle_flag<=1;    //取消操作
             coin_val<=0;   //币值清零
        #200 cancle_flag<=0;
        #200 coin_val<=20;  //投币10元
        #200 reset<=0;      //复位
            coin_val<=0;
        #200 reset<=1;
    end
    
    always #50 clk<=~clk;
    
    
endmodule
