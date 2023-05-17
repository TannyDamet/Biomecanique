i_P_0 = [0 0 0];
i_P_x = [1 0 0];
i_P_y = [0 1 0];
i_P_z = [0 0 1];


w_P_0 = RM * i_P_0';
w_P_x = RM * i_P_x';
w_P_y = RM * i_P_y';
w_P_z = RM * i_P_z';

seg_x = [i_P_0' w_P_x ];
seg_y = [i_P_0' w_P_y];
seg_z = [i_P_0' w_P_z];

figure(1)
for i=1:length(1:10:length(angle_euler_1_x))
    plot3(seg_x(1,1:2),seg_x(2,1:2),seg_x(3,1:2),'r-o');
    hold on;
    plot3(seg_y(1,1:2),seg_y(2,1:2),seg_y(3,1:2),'g-o');
    hold on
    plot3(seg_z(1,1:2),seg_z(2,1:2),seg_z(3,1:2),'b-o');
    hold on
end

xlabel("x");
ylabel("y");
zlabel("z");