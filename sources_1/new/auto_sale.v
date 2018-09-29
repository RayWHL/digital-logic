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

//����ģ�飺���ø���ģ��ʵ���Զ�������ϵͳ
module auto_sale(clk, reset, cancle_flag, coin_one, coin_ten, buy_one, buy_two, get_ind,
                op_start, light_one, light_two, light, hold_ind, not_enough, light_get, seg, an);
        
        input clk, cancle_flag, coin_one, coin_ten, buy_one, buy_two, reset, get_ind;   //�����ź�
        
        output op_start, light_one, light_two, light, hold_ind, not_enough, light_get;  //����ź�
        output [7:0] seg, an;   //���������ź�
        
        wire coin_one1,coin_ten1,buy_one1,buy_two1;     //������������ź�
        wire [9:0] coin_val;       //��ֵ�ź�
        wire  clk_N, buy_flag;    //�м��ź�
       
       //���ĸ�������������
       deal DL1(clk, coin_one, coin_one1);
       deal DL2(clk, coin_ten, coin_ten1);
       deal DL3(clk, buy_one, buy_one1);
       deal DL4(clk, buy_two, buy_two1);    
        
        //״̬��ģ��
        FSM F1(clk, reset, cancle_flag, coin_val, get_ind, buy_flag,
                     op_start, light, light_one, light_two, hold_ind, not_enough);
        //��ֵ����ģ��            
        coin_count COIN(coin_one1, coin_ten1, buy_one1, buy_two1, get_ind, cancle_flag, reset,  coin_val,buy_flag);
        //��Ƶģ��
        divider DR(clk, clk_N);
        //��ʾģ��
        display DY(clk_N, light, op_start, coin_val,seg, an  );
        //�����ź�
        assign light_get=(get_ind|(cancle_flag&(~buy_flag)))& reset;
        
endmodule
