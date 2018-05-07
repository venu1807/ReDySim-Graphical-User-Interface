% ReDySim animate module. This module animates the system under study
% Contibutors: Dr. Suril Shah and Prof S. K. Saha @IIT Delhi
function [] = animate(handles)
disp('------------------------------------------------------------------');
disp('Animating the simulation data');

load statevar.dat;
load timevar.dat;
Y=statevar;T=timevar;

[n dof type alp a b th bt r dx dy dz m g  Icxx Icyy Iczz Icxy Icyz Iczx aj al ]=inputs();
len_sum=sum(al);
xmin=-len_sum;
xmax=len_sum;
ymin=-len_sum;
ymax=len_sum;
zmin=-len_sum;
zmax=len_sum;


% figure('Name','Animation Window','NumberTitle','off');
for i=1:length(T)
    q=Y(i,1:n);
    dq=Y(i,n+1:2*n)';
    [so sc vc tt st ]=for_kine(q, dq,n, alp, a, b, th, bt, r, dx, dy, dz);
    B1X=[0 so(1,1:n), st(1,n)];
    B1Y=[0 so(2,1:n), st(2,n)];
    B1Z=[0 so(3,1:n), st(3,n)]; 
    t=T(i);
    t=num2str(t);
    axes(handles.axes1)
    plot3(B1X,B1Y,B1Z,'.-','Markersize',23,'linewidth',4);
    axis([ xmin xmax  ymin ymax zmin zmax]);
    set (gca,'fontsize',10,'fontweight','normal','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
    xlabel('X (m)','fontweight','normal','fontsize',10);
    ylabel('Y (m)','fontweight','normal','fontsize',10);
    zlabel('Z (m)','fontweight','normal','fontsize',10);
    title(['Current time t=',t],'fontweight','normal','fontsize',10);
    grid on;    
    drawnow;
end