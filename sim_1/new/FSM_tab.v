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

//״̬��ģ�����
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
        
        #200 reset<=1;      //��λ������1����ʼ����
        #200 coin_val<=2;   
        #200 coin_val<=4;
        #200 coin_val<=6;   //Ͷ��3Ԫ
        #200 coin_val<=26;  //Ͷ��13Ԫ
        #200 coin_val<=16;  //������Ʒ2
            buy_flag<=1;    //�����ź���1
        #200 coin_val<=11;  //������Ʒ1
        #200 coin_val<=1;   //������Ʒ2
        #200 get_ind<=1;    //����
             coin_val<=0;   //��ֵ����
             buy_flag<=0;   //�����ź�����
        #200 get_ind<=0;    
        #200 coin_val<=2;   //Ͷ��1Ԫ
        #200 coin_val<=4;   //Ͷ��2Ԫ
        #200 coin_val<=6;
        #200 cancle_flag<=1;    //ȡ������
             coin_val<=0;   //��ֵ����
        #200 cancle_flag<=0;
        #200 coin_val<=20;  //Ͷ��10Ԫ
        #200 reset<=0;      //��λ
            coin_val<=0;
        #200 reset<=1;
    end
    
    always #50 clk<=~clk;
    
    
endmodule
