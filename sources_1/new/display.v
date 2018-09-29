`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/08/30 12:56:37
// Design Name: 
// Module Name: display
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

//显示模块
module display(clk, light, op_start, coin_val,seg, an );
    input op_start, clk, light;
    input [9:0] coin_val;
    output reg [7:0] seg, an;
    reg [3:0] num;
    reg [2:0] count;
    
    initial begin
        count<=0;
        num<=0;
    end
    
    //计数
    always @ (posedge clk) begin
            if(count>4)
            begin
            count<=0;
            end
            count<=count+1;
    end
    
    //选择
    always @(count) begin
        case (count[2:0])
            3'b000 : an = 8'b01111111;
            3'b001 : an = 8'b10111111;
            3'b010 : an = 8'b11011111;
            3'b011 : an = 8'b11101111;
                   
            3'b100 : an = 8'b11110111;
            default: an = 8'b11111111;
                   
          endcase
    end
    
    //译码，控制数码管显示
    always @(coin_val or op_start or light or count) begin
        if(light==0) 
        begin
            seg=8'b11111111;    //reset起作用，数码管全部熄灭
        end
        else    begin
        
        //操作未开始，显示HELLO
            if(op_start==0)
            begin
            case (count[2:0])
            3'b000: seg=8'b10001001;    //H
            3'b001: seg=8'b10000110;    //E
            3'b010: seg=8'b11000111;    //L
            3'b011: seg=8'b11000111;    //L
            3'b100: seg=8'b11000000;    //O
            default: seg=8'b11111111;
            endcase
            end
            
        //操作开始，显示金额
            else    
        begin
             if(coin_val[0]==0)
             begin
                case (count[2:0])
                3'b000: num=coin_val/200;
                3'b001: num=(coin_val%200)/20;
                3'b010: num=(coin_val%20)/2;
                            
                default: num=0;
                endcase
             end
             else
             begin
                case (count[2:0])
                3'b000: num=(coin_val-1)/200;
                3'b001: num=((coin_val-1)%200)/20;
                3'b010: num=((coin_val-1)%20)/2;
                3'b011: num=5;                         
                default: num=0;
                endcase
             end   
                  
            //不同位是否带小数点
            if(count==2)    begin
            case (num[3:0])
                   4'b0000: seg = 8'b01000000;
                   4'b0001: seg = 8'b01111001;
                   4'b0010: seg = 8'b00100100;
                   4'b0011: seg = 8'b00110000;
                   4'b0100: seg = 8'b00011001;
                   4'b0101: seg = 8'b00010010;
                   4'b0110: seg = 8'b00000010;
                   4'b0111: seg = 8'b01111000;
                   4'b1000: seg = 8'b00000000;
                   4'b1001: seg = 8'b00011000;
                   default: seg = 8'b01111111;
                    endcase
                   end
             else    begin
              case (num[3:0])
                              4'b0000: seg = 8'b11000000;
                              4'b0001: seg = 8'b11111001;
                              4'b0010: seg = 8'b10100100;
                              4'b0011: seg = 8'b10110000;
                              4'b0100: seg = 8'b10011001;
                              4'b0101: seg = 8'b10010010;
                              4'b0110: seg = 8'b10000010;
                              4'b0111: seg = 8'b11111000;
                              4'b1000: seg = 8'b10000000;
                              4'b1001: seg = 8'b10011000;
                              default: seg = 8'b11111111;
                endcase
                 end
            
            
        end
        end
    end
    
endmodule
