`timescale 1ns / 1ps
module temperature_ctrl(
    input  wire clk,
    input  wire rst_n,
    input  wire [7:0] temperature,
    output reg heater_on,
    output reg cooler_on,
    output reg buzzer
);

    // Realistic temperature range for stored grains: 20-30°C (Source: USDA)
    parameter TEMP_LOW  = 8'd20;
    parameter TEMP_HIGH = 8'd30;

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            heater_on <= 1'b0;
            cooler_on <= 1'b0;
            buzzer    <= 1'b0;
        end
        else begin
            if(temperature < TEMP_LOW) begin
                heater_on <= 1'b1;
                cooler_on <= 1'b0;
                buzzer    <= 1'b1;
            end
            else if(temperature > TEMP_HIGH) begin
                heater_on <= 1'b0;
                cooler_on <= 1'b1;
                buzzer    <= 1'b1;
            end
            else begin
                heater_on <= 1'b0;
                cooler_on <= 1'b0;
                buzzer    <= 1'b0;
            end
        end
    end
endmodule
