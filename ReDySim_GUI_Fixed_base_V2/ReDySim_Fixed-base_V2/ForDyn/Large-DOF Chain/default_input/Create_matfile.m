function []=Create_matfile() 
% sss = 'Calling inputs 2 link'

%System Large-DOF Serial chain
%Number of links 
n=20;

%Degree of fredom of the system
dof=n;
Tp=10;
steps=0.01;
%system type
type=0; %1 for Closed-loop and 0 for open-loop

for i=1:n
% Link lengths
al(i,1)=0.03; 

%DH PARAMETERs
alp(i,1)=0;
a(i,1)=0.03;
b(i,1)=0;
%PARENT ARRAY
bt(i,1)=i-1;
th(i,1)=0;

%Enter joint type , r=1 if revolute and r=0 if prismatic
r(i,1)=1;


%Actuated joints of open tree
aj(i,1)=1; %enter 1 for actuated joints and 0 otherwise

% d - VECTOR FORM ORIGIN TO CG 
dx(i,1)=al(i)/2;   % all X coordinates
dy(i,1)=0;         % all Y coordinates
dz(i,1)=0;         % all Z coordinates

% MASS AND MOMENT OF INERTIA
m(i,1)=0.05;

%Inertia Tensor of the kth link about Center-Of-Mass (COM) in ith frame
%which is rigid attach to the link
Icxy(i,1)=0;Icyz(i,1)=0;Iczx(i,1)=0; 
Icxx(i,1)=(1/12)*m(i)*.01*.01;   
Icyy(i,1)=(1/12)*m(i)*al(i)*al(i);  
Iczz(i,1)=(1/12)*m(i)*al(i)*al(i); 
end

al(1)=0; % Due to modified DH parameters 
% GRAVITY
g=[0; -9.81; 0];
% g=[0; 0; 0];


save inputs.mat n dof type alp a b th bt r dx dy dz m g  Icxx Icyy Iczz Icxy Icyz Iczx aj al Tp steps

end