clear all

data_1 = open("sagital_1.csv");
data_2 = open("sagital_2.csv");
angle_1 = data_1.data;
angle_2 = data_2.data;

angle_euler_1_x = data_1.data(:,1:2:3);
figure(1)
plot(angle_euler_1_x(:,1),angle_euler_1_x(:,2));
title("x1")

angle_euler_1_y = data_1.data(:,1:3:4);
figure(2)
plot(angle_euler_1_y(:,1),angle_euler_1_y(:,2));
title("y1")
angle_euler_1_z = data_1.data(:,1:4:5);
figure(3)
plot(angle_euler_1_z(:,1),angle_euler_1_z(:,2)); 
title("z1")

angle_euler_2_x = data_2.data(:,1:2:3);
figure(4)
plot(angle_euler_2_x(:,1),angle_euler_2_x(:,2));
title("x2")

angle_euler_2_y = data_2.data(:,1:3:4);
figure(5)
plot(angle_euler_2_y(:,1),angle_euler_2_y(:,2));
title("y2")

angle_euler_2_z = data_2.data(:,1:4:5);
figure(6)
plot(angle_euler_2_z(:,1),angle_euler_2_z(:,2)); 
title("z2")

eul = [0 pi/2 0];
rotmZYX = eul2rotm(eul)
eul = rotm2eul(rotmZYX)
