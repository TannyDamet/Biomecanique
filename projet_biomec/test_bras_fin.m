clc
% x1 = [ 0 -100 170 -100 -125 ];
% y1 = [ 0 -70 73 -70 -70 ];
% z1 = [ 0 70 108 70 31];
% x2 = [ 0 130 159 130 -77];
% y2 = [ 0 -70 68 -70 -86];
% z2 = [ 0 150 173 150 43];
% C1_w1_0 = RotMat(x1(1),y1(1),z1(1));
% C1_w2_1 = inv(C1_w1_0)*RotMat(x1(2),y1(2),z1(2));
% C1_w3_2 = inv(C1_w2_1)*RotMat(x1(3),y1(3),z1(3));
% C1_w4_3 = inv(C1_w3_2)*RotMat(x1(4),y1(4),z1(4))
% C2_w1_0 = RotMat(x2(1),y2(1),z2(1));
% C2_w2_1 = inv(C2_w1_0)*RotMat(x2(2),y2(2),z2(2));
% C2_w3_2 = inv(C2_w2_1)*RotMat(x2(3),y2(3),z2(3));
% C2_w4_3 = inv(C2_w3_2)*RotMat(x2(4),y2(4),z2(4))
% rad2deg(rotm2eul(C1_w4_3))

angle_1 = [0 0 0];
Rz = [cos(angle_1(1)) sin(angle_1(1)) 0 ; -sin(angle_1(1)) cos(angle_1(1)) 0; 0 0 1];
Ry = [cos(angle_1(2)) 0 -sin(angle_1(2)) ; 0 1 0; sin(angle_1(2)) 0 cos(angle_1(2))];
Rx = [1 0 0 ; 0 cos(angle_1(3)) sin(angle_1(3)); 0 -sin(angle_1(3)) cos(angle_1(3))];
rot_mat = Rx*Ry*Rz;

angle_euler_1_x = deg2rad(angle_euler_1_x)
angle_euler_1_y = deg2rad(angle_euler_1_y)
angle_euler_1_z = deg2rad(angle_euler_1_z)

RM = RotMat(angle_euler_1_x,angle_euler_1_y,angle_euler_1_z,rot_mat);
rot_mat_2 =RotMat(angle_euler_2_x,angle_euler_2_y,angle_euler_2_z,rot_mat);

function RM = RotMat(angle_euler_x,angle_euler_y,angle_euler_z,rot_mat)
C1 = 1
N = size(angle_euler_x(:,1))
for k = 1:N
    a = angle_euler_x(k,2);
    b = angle_euler_y(k,2);
    c = angle_euler_z(k,2);

    Rz = [cos(a) sin(a) 0 ; -sin(a) cos(a) 0; 0 0 1];
    Ry = [cos(b) 0 -sin(b) ; 0 1 0; sin(b) 0 cos(b)];
    Rx = [1 0 0 ; 0 cos(c) sin(c); 0 -sin(c) cos(c)];

    rot_mat_i(:,:,k) = Rx*Ry*Rz;

    if k == 1
    C1 = C1 * inv(rot_mat)*rot_mat_i(:,:,k);
    end


    if k > 1
    C1 = C1 * inv(rot_mat_i(:,:,k-1))*rot_mat_i(:,:,k);
    end

    RM = C1
end
end

































