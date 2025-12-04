# grain-storage-monitoring-system-using-I2C-protocol-
An FPGA-based Verilog simulation that models I²C communication and automated temperature–humidity control for grain storage monitoring. The system uses threshold-based logic to trigger virtual actuators like fan, heater, cooler, and buzzer for maintaining safe storage conditions.

🔍 Project Overview
Grain stored in warehouses must be maintained within safe temperature and humidity limits to prevent spoilage, mold, and insect activity. 
This simulation models:
-I²C communication protocol
-Threshold-based decision-making
-Automatic actuator control
-Real-time response through FPGA parallel logic
-Thresholds used (FAO & USDA recommendations):
  -Temperature: 20°C – 30°C
  -Humidity: 45% – 65%


📁 Project Modules
Module	Description
i2c_master_skel.v  :	Simulates basic I²C START, DATA, ACK/NACK, STOP sequences
humidity_ctrl.v    :	Controls fan and buzzer based on humidity thresholds
temperature_ctrl.v :	Controls heater, cooler, and buzzer based on temperature thresholds
tb_i2c_env.v	     :  Complete testbench integrating all modules for simulation
📊 Simulation Results



🏗️ Tools Used
-Xilinx Vivado 2019.2
-Verilog HDL
-Behavioral Simulation (xsim)
-Basys 3 (hardware)
