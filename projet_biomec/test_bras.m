clear all


data = open("data.csv");
angle = data.data;
%PacketCounter	SampleTimeFine	Euler_X	Euler_Y	Euler_Z	FreeAcc_X	FreeAcc_Y	FreeAcc_Z	Status
angle_euler_x = data.data(:,2:3);
figure(1)
plot(angle_euler_x(:,1),angle_euler_x(:,2));

angle_euler_y = data.data(:,2:2:4);
figure(2)
plot(angle_euler_y(:,1),angle_euler_y(:,2));

angle_euler_z = data.data(:,2:3:5);
figure(3)
plot(angle_euler_z(:,1),angle_euler_z(:,2)); 