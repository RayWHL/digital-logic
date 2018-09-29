`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/09/03 18:50:23
// Design Name: 
// Module Name: auto_sale_tab
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


module auto_sale_tab( );
    
    reg clk, reset, cancle_flag, coin_one, coin_ten, buy_one, buy_two, get_ind;
    
    wire op_start, light_one, light_two, light, hold_ind, not_enough, light_get;
    
    wire  [7:0] seg, an;
    
    auto_sale dut(clk, reset, cancle_flag, coin_one, coin_ten, buy_one, buy_two, get_ind,
                    op_start, light_one, light_two, light, hold_ind, not_enough, light_get, seg, an);
    
    initial begin
        //输入初始化
        clk<=0;
        cancle_flag<=0;
        coin_one<=0;
        coin_ten<=0;
        buy_one<=0;
        buy_two<=0;
        reset<=0;
        get_ind<=0;
        
        #200 reset<=~reset;  //复位信号置1
        #200 coin_one<=1;
        #200 coin_one<=0;    //投币一元，进入S1
        #200 coin_one<=1;
        #200 coin_one<=0;
        #200 coin_one<=1;
        #200 coin_one<=0;    //三元，进入S2
        #200 coin_ten<=1;
        #200 coin_ten<=0;    //13元，进入S3
        #200 buy_two<=1;
        #200 buy_two<=0;     //购买商品二，余8元，S3
        
        #200 buy_one<=1;
        #200 buy_one<=0;     //购买商品二，
        #200 buy_two<=1;
        #200 buy_two<=0;     //购买商品1，
        
        #200 get_ind<=1;
        #200 get_ind<=0;     //找零，回S0
        #200 coin_one<=1;
        #200 coin_one<=0;    //一元，S1
        #200 cancle_flag<=1;
        #200 cancle_flag<=0;     //取消操作，回S0
        #200 reset<=0;
        #200 reset<=1;       //复位，回S0
    end
    
    always #50 clk=~clk;
    
    
endmodule
