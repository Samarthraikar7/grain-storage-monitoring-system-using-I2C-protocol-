`timescale 1ns / 1ps
module tb_i2c_env;

    reg clk, rst_n;
    reg [7:0] humidity, temperature;
    wire fan_on, alert, buzzer_h;
    wire heater_on, cooler_on, buzzer_t;
    wire scl, sda, start, stop;

    // I2C Master
    i2c_master_skel i2c_master (
        .clk(clk),
        .rst_n(rst_n),
        .scl(scl),
        .sda(sda),
        .start(start),
        .stop(stop)
    );

    // Humidity Control
    humidity_ctrl hum_ctrl (
        .clk(clk),
        .rst_n(rst_n),
        .humidity(humidity),
        .fan_on(fan_on),
        .alert(alert),
        .buzzer(buzzer_h)
    );

    // Temperature Control
    temperature_ctrl temp_ctrl (
        .clk(clk),
        .rst_n(rst_n),
        .temperature(temperature),
        .heater_on(heater_on),
        .cooler_on(cooler_on),
        .buzzer(buzzer_t)
    );

    // Combine buzzer signals (either humidity or temp issue)
    wire buzzer = buzzer_h | buzzer_t;

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("grain_system.vcd");
        $dumpvars(0, tb_i2c_env);

        rst_n = 0;
        humidity = 8'd55;
        temperature = 8'd25;
        #20 rst_n = 1;

        // 1. Normal
        #100;
        humidity = 8'd68; temperature = 8'd27;

        // 2. High humidity
        #100;
        humidity = 8'd75; temperature = 8'd22;

        // 3. Low temperature
        #100;
        humidity = 8'd60; temperature = 8'd17;

        // 4. High temperature
        #100;
        humidity = 8'd64; temperature = 8'd35;

        // 5. Normal again
        #100;
        humidity = 8'd55; temperature = 8'd25;

        #100 $finish;
    end

    initial begin
        $monitor("Time=%0t | Temp=%0d°C | Hum=%0d%% | Fan=%b | Alert=%b | Heater=%b | Cooler=%b | Buzzer=%b",
                 $time, temperature, humidity, fan_on, alert, heater_on, cooler_on, buzzer);
    end

endmodule
