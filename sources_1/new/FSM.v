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

//״̬��ģ�飺ͨ����ֵ�Լ��������ź��ж�״̬ת���Լ�����źŵĿ���
module FSM(clk, reset, cancle_flag, coin_val, get_ind, buy_flag,
             op_start, light, light_one, light_two, hold_ind, not_enough );
    input clk, reset, cancle_flag, get_ind, buy_flag;
    input [9:0] coin_val;
    output reg op_start, light, light_one, light_two, hold_ind, not_enough;
    
    parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3;   //����״̬
                     
    reg [1:0] State, StateNext;
    //�źų�ʼ��
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
            //��Դ�źż������ź������ã����е�Ϩ�𣬲��ص�S0״̬
            if(reset==0)    begin
                op_start<=0;
                light_one<=0;
                light_two<=0;
                hold_ind<=0;
                light<=0;
                not_enough<=0;
                StateNext<=S0;
                end
            //�����źŲ������ã���������״̬��ת��
            else begin
             light<=1;
        
        case(State)
        //S0��ʼ��ʾHELLO״̬
        S0: begin
            //��ָʾ�ƾ�Ϩ��
            op_start<=0;
            light_one<=0;
            light_two<=0;
            hold_ind<=0;
            not_enough<=0;
            //���ݸ������ź��Լ���ֵ�ж�״̬ת��
            if(reset==0) StateNext<=S0;
            else if(cancle_flag==1&&buy_flag==0) StateNext<=S0;
            else if(get_ind==1) StateNext<=S0;
            else if(coin_val==0) StateNext<=S0;
            else if(coin_val<5)  StateNext<=S1;
            else if(coin_val<10) StateNext<=S2;
            else StateNext<=S3;
        end
        //S1����״̬
        S1: begin
            //��ʼ����ָʾ�ƣ�ռ��ָʾ�ƣ�����ָʾ����
            op_start<=1;
            light_one<=0;
            light_two<=0;
            hold_ind<=1;
            not_enough<=1;
            //���ݸ������ź��Լ���ֵ�ж�״̬ת��
            if(cancle_flag==1&&buy_flag==0)  StateNext<=S0;
            else if(get_ind==1) StateNext<=S0;
            else if(coin_val<5)  StateNext<=S1;
            else if(coin_val<10) StateNext<=S2;
            else StateNext<=S3;
        end
        //S2���Թ�����Ʒһ״̬
        S2: begin
            //��ʼ����ָʾ�ơ���Ʒһָʾ�ơ�ռ��ָʾ����
            op_start<=1;
            light_one<=1;
            light_two<=0;
            hold_ind<=1;
            not_enough<=0;
            //���ݸ������ź��Լ���ֵ�ж�״̬ת��
            if(cancle_flag==1&&buy_flag==0)  StateNext<=S0;
            else if(get_ind==1) StateNext<=S0;
            else if(coin_val<5)  StateNext<=S1;
            else if(coin_val<10) StateNext<=S2;
            else    StateNext<=S3;
        end
        //S3���Թ���������Ʒ״̬
        S3: begin
            //��ʼ��������Ʒһ��ָʾ�ơ�ռ��ָʾ����
            op_start<=1;
            light_one<=1;
            light_two<=1;
            hold_ind<=1;
            not_enough<=0;
            
            //���ݸ������ź��Լ���ֵ�ж�״̬ת��
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
