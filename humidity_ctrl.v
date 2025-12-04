`timescale 1ns / 1ps

module humidity_ctrl(
    input  wire clk,
    input  wire rst_n,
    input  wire [7:0] humidity,   // Humidity input in %
    output reg fan_on,
    output reg alert,
    output reg buzzer
);

    
    // Source: FAO Guidelines - Ideal 12-14% moisture (~60-65% RH at 25°C)
    parameter HUMIDITY_HIGH = 8'd65;
    parameter HUMIDITY_LOW  = 8'd40;

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            fan_on  <= 1'b0;
            alert   <= 1'b0;
            buzzer  <= 1'b0;
        end
        else begin
            if(humidity > HUMIDITY_HIGH) begin
                fan_on  <= 1'b1;
                alert   <= 1'b1;
                buzzer  <= 1'b1;   // Too humid
            end
            else if(humidity < HUMIDITY_LOW) begin
                fan_on  <= 1'b0;
                alert   <= 1'b1;
                buzzer  <= 1'b1;   // Too dry
            end
            else begin
                fan_on  <= 1'b0;
                alert   <= 1'b0;
                buzzer  <= 1'b0;   // Normal
            end
        end
    end
endmodule
