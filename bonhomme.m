clear all; close all;

bras = 0.29;
avant_bras = 0.25;
angle_imu1 = [0 0 0];
angle_epaule = [10 20 40 40 40 40 40];
angle_coude = [0 10 20 30 40 50 60];

angle_epaule_rad = conversion_deg_rad(angle_epaule)
angle_coude_rad = conversion_deg_rad(angle_coude)
coude = [];
poignet = [];
cTw = [bras 0 0];
pTw = [avant_bras 0 0];

for i =1:length(angle_epaule_rad)
    cRw = rotz(angle_epaule_rad(i));
    %changement de repere du monde au coude 
    cMw = [cRw cTw';0 0 0 1];
    Pc = inv(cMw)*[0 0 0 1]';
    coude=[coude Pc]
    pRw = rotz(angle_coude_rad(i));
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
Po = [0 0 0]'
for i=1:length(angle_coude_rad)
    Pcw=coude(:,i);
    Pcm = mMw*Pcw;
    Ppw=poignet(:,i);
    Ppm = mMw*Ppw;
    segment = [Po Pcm(1:3) Ppm(1:3)]
    segment(2,1:2)
    plot(segment(1,1:3),segment(2,1:3),"o-")   
    hold on;
end

xlabel("Axe des x"); ylabel("Axe des y");





function alphaR = conversion_deg_rad(alpha)
    alphaR = alpha *(pi/180);
end

function Rz = rotz(alpha)
% create rotation matrix around z axis with alpha in radian
  Rz = [cos(alpha) sin(alpha) 0; -sin(alpha) cos(alpha) 0; 0 0 1];
end
