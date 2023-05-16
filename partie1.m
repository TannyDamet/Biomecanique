clear all
clc

x1_d = [ 0 -100 170 -100 -125 ];
y1_d = [ 0 -70 73 -70 -70 ];
z1_d = [ 0 70 108 70 31];

x2_d = [ 0 130 159 130 -77];
y2_d = [ 0 -70 68 -70 -86];
z2_d = [ 0 150 173 150 43];

x1 = deg2rad(x1_d);
y1 = deg2rad(y1_d);
z1 = deg2rad(z1_d);

x2 = deg2rad(x2_d);
y2 = deg2rad(y2_d);
z2 = deg2rad(z2_d);


C1_w1_0 = RotMat(x1(1),y1(1),z1(1));
C1_w2_1 = inv(C1_w1_0)*RotMat(x1(2),y1(2),z1(2));
C1_w3_2 = inv(C1_w2_1)*RotMat(x1(3),y1(3),z1(3));
C1_w4_3 = inv(C1_w3_2)*RotMat(x1(4),y1(4),z1(4));

C2_w1_0 = RotMat(x2(1),y2(1),z2(1));
C2_w2_1 = inv(C2_w1_0)*RotMat(x2(2),y2(2),z2(2));
C2_w3_2 = inv(C2_w2_1)*RotMat(x2(3),y2(3),z2(3));
C2_w4_3 = inv(C2_w3_2)*RotMat(x2(4),y2(4),z2(4));

rad2deg(rotm2eul(C1_w4_3))

function rot_mat = RotMat(a,b,c)
Rz = [cos(a) sin(a) 0 ; -sin(a) cos(a) 0; 0 0 1];
Ry = [cos(b) 0 -sin(b) ; 0 1 0; sin(b) 0 cos(b)];
Rx = [1 0 0 ; 0 cos(c) sin(c); 0 -sin(c) cos(c)];
rot_mat = Rx*Ry*Rz;
end 
