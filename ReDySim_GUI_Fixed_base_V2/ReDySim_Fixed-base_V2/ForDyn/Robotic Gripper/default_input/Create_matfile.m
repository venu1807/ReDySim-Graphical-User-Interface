function []=Create_matfile() 
% sss = 'Calling inputs 2 link'

%System: Robotic Gripper
%Number of links 
n=4;

%Degree of fredom of the system
dof=4;
Tp=10;
steps=0.01;
%system type
type=0; %1 for Closed-loop and 0 for open-loop

% Link lengths
al=[0.10; 0.05; 0.05; 0.05]; 

%DH PARAMETERs
alp=[0; 0; 0; 0];
a=[0; 0.10; 0.05; 0.05];
b=[0; 0; 0; 0];
th=[0; 0; 0; pi/2];

%Enter joint type , r=1 if revolute and r=0 if prismatic
r=[1; 1; 1; 1];

%PARENT ARRAY
bt=[0; 1; 2; 1];

%Actuated joints of open tree
aj=[1; 1; 1; 1]; %enter 1 for actuated joints and 0 otherwise


% d - VECTOR FORM ORIGIN TO CG 
dx=[al(1)/2; al(2)/2; al(3)/2; al(4)/2];
dy=[0;       0;       0;       0];
dz=[0;       0;       0;       0];

% MASS AND MOMENT OF INERTIA AND GRAVITY
m=[0.4; 0.2; 0.2; 0.2];
g=[0; -9.81; 0];
% g=[0; 0; 0];

%Inertia Tensor of the kth link about Center-Of-Mass (COM) in ith frame
%which is rigid attach to the link
Icxx=zeros(n,1);Icyy=zeros(n,1);Iczz=zeros(n,1); % Initialization 
Icxy=zeros(n,1);Icyz=zeros(n,1);Iczx=zeros(n,1);
Icxx(1)=0;  Icyy(1)=(1/12)*m(1)*al(1)*al(1);  Iczz(1)=(1/12)*m(1)*al(1)*al(1);
Icxx(2)=0;  Icyy(2)=(1/12)*m(2)*al(2)*al(2);  Iczz(2)=(1/12)*m(2)*al(2)*al(2);
Icxx(3)=0;  Icyy(3)=(1/12)*m(3)*al(3)*al(3);  Iczz(3)=(1/12)*m(3)*al(3)*al(3);
Icxx(4)=0;  Icyy(4)=(1/12)*m(4)*al(4)*al(4);  Iczz(4)=(1/12)*m(4)*al(4)*al(4);

save inputs.mat n dof type alp a b th bt r dx dy dz m g  Icxx Icyy Iczz Icxy Icyz Iczx aj al Tp steps

end