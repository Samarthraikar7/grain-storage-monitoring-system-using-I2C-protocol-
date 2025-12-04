`timescale 1ns / 1ps

module i2c_master_skel (
    input  wire clk,      // System clock
    input  wire rst_n,    // Active-low reset
    output reg  scl,      // I2C clock line
    output reg  sda,      // I2C data line
    output reg  start,    // START pulse
    output reg  stop      // STOP pulse
);

    reg [7:0] state;
    parameter IDLE=0, START_COND=1, DATA_TRANSFER=2, STOP_COND=3;

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            scl   <= 1'b1;
            sda   <= 1'b1;
            start <= 1'b0;
            stop  <= 1'b0;
            state <= IDLE;
        end
        else begin
            case(state)
                IDLE: begin
                    start <= 1'b1;     // Generate START
                    sda   <= 1'b0;
                    state <= START_COND;
                end
                START_COND: begin
                    start <= 1'b0;
                    scl   <= ~scl;     // Toggle clock
                    if(scl) state <= DATA_TRANSFER;
                end
                DATA_TRANSFER: begin
                    sda <= ~sda;       // Toggle data line
                    scl <= ~scl;
                    if(scl && sda) state <= STOP_COND;
                end
                STOP_COND: begin
                    stop  <= 1'b1;     // Generate STOP
                    sda   <= 1'b1;
                    scl   <= 1'b1;
                    state <= IDLE;
                end
            endcase
        end
    end
endmodule
