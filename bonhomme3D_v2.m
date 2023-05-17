clear all; close all;


data1 = open("sagital_1.csv");
data2 = open("sagital_2.csv");

%PacketCounter	SampleTimeFine	Euler_X	Euler_Y	Euler_Z	FreeAcc_X	FreeAcc_Y	FreeAcc_Z	Status
angle_euler_1_x = data1.data(:,2:3);
angle_euler_2_x = data2.data(:,2:3);

angle_euler_1_y = data1.data(:,2:2:4);
angle_euler_2_y = data2.data(:,2:2:4);

angle_euler_1_z = data1.data(:,2:3:5);
angle_euler_2_z = data2.data(:,2:3:5);

angle_euler_1_x = deg2rad(angle_euler_1_x(:,1));
angle_euler_1_y = deg2rad(angle_euler_1_y(:,1));
angle_euler_1_z = deg2rad(angle_euler_1_z(:,1));

angle_euler_2_x = deg2rad(angle_euler_2_x(:,1));
angle_euler_2_y = deg2rad(angle_euler_2_y(:,1));
angle_euler_2_z = deg2rad(angle_euler_2_z(:,1));

angle_1 = [0 0 0];

Rz = [cos(angle_1(1)) sin(angle_1(1)) 0 ; -sin(angle_1(1)) cos(angle_1(1)) 0; 0 0 1];
Ry = [cos(angle_1(2)) 0 -sin(angle_1(2)) ; 0 1 0; sin(angle_1(2)) 0 cos(angle_1(2))];
Rx = [1 0 0 ; 0 cos(angle_1(3)) -sin(angle_1(3)); 0 sin(angle_1(3)) cos(angle_1(3))];

rot_mat = Rx*Ry*Rz;

[RM1,RM_1] = RotMat(angle_euler_1_x,angle_euler_1_y,angle_euler_1_z,rot_mat);

[RM2,RM_2]= RotMat(angle_euler_2_x,angle_euler_2_y,angle_euler_2_z,rot_mat);


%rot_mat_2 =RotMat(angle_euler_2_x,angle_euler_2_y,angle_euler_2_z,rot_mat);


bras = 0.29;
avant_bras = 0.25;
angle_imu1 = [0 0 0];

angle_epaule_rad_x = RM_1(:,1);
angle_epaule_rad_y = RM_1(:,2);
angle_epaule_rad_z = RM_1(:,3);

angle_coude_rad_x =  RM_2(:,1);
angle_coude_rad_y = RM_2(:,2);
angle_coude_rad_z = RM_2(:,3);

coude = [];
poignet = [];
cTw = [bras 0 0];
pTw = [avant_bras 0 0];


for i =1:length(angle_epaule_rad_x)
    cRw = rotz(angle_epaule_rad_z(i))*roty(angle_epaule_rad_y(i))*rotx(angle_epaule_rad_x(i));
    %changement de repere du monde au coude 
    cMw = [cRw cTw';0 0 0 1];
    Pc = inv(cMw)*[0 0 0 1]';
    coude=[coude Pc]
     pRw = rotz(angle_coude_rad_x(i))*roty(angle_coude_rad_y(i))*rotx(angle_coude_rad_x(i))
     pMw = [pRw pTw';0 0 0 1];
     Pp = inv(pMw)*[0 0 0 1]' + Pc;
     poignet=[poignet Pp]   
end


% juste pour l'affichage
figure(1);
title("bras dans le plan sagittal");
axis equal
mRw = rotz(-pi/2);
mTw = [0 0 0];
mMw = [mRw mTw';0 0 0 1];
Po = [0 0 0 0]'
for i=1:length(angle_coude_rad_x)
    Pcw=coude(:,i);
    Pcm = mMw*Pcw;
    Ppw=poignet(:,i);
    Ppm = mMw*Ppw;
    segment = [Po(1:4) Pcm(1:4) Ppm(1:4)]
    segment(2,1:3)
    plot3(segment(1,1:3),segment(2,1:3),segment(3,1:3),"o-")   
    hold on;
end

xlabel("Axe des x"); ylabel("Axe des y"); zlabel("Axe des z");

% on a P0 Pc(i) Pp(i)

C0 = Pcm-Po;
PC = Ppm-Pcm;

alpha = acos((PC'*C0)/(norm(PC')*norm(C0)));

angleB_AB = conversion_rad_cos(alpha)



function alphaR = conversion_deg_rad(alpha)
    alphaR = alpha *(pi/180);
end

function alphaD = conversion_rad_cos(alpha)
    alphaD = alpha /(pi/180);
end

function Rz = rotz(alpha)
% create rotation matrix around z axis with alpha in radian
  Rz = [cos(alpha) sin(alpha) 0; -sin(alpha) cos(alpha) 0; 0 0 1];
end

function Ry = roty(teta)
% create rotation matrix around y axis with alpha in radian
  Ry = [cos(teta) 0 -sin(teta); 0 1 0; sin(teta) 0 cos(teta)];
end

function Rx = rotx(gamma)
% create rotation matrix around x axis with alpha in radian
  Rx = [1 0 0; 0 cos(gamma) sin(gamma); 0 -sin(gamma) cos(gamma)];
end

function [RM,RM_1] = RotMat(angle_euler_x,angle_euler_y,angle_euler_z,rot_mat)
    C1 = 1;
    N = size(angle_euler_x);
    for k = 1:N
        a = angle_euler_x(k,1);
        b = angle_euler_y(k,1);
        c = angle_euler_z(k,1);
    
        Rz = [cos(a) sin(a) 0 ; -sin(a) cos(a) 0; 0 0 1];
        Ry = [cos(b) 0 -sin(b) ; 0 1 0; sin(b) 0 cos(b)];
        Rx = [1 0 0 ; 0 cos(c) -sin(c); 0 sin(c) cos(c)];

        rot_mat_i(:,:,k) = Rx*Ry*Rz;

    
        if k == 1
        C1 = C1 * inv(rot_mat)*rot_mat_i(:,:,k);
        end
    
    
        if k > 1
        C1 = C1 * inv(rot_mat_i(:,:,k-1))*rot_mat_i(:,:,k);
        end
    
        RM = C1;

        RM_1(k,:) = rotm2eul(RM)

        
    end
end