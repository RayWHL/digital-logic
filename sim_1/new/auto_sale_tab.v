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
        //�����ʼ��
        clk<=0;
        cancle_flag<=0;
        coin_one<=0;
        coin_ten<=0;
        buy_one<=0;
        buy_two<=0;
        reset<=0;
        get_ind<=0;
        
        #200 reset<=~reset;  //��λ�ź���1
        #200 coin_one<=1;
        #200 coin_one<=0;    //Ͷ��һԪ������S1
        #200 coin_one<=1;
        #200 coin_one<=0;
        #200 coin_one<=1;
        #200 coin_one<=0;    //��Ԫ������S2
        #200 coin_ten<=1;
        #200 coin_ten<=0;    //13Ԫ������S3
        #200 buy_two<=1;
        #200 buy_two<=0;     //������Ʒ������8Ԫ��S3
        
        #200 buy_one<=1;
        #200 buy_one<=0;     //������Ʒ����
        #200 buy_two<=1;
        #200 buy_two<=0;     //������Ʒ1��
        
        #200 get_ind<=1;
        #200 get_ind<=0;     //���㣬��S0
        #200 coin_one<=1;
        #200 coin_one<=0;    //һԪ��S1
        #200 cancle_flag<=1;
        #200 cancle_flag<=0;     //ȡ����������S0
        #200 reset<=0;
        #200 reset<=1;       //��λ����S0
    end
    
    always #50 clk=~clk;
    
    
endmodule
