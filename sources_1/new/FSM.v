`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/08/28 22:07:51
// Design Name: 
// Module Name: FSM
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

//状态机模块：通过币值以及各清零信号判断状态转移以及输出信号的控制
module FSM(clk, reset, cancle_flag, coin_val, get_ind, buy_flag,
             op_start, light, light_one, light_two, hold_ind, not_enough );
    input clk, reset, cancle_flag, get_ind, buy_flag;
    input [9:0] coin_val;
    output reg op_start, light, light_one, light_two, hold_ind, not_enough;
    
    parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3;   //四种状态
                     
    reg [1:0] State, StateNext;
    //信号初始化
    initial begin
        op_start <= 0;
        light <= 0;
        light_one <= 0;
        light_two <= 0;
        hold_ind<=0;
        not_enough<=0;
        State<=S0;
    end
    
    always @(State or coin_val or reset or get_ind or cancle_flag or buy_flag) begin
            //电源信号即重置信号起作用，所有灯熄灭，并回到S0状态
            if(reset==0)    begin
                op_start<=0;
                light_one<=0;
                light_two<=0;
                hold_ind<=0;
                light<=0;
                not_enough<=0;
                StateNext<=S0;
                end
            //重置信号不起作用，进行四种状态的转换
            else begin
             light<=1;
        
        case(State)
        //S0初始显示HELLO状态
        S0: begin
            //各指示灯均熄灭
            op_start<=0;
            light_one<=0;
            light_two<=0;
            hold_ind<=0;
            not_enough<=0;
            //根据各清零信号以及币值判断状态转移
            if(reset==0) StateNext<=S0;
            else if(cancle_flag==1&&buy_flag==0) StateNext<=S0;
            else if(get_ind==1) StateNext<=S0;
            else if(coin_val==0) StateNext<=S0;
            else if(coin_val<5)  StateNext<=S1;
            else if(coin_val<10) StateNext<=S2;
            else StateNext<=S3;
        end
        //S1余额不足状态
        S1: begin
            //开始操作指示灯，占用指示灯，余额不足指示灯亮
            op_start<=1;
            light_one<=0;
            light_two<=0;
            hold_ind<=1;
            not_enough<=1;
            //根据各清零信号以及币值判断状态转移
            if(cancle_flag==1&&buy_flag==0)  StateNext<=S0;
            else if(get_ind==1) StateNext<=S0;
            else if(coin_val<5)  StateNext<=S1;
            else if(coin_val<10) StateNext<=S2;
            else StateNext<=S3;
        end
        //S2可以购买商品一状态
        S2: begin
            //开始操作指示灯、商品一指示灯、占用指示灯亮
            op_start<=1;
            light_one<=1;
            light_two<=0;
            hold_ind<=1;
            not_enough<=0;
            //根据各清零信号以及币值判断状态转移
            if(cancle_flag==1&&buy_flag==0)  StateNext<=S0;
            else if(get_ind==1) StateNext<=S0;
            else if(coin_val<5)  StateNext<=S1;
            else if(coin_val<10) StateNext<=S2;
            else    StateNext<=S3;
        end
        //S3可以购买两种商品状态
        S3: begin
            //开始操作、商品一二指示灯、占用指示灯亮
            op_start<=1;
            light_one<=1;
            light_two<=1;
            hold_ind<=1;
            not_enough<=0;
            
            //根据各清零信号以及币值判断状态转移
            if(cancle_flag==1&&buy_flag==0)  StateNext<=S0;
            else if(get_ind==1) StateNext<=S0;
            else if(coin_val<5)  StateNext<=S1;
            else if(coin_val<10) StateNext<=S2;
            else    StateNext<=S3;
        end
       
        endcase
        end
    end
    
    always @(posedge clk) begin
        State <= StateNext;
    end
    
endmodule
