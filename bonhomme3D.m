bras = 0.29;
avant_bras = 0.25;
angle_imu1 = [0 0 0];
angle_epaule_x = [10 20 40 40 40 40 40];
angle_epaule_y = [10 20 40 40 40 40 40];
angle_epaule_z = [10 20 40 40 40 40 40];

angle_coude_x = [0 10 20 30 40 50 60];
angle_coude_y = [0 10 20 30 40 50 60];
angle_coude_z = [0 10 20 30 40 50 60];


angle_epaule_rad_x = conversion_deg_rad(angle_epaule_x);
angle_epaule_rad_y = conversion_deg_rad(angle_epaule_y);
angle_epaule_rad_z = conversion_deg_rad(angle_epaule_z);

angle_coude_rad_x = conversion_deg_rad(angle_coude_x);
angle_coude_rad_y = conversion_deg_rad(angle_coude_y);
angle_coude_rad_z = conversion_deg_rad(angle_coude_z);

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


% on a P0 Pc(i) Pp(i)
% AB =Pc-P0 BC=Pp-Pc



function alphaR = conversion_deg_rad(alpha)
    alphaR = alpha *(pi/180);
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