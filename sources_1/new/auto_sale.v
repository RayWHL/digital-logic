`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/08/29 20:46:25
// Design Name: 
// Module Name: auto_sale
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

//顶层模块：调用各子模块实现自动售卖机系统
module auto_sale(clk, reset, cancle_flag, coin_one, coin_ten, buy_one, buy_two, get_ind,
                op_start, light_one, light_two, light, hold_ind, not_enough, light_get, seg, an);
        
        input clk, cancle_flag, coin_one, coin_ten, buy_one, buy_two, reset, get_ind;   //输入信号
        
        output op_start, light_one, light_two, light, hold_ind, not_enough, light_get;  //输出信号
        output [7:0] seg, an;   //数码管输出信号
        
        wire coin_one1,coin_ten1,buy_one1,buy_two1;     //按键消抖后的信号
        wire [9:0] coin_val;       //币值信号
        wire  clk_N, buy_flag;    //中间信号
       
       //对四个按键输入消抖
       deal DL1(clk, coin_one, coin_one1);
       deal DL2(clk, coin_ten, coin_ten1);
       deal DL3(clk, buy_one, buy_one1);
       deal DL4(clk, buy_two, buy_two1);    
        
        //状态机模块
        FSM F1(clk, reset, cancle_flag, coin_val, get_ind, buy_flag,
                     op_start, light, light_one, light_two, hold_ind, not_enough);
        //币值计数模块            
        coin_count COIN(coin_one1, coin_ten1, buy_one1, buy_two1, get_ind, cancle_flag, reset,  coin_val,buy_flag);
        //分频模块
        divider DR(clk, clk_N);
        //显示模块
        display DY(clk_N, light, op_start, coin_val,seg, an  );
        //找零信号
        assign light_get=(get_ind|(cancle_flag&(~buy_flag)))& reset;
        
endmodule
