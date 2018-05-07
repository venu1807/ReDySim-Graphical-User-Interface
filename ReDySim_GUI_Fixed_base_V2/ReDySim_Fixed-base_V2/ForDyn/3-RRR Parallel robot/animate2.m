% ReDySim animate module. This module animates the system under study
% Contibutors: Dr. Suril Shah and Prof S. K. Saha @IIT Delhi
function [] = animate2(handles)
disp('------------------------------------------------------------------');
disp('Animating the simulation data');

% load statevar.dat;
% load timevar.dat;
% Y=statevar;T=timevar;

[n dof type alp a b th bt r dx dy dz m g  Icxx Icyy Iczz Icxy Icyz Iczx aj al ]=inputs();
len_sum=sum(al)*.5;
xmin=-len_sum;
xmax=len_sum;
ymin=-len_sum;
ymax=len_sum;
zmin=-len_sum;
zmax=len_sum;

%  figure('Name','Animation Window','NumberTitle','off');
for i=1
%     q=Y(i,1:n);
%     dq=Y(i,n+1:2*n)';
    q=[ 1.0467;    5.4206;   -2.5357;    4.1883;   -2.0939;    5.7637;   -0.9869];
    dq=[0;0;0;0;0;0;0];
    [so sc vc tt st]=for_kine(q, dq, n, alp, a, b, th, bt, r, dx, dy, dz);
    FBX=[so(1,1),so(1,4),so(1,6),so(1,1)];
    FBY=[so(2,1),so(2,4),so(2,6),so(2,1)];
    B1X=[so(1,1), st(1,1),  st(1,2)];
    B1Y=[so(2,1), st(2,1),  st(2,2)];
    B2X=[so(1,4), st(1,4), st(1,4), st(1,5)];
    B2Y=[so(2,4), st(2,4), st(2,4), st(2,5)];
    B3X=[so(1,6), st(1,6), st(1,7)];
    B3Y=[so(2,6), st(2,6), st(2,7)];
    PBX=[st(1,2),st(1,5),st(1,7),st(1,2)];
    PBY=[st(2,2),st(2,5),st(2,7),st(2,2)];
        
%     t=T(i);
%     t=num2str(t);
    axes(handles.axes1)
    plot(FBX,FBY,B1X,B1Y,'.-',B2X,B2Y,'.-',B3X,B3Y,'.-',PBX,PBY,'Markersize',20,'linewidth',2);
    axis([ xmin xmax  ymin ymax]);
    set (gca,'fontsize',10,'fontweight','normal','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
    xlabel('X (m)','fontweight','normal','fontsize',10);
    ylabel('Y (m)','fontweight','normal','fontsize',10);
    zlabel('Z (m)','fontweight','normal','fontsize',10);
%     title(['Current time t=',t],'fontweight','normal','fontsize',10);
    grid on;
    drawnow;
end