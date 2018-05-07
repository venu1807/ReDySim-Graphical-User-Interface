% ReDySim animate module. This module animates the system under study
% Contibutors: Dr. Suril Shah and Prof S. K. Saha @IIT Delhi
function [] = animate2(handles)
disp('------------------------------------------------------------------');
disp('Animating the simulation data');

% load statevar.dat;
% load timevar.dat;
% Y=statevar;T=timevar;

[n dof type alp a b th bt r dx dy dz m g  Icxx Icyy Iczz Icxy Icyz Iczx aj al ]=inputs();
len_sum=sum(al);
xmin=-len_sum;
xmax=len_sum;
ymin=-len_sum;
ymax=len_sum;
zmin=-len_sum;
zmax=len_sum;


% figure('Name','Animation Window','NumberTitle','off');
for i=1
%     q=Y(i,1:n);
%     dq=Y(i,n+1:2*n)';
    q=[0;0;0;0;0;0];
    dq=[0;0;0;0;0;0];
    [so sc vc tt st]=for_kine(q, dq, n, alp, a, b, th, bt, r, dx, dy, dz);
    % First three links
    B1X=[so(1,1:2)];
    B1Y=[so(2,1:2)];   
    B1Z=[so(3,1:2)]; 
    B2X=[so(1,2:3)];
    B2Y=[so(2,2:3)];   
    B2Z=[so(3,2:3)]; 
    B3X=[so(1,3:4)];
    B3Y=[so(2,3:4)];   
    B3Z=[so(3,3:4)]; 
    %Wrist
    B4X=[so(1,4:n), st(1,n)];
    B4Y=[so(2,4:n), st(2,n)];   
    B4Z=[so(3,4:n), st(3,n)]; 
%     t=T(i);
%     t=num2str(t);
    axes(handles.axes1)
    plot3(B1X,B1Y,B1Z,'.-',B2X,B2Y,B2Z,'.-',B3X,B3Y,B3Z,'.-',B4X,B4Y,B4Z,'.-','Markersize',25,'linewidth',5);
    axis([ xmin xmax  ymin ymax zmin, zmax]);
    set (gca,'fontsize',10,'fontweight','normal','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
    xlabel('X (m)','fontweight','normal','fontsize',10);
    ylabel('Y (m)','fontweight','normal','fontsize',10);
    zlabel('Z (m)','fontweight','normal','fontsize',10);
%     title(['Current time t=',t],'fontweight','normal','fontsize',10);
    %view(0,0);
    grid on;    
    drawnow;
end