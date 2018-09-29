`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/09/04 08:08:35
// Design Name: 
// Module Name: count_tab
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

//计数模块仿真
module count_tab();
    reg coin_one, coin_ten, buy_one, buy_two, get_ind,cancle_flag, reset;
  
    wire [9:0] coin_val;
    wire buy_flag;
    
    coin_count dut(coin_one, coin_ten, buy_one, buy_two, get_ind,cancle_flag, reset, coin_val, buy_flag);
    
    initial begin
        coin_one<=0;
       coin_ten<=0;
       buy_one<=0;
       buy_two<=0;
       get_ind<=0;
       cancle_flag<=0;
       reset<=1;
       
       #200 coin_one<=1;
       #200 coin_one<=0;    //投币一元
       #200 coin_one<=1;
       #200 coin_one<=0;    //2元
       #200 coin_one<=1;
       #200 coin_one<=0;    //3元
       #200 coin_ten<=1;
       #200 coin_ten<=0;    //13元
       #200 buy_two<=1;
       #200 buy_two<=0;     //购买商品2
       #200 buy_two<=1;
       #200 buy_two<=0;     //购买商品2
       #200 buy_one<=1;
       #200 buy_one<=0;     //购买商品1
       #200 get_ind<=1;
       #200 get_ind<=0;     //找零
       #200 coin_ten<=1;
       #200 coin_ten<=0;    //投币10
       #200 cancle_flag<=1;
       #200 cancle_flag<=0; //取消
       #200 coin_ten<=1;
       #200 coin_ten<=0;    //投币10
       #200 reset<=1;
       #200 reset<=0;       //重置
    end
    
endmodule
