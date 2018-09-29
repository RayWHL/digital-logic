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

//����ģ�����
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
       #200 coin_one<=0;    //Ͷ��һԪ
       #200 coin_one<=1;
       #200 coin_one<=0;    //2Ԫ
       #200 coin_one<=1;
       #200 coin_one<=0;    //3Ԫ
       #200 coin_ten<=1;
       #200 coin_ten<=0;    //13Ԫ
       #200 buy_two<=1;
       #200 buy_two<=0;     //������Ʒ2
       #200 buy_two<=1;
       #200 buy_two<=0;     //������Ʒ2
       #200 buy_one<=1;
       #200 buy_one<=0;     //������Ʒ1
       #200 get_ind<=1;
       #200 get_ind<=0;     //����
       #200 coin_ten<=1;
       #200 coin_ten<=0;    //Ͷ��10
       #200 cancle_flag<=1;
       #200 cancle_flag<=0; //ȡ��
       #200 coin_ten<=1;
       #200 coin_ten<=0;    //Ͷ��10
       #200 reset<=1;
       #200 reset<=0;       //����
    end
    
endmodule
