`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/08/29 21:03:09
// Design Name: 
// Module Name: coin_count
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

//币值计算模块
module coin_count(coin_one, coin_ten, get_one, get_two, get_ind,cancle_flag, reset, coin_val, buy_flag );
    input coin_one, coin_ten, get_one, get_two, get_ind, cancle_flag, reset;
    output [9:0] coin_val;
    output buy_flag;
    reg flag1,flag2;
    reg [9:0] one,ten, sub1, sub2;
    initial begin
        
        one<=0;
        ten<=0;
        sub1<=0;
        sub2<=0;
    end
    //投币一元，以及清零
    always @(posedge coin_one or posedge get_ind or posedge cancle_flag or negedge reset) begin
        if(get_ind==1 || reset==0)  one<=0;
        else if(cancle_flag==1 && buy_flag==0)   one<=0;
        else if(coin_val>=1000) one<=one;
       else one<=one+2;
       
    end
    //投币十元，以及清零
    always @(posedge coin_ten or posedge get_ind or posedge cancle_flag or negedge reset) begin
        if(cancle_flag==1 && buy_flag==0)   ten<=0;
        else if(get_ind==1 ||reset==0) ten<=0;
        else if(coin_val>1000)  ten<=ten;
        else ten<=ten+20;
        
    end
    //购买商品一，以及清零
    always @(posedge get_one or posedge get_ind or posedge cancle_flag or negedge reset) begin
        if(cancle_flag==1&&buy_flag==0)  sub1<=0;
        else if(get_ind==1 ||reset==0) begin sub1<=0; flag1<=0; end
        else if(coin_val<5) sub1<=sub1;
        else begin sub1<=sub1+5; flag1<=1; end
    end
    //购买商品二，以及清零
    always @(posedge get_two or posedge get_ind or posedge cancle_flag or negedge reset) begin
        if(cancle_flag==1&&buy_flag==0)  sub2<=0;
        else if(get_ind==1 || reset==0) begin sub2<=0; flag2<=0; end
        else if(coin_val<10)    sub2<=sub2;
        else begin sub2<=sub2+10; flag2<=1; end
     
    end
    assign buy_flag=flag1|flag2;
    assign coin_val=one+ten-sub1-sub2;
    
endmodule
