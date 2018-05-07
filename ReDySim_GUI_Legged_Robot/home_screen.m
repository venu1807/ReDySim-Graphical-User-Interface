function varargout = home_screen(varargin)
% HOME_SCREEN MATLAB code for home_screen.fig
%      HOME_SCREEN, by itself, creates a new HOME_SCREEN or raises the existing
%      singleton*.
%
%      H = HOME_SCREEN returns the handle to a new HOME_SCREEN or the handle to
%      the existing singleton*.
%
%      HOME_SCREEN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HOME_SCREEN.M with the given input arguments.
%
%      HOME_SCREEN('Property','Value',...) creates a new HOME_SCREEN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before home_screen_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to home_screen_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help home_screen

% Last Modified by GUIDE v2.5 22-Apr-2018 20:21:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @home_screen_OpeningFcn, ...
                   'gui_OutputFcn',  @home_screen_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

function read_file_table(handles)

    [system_type, analysis_type] = inflate_available_examples1(handles);
    cd(system_type);
    cd(analysis_type);
%     [n dof type alp a b bt dx dy dz m g  Icxx Icyy Iczz Icxy Icyz Iczx aj al]=inputs();
%     [n dof type alp a b th bt r dx dy dz m g  Icxx Icyy Iczz Icxy Icyz Iczx aj al Tp steps]=inputs();
    [n nq alp a b bt dx dy dz al alt m g  Icxx Icyy Iczz Icxy Icyz Iczx g_prop ]=inputs();   
    cd ..;
    cd ..;
    
    handles.n = n;
    handles.nq = nq;
%     handles.type = type;
    handles.g = g;
%     handles.Tp = Tp;
%     handles.steps = steps;
    handles.table_data1 = [alp, a, b, bt, dx, dy, dz, m, Icxx, Icyy, Iczz, Icxy, Icyz, Iczx, alt];
    handles.table_data2 = [ al ];
    handles.table_data3 = [ g_prop ];
    handles.table_columns1 = {'alp', 'a', 'b', 'bt', 'dx', 'dy', 'dz', 'm', 'Icxx', 'Icyy', 'Iczz', 'Icxy', 'Icyz', 'Iczx', 'alt'};
    handles.table_columns2 = {'al'};
    handles.table_columns3 = {'g_prop'};
    set(handles.uitable1,'data',handles.table_data1,'ColumnName',handles.table_columns1);
    set(handles.uitable3,'data',handles.table_data2,'ColumnName',handles.table_columns2);
    set(handles.uitable4,'data',handles.table_data3,'ColumnName',handles.table_columns3);
    
    
    set(handles.edit_gx,'string',handles.g(1));
    set(handles.edit_gy,'string',handles.g(2));
    set(handles.edit_gz,'string',handles.g(3));
    set(handles.edit_nq,'string',handles.nq);
    set(handles.edit_n,'string',handles.n);
%     set(handles.edit_type,'string',handles.type);

function write_input_file(handles)
    [system_type, analysis_type] = inflate_available_examples1(handles);
    cd(system_type);
    cd (analysis_type);
    inputs_file =  matfile('inputs.mat','Writable',true);
    cd ..
    cd ..
    nq = get(handles.edit_nq, 'string');
    gx = get(handles.edit_gx, 'string');
    gy = get(handles.edit_gy, 'string');
    gz = get(handles.edit_gz, 'string');
   
    [nq, status] = str2num(nq);
    if status==0 || nq < 0
        nq = 1;
    end
    
    [gx, status] = str2num(gx);
    if status==0
        gx = 0;
    end
    
    [gy, status] = str2num(gy);
    if status==0
        gy = 0;
    end
    
    [gz, status] = str2num(gz);
    if status==0
        gz = 0;
    end
    
    tableData1 = get(handles.uitable1, 'data');
    tableData2 = get(handles.uitable3, 'data');
    tableData3 = get(handles.uitable4, 'data');
    %[alp, a, b, bt, dx, dy, dz, m, Icxx, Icyy, Iczz, Icxy, Icyz, Iczx, aj, al]
    inputs_file.alp = tableData1(:,1);
    inputs_file.a = tableData1(:,2);
    inputs_file.b = tableData1(:,3);
%     inputs_file.th = tableData1(:,4); 
    inputs_file.bt = tableData1(:,4);
%     inputs_file.r = tableData1(:,6);
    inputs_file.dx = tableData1(:,5);
    inputs_file.dy = tableData1(:,6);
    inputs_file.dz = tableData1(:,7);
    inputs_file.m = tableData1(:,8);
    inputs_file.Icxx = tableData1(:,9);
    inputs_file.Icyy = tableData1(:,10);
    inputs_file.Iczz = tableData1(:,11);
    inputs_file.Icxy = tableData1(:,12);
    inputs_file.Icyz = tableData1(:,13);
    inputs_file.Iczx = tableData1(:,14);
    inputs_file.alt = tableData1(:,15);
    inputs_file.al = tableData2(:,1);
    inputs_file.g_prop = tableData3(:,1);
    
    inputs_file.nq = nq;
    inputs_file.gx = gx;
    inputs_file.gy = gy;
    inputs_file.gz = gz;
%     inputs_file.Tp = Tp;
%     inputs_file.steps = steps;

% --- Executes just before home_screen is made visible.

function Save_input_file(handles)
    [system_type, analysis_type] = inflate_available_examples1(handles);
    cd(system_type);
    cd (analysis_type);
    inputs_file =  matfile('inputs.mat','Writable',true);
    cd ..
    cd ..
    nq = get(handles.edit_nq, 'string');
    gx = get(handles.edit_gx, 'string');
    gy = get(handles.edit_gy, 'string');
    gz = get(handles.edit_gz, 'string');
    n = get(handles.edit_n , 'string');
    
    [n, status] = str2num(n);
    if status==0
        n = 0;
    end
    
    [nq, status] = str2num(nq);
    if status==0 || nq < 0
        nq = 1;
    end
    
    [gx, status] = str2num(gx);
    if status==0
        gx = 0;
    end
    
    [gy, status] = str2num(gy);
    if status==0
        gy = 0;
    end
    
    [gz, status] = str2num(gz);
    if status==0
        gz = 0;
    end
    
    tableData1 = get(handles.uitable1, 'data');
    tableData2 = get(handles.uitable3, 'data');
    tableData3 = get(handles.uitable4, 'data');
    %[alp, a, b, bt, dx, dy, dz, m, Icxx, Icyy, Iczz, Icxy, Icyz, Iczx, aj, al]
    alp = tableData1(:,1);
    a = tableData1(:,2);
    b = tableData1(:,3);
%     inputs_file.th = tableData1(:,4); 
    bt = tableData1(:,4);
%     inputs_file.r = tableData1(:,6);
    dx = tableData1(:,5);
    dy = tableData1(:,6);
    dz = tableData1(:,7);
    m = tableData1(:,8);
    Icxx = tableData1(:,9);
    Icyy = tableData1(:,10);
    Iczz = tableData1(:,11);
    Icxy = tableData1(:,12);
    Icyz = tableData1(:,13);
    Iczx = tableData1(:,14);
    alt = tableData1(:,15);
    al = tableData2(:,1);
    g_prop = tableData3(:,1);
    
    nq = nq;
    gx = gx;
    gy = gy;
    gz = gz;
    n = n;
    Tp = 10;
    steps = 0.01;
    g=[gx;gy;gz];
    
    uisave({'n', 'nq', 'alp', 'a', 'b', 'bt', 'dx', 'dy', 'dz', 'al', 'alt', 'm', 'g',  'Icxx', 'Icyy', 'Iczz', 'Icxy', 'Icyz', 'Iczx', 'g_prop'},'inputs');
%     save inputs.mat n nq alp a b bt dx dy dz al alt m g  Icxx Icyy Iczz Icxy Icyz Iczx g_prop
    

function [system_type, analysis_type] = inflate_available_examples1(handles)

% selectedIndex = get(handles.popupmenu1, 'value');
system_type = 'ReDySim_Legged-robot';
%  analysis_type = 'InvDyn';


% if selectedIndex  == 1
%     system_type = 'ReDySim_Fixed-base_V2';
% end
% if selectedIndex == 2
%     system_type = 'ReDySim_Fixed-base_V1';
% end
% if selectedIndex == 1
%     system_type = 'ReDySim_Flaoting-base';
% end
% if selectedIndex == 1
%     system_type = 'ReDySim_Legged-robot';
% end
% if selectedIndex == 5
%     system_type = 'ReDysim_Symbolic';
% end

% selectedIndex2 = get(handles.popupmenu4, 'value');
% % system_type = 'ReDySim_Fixed-base_V2';
% analysis_type = 'ForDyn';
% 
% if selectedIndex2  == 1
%     analysis_type = 'ForDyn';
% end
% if selectedIndex2  == 2
%     analysis_type1 = 'InvDyn';
% end

[analysis_type1] = inflate_available_examples2(handles);
analysis_type =analysis_type1;
% selection = get(handles.uibuttongroup1, 'SelectedObject');
% selection = get(selection, 'String');

% if selection == 'Inverse Dynamics'
%     analysis_type = 'InvDyn';
% else
%     analysis_type = 'ForDyn';
% end

% handles.analysis_type = analysis_type;
% handles.system_type = system_type;
% files = dir(fullfile(pwd, handles.system_type, handles.analysis_type) ) ;
% dir_flags = [files.isdir];
% files = files(dir_flags);
% files = files(3:size(files));
% set(handles.popupmenu2,'string',{files.name});

function [analysis_type1] = inflate_available_examples2(handles)
% selectedIndex1 = get(handles.popupmenu1, 'value');
system_type = 'ReDySim_Legged-robot';
%  analysis_type = 'InvDyn';


% if selectedIndex1  == 1
%     system_type = 'ReDySim_Fixed-base_V2';
% end
% if selectedIndex1 == 2
%     system_type = 'ReDySim_Fixed-base_V1';
% end
% if selectedIndex1 == 1
%     system_type = 'ReDySim_Flaoting-base';
% end
% if selectedIndex1 == 1
%     system_type = 'ReDySim_Legged-robot';
% end
% if selectedIndex1 == 5
%     system_type = 'ReDysim_Symbolic';
% end

selectedIndex2 = get(handles.popupmenu4, 'Value');
% system_type = 'ReDySim_Fixed-base_V2';
analysis_type1 = 'ForDyn';

if selectedIndex2  == 1
    analysis_type1 = 'ForDyn';
    %   cd(analysis_type1)
    set(handles.popupmenu6, 'visible', 'off');
    set(handles.popupmenu5, 'visible', 'on');
end
if selectedIndex2  == 2
    analysis_type1 = 'InvDyn';
    set(handles.popupmenu5, 'visible', 'off');
    set(handles.popupmenu6, 'visible', 'on');
   
end

% if selectedIndex == 3
%     system_type = 'ReDySim_Flaoting-base';
% end
% if selectedIndex == 4
%     system_type = 'ReDySim_Legged-robot';
% end
% if selectedIndex == 5
%     system_type = 'ReDysim_Symbolic';
% end
    
% selection = get(handles.uibuttongroup1, 'SelectedObject');
% selection = get(selection, 'String');

% if selection == 'Inverse Dynamics'
%     analysis_type = 'InvDyn';
% else
%     analysis_type = 'ForDyn';
% end

% handles.analysis_type = analysis_type;
% handles.system_type = system_type;
% 
% files = dir(fullfile(pwd, handles.system_type, handles.analysis_type) ) ;
% dir_flags = [files.isdir];
% files = files(dir_flags);
% files = files(3:size(files));
% set(handles.popupmenu2,'string',{files.name});

handles.system_type = system_type;
handles.analysis_type = analysis_type1;
files = dir(fullfile(pwd, handles.system_type, handles.analysis_type) ) ;
dir_flags = [files.isdir];
files = files(dir_flags);
files = files(3:size(files));
set(handles.popupmenu2,'string',{files.name});


function copy_file(handles,  name, folder)
    [system_type, analysis_type] = inflate_available_examples1(handles);
    
    source = fullfile(pwd, system_type, analysis_type, folder, name);
    dest = fullfile(pwd, system_type, analysis_type, name);
 	
    if exist(source, 'file') == 2
        copyfile (source, dest);
    end
    
    
function load_input(handles)
example_names = get(handles.popupmenu2, 'String');
selected_example = example_names(get(handles.popupmenu2, 'value'));
selected_example = selected_example{1};


% name = 'inputs.m';
    [system_type, analysis_type] = inflate_available_examples1(handles);
    cd (system_type);
    cd (analysis_type);
    cd (selected_example);

%    [n dof type alp a b bt dx dy dz m g  Icxx Icyy Iczz Icxy Icyz Iczx aj al]=inputs();
%      [n dof type alp a b th bt r dx dy dz m g  Icxx Icyy Iczz Icxy Icyz Iczx aj al Tp steps]=inputs()
    [n nq alp a b bt dx dy dz al alt m g  Icxx Icyy Iczz Icxy Icyz Iczx g_prop]=inputs();
    animate2(handles);
    cd ..;
    cd ..;
    cd ..;
    
    [system_type, analysis_type] = inflate_available_examples1(handles);
     cd(system_type);
     cd (analysis_type);
    inputs_file =  matfile('inputs.mat','Writable',true);
    cd ..
    cd ..
    
    
   %[n dof type alp a b bt dx dy dz m g  Icxx Icyy Iczz Icxy Icyz Iczx aj al]=inputs();
    
    inputs_file.n = n;
    inputs_file.nq = nq;
%     inputs_file.type = type;
    inputs_file.alp = alp;
    inputs_file.a = a;
    inputs_file.b = b;
%     inputs_file.th = th;
    inputs_file.bt = bt;
%     inputs_file.r = r;
    
    inputs_file.dx = dx;
    inputs_file.dy =dy;
    inputs_file.dz = dz;
    
    inputs_file.m = m;
    inputs_file.g = g;
    
    inputs_file.alt = alt;
    inputs_file.al = al;
    
    inputs_file.Icxx = Icxx;
    inputs_file.Icxy = Icxy;
    inputs_file.Icyy = Icyy;
    
    inputs_file.Icyz = Icyz;
    inputs_file.Iczz = Iczz;
    inputs_file.Iczx = Iczx;
    inputs_file.g_prop = g_prop;
%     inputs_file.Tp = Tp;
%     inputs_file.steps = steps;
    
    read_file_table(handles);

% --- Executes on selection change in popupmenu2.

function copy_example_files(handles)

example_names = get(handles.popupmenu2, 'String');
selected_example = example_names(get(handles.popupmenu2, 'value'));
selected_example = selected_example{1};


copy_file(handles,'animate.m',selected_example);
copy_file(handles,'animate2.m',selected_example);
% copy_file(handles,'for_kine.m', selected_example);
copy_file(handles,'initials.m',selected_example);
%copy_file(handles,'inputs.m', selected_example);
% copy_file(handles,'Jacobian.m', selected_example);
% copy_file(handles,'torque.m', selected_example);
copy_file(handles,'trajectory.p', selected_example);
% copy_file(handles,'inv_kine.m', selected_example);



function plot_energy(handles)
    [system_type, analysis_type] = inflate_available_examples1(handles);
    cd (system_type);
    cd (analysis_type);
    
    load envar.dat;
    load timevar.dat;
%     a=get(handles.slider2,'value');
%     b=get(handles.slider3,'value');
    EN=envar;
    T=timevar;
    n=inputs();
%     x = plot_en;
%     cd ..
%     cd ..
%     plot (handles.axes1, x)
%     cla reset;
%     axes(handles.axes1)
%     cla reset;

    figure;
    set(0,'DefaultLineLineWidth',1.5,'DefaultLineMarkerSize',3)
    plot(T,EN(:,1),T,EN(:,2),T,EN(:,3),T,EN(:,4));
    xlabel('time (s)','FontSize',10);
    ylabel('Energy (J)','FontSize',10);
    h=legend('Potential','Kinetic','Actuator','Total');
    set(h,'Orientation','horizontal','Color', 'none','Box', 'off','Location','northoutside','fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5);
    cd ..
    cd ..     


function animate_linker(handles)
    str = 'debug';
   [system_type, analysis_type] = inflate_available_examples1(handles);
    cd (system_type);
    cd (analysis_type);
%     axes(handles.axes1)
    animate(handles);
    cd ..
    cd ..

% ReDySim sys_ode. This module contains ODE of system under study
% Contibutors: Dr. Suril Shah and Prof S. K. Saha @IIT Delhi

function [] = plot_tor(handles)
    
[system_type, analysis_type] = inflate_available_examples1(handles);
cd (system_type);
cd (analysis_type);

load tor.dat;
% load statevar.dat
load timevar.dat;
% [n dof]=inputs() ;
Y=tor;
T=timevar;
% [n, y0, ti, tf, incr, rtol, atol, int_type] = initials();
% [n, y0, ti, tf, incr, rtol, atol, int_type] = initials();
% % for i= 1:length(T)
% %     y=Y(i,:);
% %     t=T(i);
% % %     [acc(i,:), tau_d(i,:)] =sys_ode(t,y,n,tf);
% % end
% cla reset;
% axes(handles.axes1)
% cla reset;
figure;
set(0,'DefaultLineLineWidth',1.5,'DefaultLineMarkerSize',3)
plot(T,Y);
set (gca,'fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
% xlim([0 2.8])
xlabel('time (s)','FontSize',10);
ylabel('Joint torque (N.m)','FontSize',10);
% h=legend('Total');
% set(h,'Orientation','horizontal','Color', 'none','Box', 'off','Location','northoutside','fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5)
% axes(handles.axes1)
% plot(T,acc(:,n+1:2*n));
% %set (gca,'fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
% % xlim([0 2.8])
% xlabel('time (s)','FontSize',10);
% ylabel('Joint accelerations (rad/s^2)','FontSize',10);

cd ..
cd ..

function [] = plot_acc_tor(handles)
    
[system_type, analysis_type] = inflate_available_examples1(handles);
cd (system_type);
cd (analysis_type);

load statevar.dat;
load timevar.dat;
Y=statevar;
T=timevar;
% axes(handles.axes1)
% cla reset;

% [n, y0, ti, tf, incr, rtol, atol, int_type] = initials();
[n, y0, ti, tf, incr, rtol, atol, int_type] = initials();
for i= 1:length(T)
    y=Y(i,:);
    t=T(i);
    [acc(i,:), tau_d(i,:)] =sys_ode(t,y,n,tf);
end

% cla reset;
figure;
set(0,'DefaultLineLineWidth',1.5,'DefaultLineMarkerSize',3)
subplot(2,1,1);
plot(T,tau_d);
set (gca,'fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
% xlim([0 2.8])
xlabel('time (s)','FontSize',10);
ylabel('Joint torque (N.m)','FontSize',10);
% h=legend('Total');
% set(h,'Orientation','horizontal','Color', 'none','Box', 'off','Location','northoutside','fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5)
% axes(handles.axes1)
subplot(2,1,2);
plot(T,acc(:,n+1:2*n));
set (gca,'fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
% xlim([0 2.8])
xlabel('time (s)','FontSize',10);
ylabel('Joint accelerations (rad/s^2)','FontSize',10);

cd ..
cd ..



function[]=plot_motion_Inv(handles)
disp('------------------------------------------------------------------');
disp('Generating plots for joint motions');

[system_type, analysis_type] = inflate_available_examples1(handles);
cd (system_type);
cd (analysis_type);

% %PLOTTING THE RESULTS
% [n]=initials;
[n ]=inputs();
load statevar.dat;
load timevar.dat;
Y=statevar;T=timevar;

set(0,'DefaultLineLineWidth',1.5,'DefaultLineMarkerSize',3)

% axes(handles.axes1)
% cla reset;
figure;
subplot(3,1,1);
plot(T,Y(:,1:n))
set (gca,'fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
xlabel('time (s)','FontSize',10);
ylabel('Joint angles (rad)','FontSize',10);

% axes(handles.axes2)
subplot(3,1,2);
plot(T,Y(:,(n+1):(2*n)))
set (gca,'fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
xlabel('time (s)','FontSize',10);
ylabel('Joint rates (rad/s)','FontSize',10);

subplot(3,1,3);
plot(T,Y(:,(2*n+1):(3*n)))
set (gca,'fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
xlabel('time (s)','FontSize',10);
ylabel('Joint acceleration (rad/s^2)','FontSize',10);

cd ..
cd ..

function[]=plot_motion_For(handles)
disp('------------------------------------------------------------------');
disp('Generating plots for joint motions');

[system_type, analysis_type] = inflate_available_examples1(handles);
    cd (system_type);
    cd (analysis_type);

% %PLOTTING THE RESULTS
[n]=initials;
load statevar.dat;
load timevar.dat;
Y=statevar;T=timevar;

set(0,'DefaultLineLineWidth',1.5,'DefaultLineMarkerSize',3)
% cla reset;
% axes(handles.axes1)
% cla reset;
figure;
subplot(2,1,1);
plot(T,Y(:,1:n))
set (gca,'fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
xlabel('time (s)','FontSize',10);
ylabel('Joint angles (rad)','FontSize',10);

% axes(handles.axes2)
subplot(2,1,2);
plot(T,Y(:,n+1:2*n))
set (gca,'fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
xlabel('time (s)','FontSize',10);
ylabel('Joint rates (rad/s)','FontSize',10);


cd ..
cd ..


function[]=plot_Base_COM_Legged_For(handles)
disp('------------------------------------------------------------------');
disp('Generating plots for Base motions');

[system_type, analysis_type] = inflate_available_examples1(handles);
    cd (system_type);
    cd (analysis_type);

[n]=inputs();
m=n-1;
load statevar.dat;
load timevar.dat;
Y=statevar;T=timevar;
clear statevar;
clear timevar;

axes(handles.axes1)
set(0,'DefaultLineLineWidth',1.5)
% fh1=figure(1);
% set(fh1, 'color', 'white'); % sets the color to white 
% subplot(2,2,1)
plot(T,Y(:,1:3));
% set (gca,'fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
hl=legend('X_0','Y_0','Z_0');
set(hl,'Orientation','h','Color', 'none','Box', 'off','Location','best','FontAngle','italic','fontsize',10,'fontweight','normal','fontname','times new romans','linewidth',0.5)
xlabel('time(s)','FontSize',10);
ylabel('Base COM (m)','FontSize',10)
% xlim([0 1]) ;
% set(h,'FontSize',10);
% subplot(2,2,2)
% axes(handles.axes1)
% set(0,'DefaultLineLineWidth',1.5)
% 
% % xlim([0 1]) ;
% subplot(2,2,3)
% axes(handles.axes1)
% set(0,'DefaultLineLineWidth',1.5)
% 
% % xlim([0 1]) ;
% % set(h,'FontSize',10);
% subplot(2,2,4)
% axes(handles.axes1)
% set(0,'DefaultLineLineWidth',1.5)

cd ..
cd ..

function[]=plot_Base_Euler_Legged_For(handles)
disp('------------------------------------------------------------------');
disp('Generating plots for Base motions');

[system_type, analysis_type] = inflate_available_examples1(handles);
    cd (system_type);
    cd (analysis_type);

[n]=inputs();
m=n-1;
load statevar.dat;
load timevar.dat;
Y=statevar;T=timevar;
clear statevar;
clear timevar;

axes(handles.axes1)
set(0,'DefaultLineLineWidth',1.5)
plot(T,Y(:,4:6));
% axis([0 1 -100 10])
% set (gca,'fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
hl=legend('\phi_0','\theta_0','\psi_0');
set(hl,'Orientation','h','Color', 'none','Box', 'off','Location','best','FontAngle','italic','fontsize',10,'fontweight','normal','fontname','times new romans','linewidth',0.5)
xlabel('time(s)','FontSize',10);
ylabel('Euler angles (rad)','FontSize',10);
cd ..
cd ..

function[]=plot_Rate_Base_COM_Legged_For(handles)
disp('------------------------------------------------------------------');
disp('Generating plots for Base motions');

[system_type, analysis_type] = inflate_available_examples1(handles);
 cd (system_type);
 cd (analysis_type);

[n]=inputs();
m=n-1;
load statevar.dat;
load timevar.dat;
Y=statevar;T=timevar;
clear statevar;
clear timevar;

axes(handles.axes1)
set(0,'DefaultLineLineWidth',1.5)


plot(T,Y(:,7+m:9+m));
% set (gca,'fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
hl=legend('$\dot{X_0}$','$\dot{Y_0}$','$\dot{Z_0}$');
set(hl,'interpreter','latex','Orientation','h','Color', 'none','Box', 'off','Location','best','FontAngle','italic','fontsize',10,'fontweight','normal','fontname','times new romans','linewidth',0.5)
xlabel('time(s)','FontSize',10);
ylabel('Rates of Base COM (m/s)','FontSize',10)
cd ..
cd ..

function[]=plot_Rate_Base_Euler_Legged_For(handles)
disp('------------------------------------------------------------------');
disp('Generating plots for Base motions');

[system_type, analysis_type] = inflate_available_examples1(handles);
    cd (system_type);
    cd (analysis_type);

[n]=inputs();
m=n-1;
load statevar.dat;
load timevar.dat;
Y=statevar;T=timevar;
clear statevar;
clear timevar;

axes(handles.axes1)
set(0,'DefaultLineLineWidth',1.5)
plot(T,Y(:,10+m:12+m));
% axis([0 1 -100 10])
% set (gca,'fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
hl=legend('$\dot{\phi_0}$','$\dot{\theta_0}$','$\dot{\psi_0}$');
set(hl,'interpreter','latex','Orientation','h','Color', 'none','Box', 'off','Location','best','FontAngle','italic','fontsize',10,'fontweight','normal','fontname','times new romans','linewidth',0.5)
xlabel('time(s)','FontSize',10);
ylabel('Rates of Euler angles (rad/s)','FontSize',10);

cd ..
cd ..



function[]=plot_Joint_angle_Legged_For(handles)
disp('------------------------------------------------------------------');
disp('Generating plots for joint motions');

[system_type, analysis_type] = inflate_available_examples1(handles);
    cd (system_type);
    cd (analysis_type);

[n]=inputs();
m=n-1;
load statevar.dat;
load timevar.dat;
Y=statevar;T=timevar;
clear statevar;
clear timevar;

axes(handles.axes1)
set(0,'DefaultLineLineWidth',1.5)
% set(0,'DefaultLineLineWidth',1.5)
% fh = figure(2); % returns the handle to the figure object
% set(fh, 'color', 'white'); % sets the color to white 
% subplot(1,2,1)
plot(T,Y(:,7:m+6));
set (gca,'fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
l1=legend('\theta_1','\theta_2','\theta_3','\theta_4','\theta_5','\theta_6','\theta_7');
set(l1,'Orientation','h','Location','best','Color', 'none','Box', 'off','FontAngle','italic','fontsize',10,'fontweight','normal','fontname','times new romans','linewidth',0.5)
xlabel('time(s)','FontSize',10);
ylabel('Joint angle (rad)','FontSize',10);

% subplot(1,2,2)
% axes(handles.axes1)
% set(0,'DefaultLineLineWidth',1.5)

cd ..
cd ..

function[]=plot_Rate_Joint_angle_Legged_For(handles)
disp('------------------------------------------------------------------');
disp('Generating plots for joint motions');

[system_type, analysis_type] = inflate_available_examples1(handles);
    cd (system_type);
    cd (analysis_type);

[n]=inputs();
m=n-1;
load statevar.dat;
load timevar.dat;
Y=statevar;T=timevar;
clear statevar;
clear timevar;

axes(handles.axes1)
set(0,'DefaultLineLineWidth',1.5)
plot(T,Y(:,m+13:2*m+12))
% set (gca,'fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out');
l1=legend('$\dot{\theta_1}$','$\dot{\theta_2}$','$\dot{\theta_3}$','$\dot{\theta_4}$','$\dot{\theta_5}$','$\dot{\theta_6}$','$\dot{\theta_7}$');
set(l1,'interpreter','latex','Orientation','h','Location','best','Color', 'none','Box', 'off','FontAngle','italic','fontsize',10,'fontweight','normal','fontname','times new romans','linewidth',0.5)
xlabel('time(s)','FontSize',10);
ylabel('Rates of joint angle (deg/s)','FontSize',10);
cd ..
cd ..


function[]=plot_Potential_en_Legged_For(handles)
disp('------------------------------------------------------------------');
disp('Plots the Energy balance');

[system_type, analysis_type] = inflate_available_examples1(handles);
    cd (system_type);
    cd (analysis_type);

load envar.dat;
load timevar.dat;
EN=envar;T=timevar;

axes(handles.axes1)
set(0,'DefaultLineLineWidth',1.5)

% set(0,'DefaultLineLineWidth',1.5)

% fh1=figure(3);
% subplot(2,1,1)
% set(fh1, 'color', 'white'); % sets the color to white 
plot(T,EN(:,1),T,EN(:,4));
% set (gca,'fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
% title(' ENERGY BALANCE OF SIMULATION THROUGH LSIM ','FontSize',14);
xlabel('time (s)','FontSize',10);
ylabel('Energy (J)','FontSize',10);
h=legend('Potential','Total');
set(h,'Orientation','horizontal','Color', 'none','Box', 'off','Location','best','fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5)

% subplot(2,1,2)
% set(fh1, 'color', 'white'); % sets the color to white 
% axes(handles.axes1)
% set(0,'DefaultLineLineWidth',1.5)

cd ..
cd ..

function[]=plot_Kinetic_en_Legged_For(handles)
disp('------------------------------------------------------------------');
disp('Plots the Energy balance');

[system_type, analysis_type] = inflate_available_examples1(handles);
cd (system_type);
cd (analysis_type);

load envar.dat;
load timevar.dat;
EN=envar;T=timevar;

axes(handles.axes1)
set(0,'DefaultLineLineWidth',1.5)
plot(T,EN(:,2),T,EN(:,3),T,EN(:,5));
% set (gca,'fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
% title(' ENERGY BALANCE OF SIMULATION THROUGH LSIM ','FontSize',14);
xlabel('time (s)','FontSize',10);
ylabel('Energy (J)','FontSize',10);
h=legend('Kinetic','Actuator','Ground');
set(h,'Orientation','horizontal','Color', 'none','Box', 'off','Location','best','fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5)
cd ..
cd ..


function[]=plot_Rate_Base_COM_Legged_Inv(handles)
disp('------------------------------------------------------------------');
disp('Generating plots for joint motions');

[system_type, analysis_type] = inflate_available_examples1(handles);
cd (system_type);
cd (analysis_type);

[n]=inputs();
m=n-1;
load statevar.dat;
load timevar.dat;
Y=statevar;T=timevar;
clear statevar;
clear timevar;

axes(handles.axes1)
set(0,'DefaultLineLineWidth',1.5)
% set(0,'DefaultLineLineWidth',1.5)
% fh1=figure(1);
% set(fh1, 'color', 'white'); % sets the color to white 
% subplot(2,2,1)

% xlim([0 1]) ;
% set(h,'FontSize',10);
% subplot(2,2,2)
% axes(handles.axes1)
% set(0,'DefaultLineLineWidth',1.5)
% 
% % xlim([0 1]) ;
% subplot(2,2,3)
% axes(handles.axes1)
% set(0,'DefaultLineLineWidth',1.5)
plot(T,Y(:,7+m:9+m));
% set (gca,'fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
hl=legend('$\dot{X_0}$','$\dot{Y_0}$','$\dot{Z_0}$');
set(hl,'interpreter','latex','Orientation','h','Color', 'none','Box', 'off','Location','best','FontAngle','italic','fontsize',10,'fontweight','normal','fontname','times new romans','linewidth',0.5)
xlabel('time(s)','FontSize',10);
ylabel('Rates of Base COM (m/s)','FontSize',10)
% xlim([0 1]) ;
% set(h,'FontSize',10);
% subplot(2,2,4)
% axes(handles.axes1)
% set(0,'DefaultLineLineWidth',1.5)

cd ..
cd ..

function[]=plot_Base_COM_Legged_Inv(handles)
disp('------------------------------------------------------------------');
disp('Generating plots for joint motions');

[system_type, analysis_type] = inflate_available_examples1(handles);
cd (system_type);
cd (analysis_type);

[n]=inputs();
m=n-1;
load statevar.dat;
load timevar.dat;
Y=statevar;T=timevar;
clear statevar;
clear timevar;

axes(handles.axes1)
set(0,'DefaultLineLineWidth',1.5)
plot(T,Y(:,1:3));
% set (gca,'fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
hl=legend('X_0','Y_0','Z_0');
set(hl,'Orientation','h','Color', 'none','Box', 'off','Location','best','FontAngle','italic','fontsize',10,'fontweight','normal','fontname','times new romans','linewidth',0.5)
xlabel('time(s)','FontSize',10);
ylabel('Base COM (m)','FontSize',10)
cd ..
cd ..

function[]=plot_Base_Euler_Legged_Inv(handles)
disp('------------------------------------------------------------------');
disp('Generating plots for joint motions');

[system_type, analysis_type] = inflate_available_examples1(handles);
cd (system_type);
cd (analysis_type);

[n]=inputs();
m=n-1;
load statevar.dat;
load timevar.dat;
Y=statevar;T=timevar;
clear statevar;
clear timevar;

axes(handles.axes1)
set(0,'DefaultLineLineWidth',1.5)
plot(T,Y(:,4:6));
% axis([0 1 -100 10])
% set (gca,'fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
hl=legend('\phi_0','\theta_0','\psi_0');
set(hl,'Orientation','h','Color', 'none','Box', 'off','Location','best','FontAngle','italic','fontsize',10,'fontweight','normal','fontname','times new romans','linewidth',0.5)
xlabel('time(s)','FontSize',10);
ylabel('Euler angles (rad)','FontSize',10);
cd ..
cd ..

function[]=plot_Rate_Base_Euler_Legged_Inv(handles)
disp('------------------------------------------------------------------');
disp('Generating plots for joint motions');

[system_type, analysis_type] = inflate_available_examples1(handles);
cd (system_type);
cd (analysis_type);

[n]=inputs();
m=n-1;
load statevar.dat;
load timevar.dat;
Y=statevar;T=timevar;
clear statevar;
clear timevar;

axes(handles.axes1)
set(0,'DefaultLineLineWidth',1.5)

plot(T,Y(:,10+m:12+m));
% axis([0 1 -100 10])
% set (gca,'fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
hl=legend('$\dot{\phi_0}$','$\dot{\theta_0}$','$\dot{\psi_0}$');
set(hl,'interpreter','latex','Orientation','h','Color', 'none','Box', 'off','Location','best','FontAngle','italic','fontsize',10,'fontweight','normal','fontname','times new romans','linewidth',0.5)
xlabel('time(s)','FontSize',10);
ylabel('Rates of Euler angles (rad/s)','FontSize',10);
cd ..
cd ..



function[]=plot_Joint_angle_Legged_Inv(handles)
disp('------------------------------------------------------------------');
disp('Generating plots for joint motions');

[system_type, analysis_type] = inflate_available_examples1(handles);
cd (system_type);
cd (analysis_type);

[n]=inputs();
m=n-1;
load statevar.dat;
load timevar.dat;
Y=statevar;T=timevar;
clear statevar;
clear timevar;

axes(handles.axes1)
set(0,'DefaultLineLineWidth',1.5)
% fh = figure(2); % returns the handle to the figure object
% set(fh, 'color', 'white'); % sets the color to white 
% subplot(1,2,1)
plot(T,Y(:,7:m+6));
% set (gca,'fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
l1=legend('\theta_1','\theta_2','\theta_3','\theta_4','\theta_5','\theta_6','\theta_7');
set(l1,'Orientation','h','Location','best','Color', 'none','Box', 'off','FontAngle','italic','fontsize',10,'fontweight','normal','fontname','times new romans','linewidth',0.5)
xlabel('time(s)','FontSize',10);
ylabel('Joint angle (rad)','FontSize',10);

% subplot(1,2,2)
% axes(handles.axes1)
% set(0,'DefaultLineLineWidth',1.5)


cd ..
cd ..

function[]=plot_Rate_Joint_angle_Legged_Inv(handles)
disp('------------------------------------------------------------------');
disp('Generating plots for joint motions');

[system_type, analysis_type] = inflate_available_examples1(handles);
cd (system_type);
cd (analysis_type);

[n]=inputs();
m=n-1;
load statevar.dat;
load timevar.dat;
Y=statevar;T=timevar;
clear statevar;
clear timevar;

axes(handles.axes1)
set(0,'DefaultLineLineWidth',1.5)
plot(T,Y(:,m+13:2*m+12))
% set (gca,'fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out');
l1=legend('$\dot{\theta_1}$','$\dot{\theta_2}$','$\dot{\theta_3}$','$\dot{\theta_4}$','$\dot{\theta_5}$','$\dot{\theta_6}$','$\dot{\theta_7}$');
set(l1,'interpreter','latex','Orientation','h','Location','best','Color', 'none','Box', 'off','FontAngle','italic','fontsize',10,'fontweight','normal','fontname','times new romans','linewidth',0.5)
xlabel('time(s)','FontSize',10);
ylabel('Rates of joint angle (deg/s)','FontSize',10);
cd ..
cd ..



function[]=plot_tor_Legged_Inv(handles)
disp('------------------------------------------------------------------');
disp('Generating plots for joint torques');

[system_type, analysis_type] = inflate_available_examples1(handles);
cd (system_type);
cd (analysis_type);
%Plots
[n]=inputs();

load tor.dat;
load timevar.dat;
S=timevar;
tau=tor;
clear tor;
clear timevar;

axes(handles.axes1)
set(0,'DefaultLineLineWidth',1.5)
% set(0,'DefaultLineLineWidth',1.5)
% set(0,'DefaultLineLineWidth',1.5,'DefaultAxesColorOrder',[0 0 0],...
%    'DefaultAxesLineStyleOrder','-|--|:|-.', 'DefaultLineMarkerSize',1.5)
% whitebg('w') %create a figure with a white color scheme


if n-1 <= 6
%     fh1=figure(5);
%     set(fh1, 'color', 'white'); % sets the color to white
    plot(S,tau)
%     set (gca,'fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
    hl=legend('\tau_1','\tau_2','\tau_3','\tau_4','\tau_5','\tau_6','\tau_7');
    set(hl,'Orientation','h','Color', 'none','Box', 'off','Location','south','FontAngle','italic','fontsize',10,'fontweight','normal','fontname','times new romans','linewidth',0.5)
    xlabel('time(s)','FontSize',10);
    ylabel('Joint torque (Nm)','FontSize',10);
else
%     fh1=figure(5);
%     subplot(1,2,1)
%     set(fh1, 'color', 'white'); % sets the color to white
    plot(S,tau(:,1:6))
%     set (gca,'fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
    hl=legend('\tau_1','\tau_2','\tau_3','\tau_4','\tau_5','\tau_6');
    set(hl,'Orientation','h','Color', 'none','Box', 'off','Location','south','FontAngle','italic','fontsize',10,'fontweight','normal','fontname','times new romans','linewidth',0.5)
    xlabel('time(s)','FontSize',10);
    ylabel('Joint torque (Nm)','FontSize',10);
    
%     subplot(1,2,2)
%     set(fh1, 'color', 'white'); % sets the color to white
    plot(S,tau(:,7:n-1))
%     set (gca,'fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
    hl=legend('\tau_7','\tau_8','\tau_9','\tau_1_0','\tau_1_1','\tau_1_2','\tau_1_3');
    set(hl,'Orientation','h','Color', 'none','Box', 'off','Location','south','FontAngle','italic','fontsize',10,'fontweight','normal','fontname','times new romans','linewidth',0.5)
    xlabel('time(s)','FontSize',10);
    ylabel('Joint torque (Nm)','FontSize',10);    
end

cd ..
cd ..

 function[]=plot_Potential_en_Legged_Inv(handles)
disp('------------------------------------------------------------------');
disp('Plots the Energy balance');

[system_type, analysis_type] = inflate_available_examples1(handles);
cd (system_type);
cd (analysis_type);

load envar.dat;
load timevar.dat;
EN=envar;T=timevar;

axes(handles.axes1)
set(0,'DefaultLineLineWidth',1.5)

% set(0,'DefaultLineLineWidth',1.5)

% fh1=figure(3);
% subplot(2,1,1)
% set(fh1, 'color', 'white'); % sets the color to white 
plot(T,EN(:,1),T,EN(:,4));
set (gca,'fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
% title(' ENERGY BALANCE OF SIMULATION THROUGH LSIM ','FontSize',14);
xlabel('time (s)','FontSize',10);
ylabel('Energy (J)','FontSize',10);
h=legend('Potential','Total');
set(h,'Orientation','horizontal','Color', 'none','Box', 'off','Location','best','fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5)

% subplot(2,1,2)
% set(fh1, 'color', 'white'); % sets the color to white 

% axes(handles.axes1)
% set(0,'DefaultLineLineWidth',1.5)

 cd ..
 cd ..
 
function[]=plot_Kinetic_en_Legged_Inv(handles)
disp('------------------------------------------------------------------');
disp('Plots the Energy balance');

[system_type, analysis_type] = inflate_available_examples1(handles);
cd (system_type);
cd (analysis_type);

load envar.dat;
load timevar.dat;
EN=envar;T=timevar;

axes(handles.axes1)
set(0,'DefaultLineLineWidth',1.5)
plot(T,EN(:,2),T,EN(:,3),T,EN(:,5));
% set (gca,'fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
% title(' ENERGY BALANCE OF SIMULATION THROUGH LSIM ','FontSize',14);
xlabel('time (s)','FontSize',10);
ylabel('Energy (J)','FontSize',10);
h=legend('Kinetic','Actuator','Ground');
set(h,'Orientation','horizontal','Color', 'none','Box', 'off','Location','best','fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5)
cd ..
cd ..

function home_screen_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to home_screen (see VARARGIN)

% Choose default command line output for home_screen
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
%x = [1;2;3;4];
%y = [0;9;8;7];
%Data=[x,y];
%colnames = {'Voltage','Time'};
%set(handles.uitable1,'data',Data,'ColumnName',colnames);
    
    
files = dir(fullfile(pwd) ) ;
dir_flags = [files.isdir];
files = files(dir_flags);
files = files(3:size(files));

% system_type = {'Fixed Base (v-2)', 'Fixed Base (v-1)', 'Floating Base', 'Legged Robot', 'Symbolic'}
system_type = {'Legged Robot'};

% set(handles.popupmenu1,'string',system_type);

analysis_type = {'ForDyn','InvDyn'};
set(handles.popupmenu4,'string',analysis_type);

[system_type, analysis_type] = inflate_available_examples1(handles);

% inflate_available_examples1(handles);
% %load_input(handles);
% read_file_table(handles);
copy_example_files(handles);
load_input(handles);

% UIWAIT makes home_screen wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = home_screen_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_nq_Callback(hObject, eventdata, handles)
% hObject    handle to edit_nq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_nq as text
%        str2double(get(hObject,'String')) returns contents of edit_nq as a double


% --- Executes during object creation, after setting all properties.
function edit_nq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_nq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_n_Callback(hObject, eventdata, handles)

n = get(handles.edit_n, 'String');
[n, status] = str2num(n);
if status==0 || n <= 0  
    n = 1;
end
create_variable_file(n, 0);
read_file_table(handles);

% hObject    handle to edit_n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_n as text
%        str2double(get(hObject,'String')) returns contents of edit_n as a double


% --- Executes during object creation, after setting all properties.
function edit_n_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_type_Callback(hObject, eventdata, handles)
% hObject    handle to edit_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_type as text
%        str2double(get(hObject,'String')) returns contents of edit_type as a double


% --- Executes during object creation, after setting all properties.
function edit_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_gx_Callback(hObject, eventdata, handles)
% hObject    handle to edit_gx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_gx as text
%        str2double(get(hObject,'String')) returns contents of edit_gx as a double


% --- Executes during object creation, after setting all properties.
function edit_gx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_gx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_gy_Callback(hObject, eventdata, handles)
% hObject    handle to edit_gy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_gy as text
%        str2double(get(hObject,'String')) returns contents of edit_gy as a double


% --- Executes during object creation, after setting all properties.
function edit_gy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_gy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_gz_Callback(hObject, eventdata, handles)
% hObject    handle to edit_gz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_gz as text
%        str2double(get(hObject,'String')) returns contents of edit_gz as a double


% --- Executes during object creation, after setting all properties.
function edit_gz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_gz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in update_table_button.
function update_table_button_Callback(hObject, eventdata, handles)
write_input_file(handles);
[system_type, analysis_type] = inflate_available_examples1(handles);
cd(system_type);
cd(analysis_type);
animate2(handles);
cd ..
cd ..


% hObject    handle to update_table_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in reset_button.
% function reset_button_Callback(hObject, eventdata, handles)
% %     read_file_table(handles);
% load_input(handles);
% hObject    handle to reset_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
     inflate_available_examples1(handles);
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
inflate_available_examples2(handles);
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4


% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
     copy_example_files(handles);
     load_input(handles);
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in simulate_button.
function simulate_button_Callback(hObject, eventdata, handles)
% selection = get(handles.uibuttongroup2, 'SelectedObject');
% selection = get(selection, 'String')
[system_type, analysis_type] = inflate_available_examples1(handles);
simulating_popup;
pause(0.01);
cd(system_type);
cd(analysis_type);

if strcmp(analysis_type, 'InvDyn')
    clear all;
    fclose all;
    clc;
    runinv;
    energy;
%     momentum;
% if strcmp(selection, 'ForDyn')==1
else
    clear all;
    fclose all;
    clc;
    runfor;
    energy;
%     momentum;
end

cd ..
cd ..
close(simulating_popup)
% hObject    handle to simulate_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on button press in plot_button.
function plot_button_Callback(hObject, eventdata, handles)

selection = get(handles.uibuttongroup2, 'SelectedObject');
selection = get(selection, 'String')

if strcmp(selection, 'Acceleration')==1
    plot_acc_tor(handles);
end
if strcmp(selection, 'For_Trajectory')==1
    plot_motion_For(handles);
end
if strcmp(selection, 'Torque')==1
    plot_tor(handles);
end
if strcmp(selection, 'Inv_Trajectory')==1
    plot_motion_Inv(handles);
end
if strcmp(selection, 'Energy')==1
    plot_energy(handles);
end
% if strcmp(selection, 'Joint Angles')==1
%      plot_energy(handles);
% end

% animate_linker(handles)
   
% hObject    handle to plot_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in animate_button.
function animate_button_Callback(hObject, eventdata, handles)
animate_linker(handles);
% hObject    handle to animate_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit_Tp_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Tp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Tp as text
%        str2double(get(hObject,'String')) returns contents of edit_Tp as a double

Tp = get(handles.edit_Tp, 'String');
[Tp, status] = str2num(Tp);
if status==0 || Tp <= 0  
    Tp = 1;
end
create_variable_file(Tp, 0);
read_file_table(handles);

% --- Executes during object creation, after setting all properties.
function edit_Tp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Tp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_steps_Callback(hObject, eventdata, handles)
% hObject    handle to edit_steps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_steps as text
%        str2double(get(hObject,'String')) returns contents of edit_steps as a double
steps = get(handles.edit_steps, 'String');
[steps, status] = str2num(steps);
if status==0 || steps <= 0  
    steps = 1;
end
create_variable_file(steps, 0);
read_file_table(handles);


% --- Executes during object creation, after setting all properties.
function edit_steps_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_steps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=get(handles.slider2,'Value');

% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

b=get(handles.slider3,'Value');


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% % --- Executes on button press in radiobutton11.
% function radiobutton11_Callback(hObject, eventdata, handles)
% % hObject    handle to radiobutton11 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hint: get(hObject,'Value') returns toggle state of radiobutton11
% plot_tor(handles);
% 
% 
% % --- Executes during object creation, after setting all properties.
% function radiobutton11_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to radiobutton11 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% 
% % --- Executes on button press in radiobutton12.
% function radiobutton12_Callback(hObject, eventdata, handles)
% % hObject    handle to radiobutton12 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hint: get(hObject,'Value') returns toggle state of radiobutton12
% plot_motion_Inv(handles);
% 
% function radiobutton4_Callback(hObject, eventdata, handles)
% plot_acc_tor(handles);
% 
% 
% function radiobutton5_Callback(hObject, eventdata, handles)
% plot_energy(handles);
% 
% 
% function radiobutton6_Callback(hObject, eventdata, handles)
% plot_motion_For(handles);


% --- Executes on button press in radiobutton13.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton13
function radiobutton4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to radiobutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

function radiobutton5_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton13
function radiobutton5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to radiobutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

function radiobutton6_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton13
function radiobutton6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to radiobutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

function radiobutton11_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton13
function radiobutton11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to radiobutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

function radiobutton12_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton13


% --- Executes during object creation, after setting all properties.
function radiobutton12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to radiobutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on selection change in popupmenu5.
function popupmenu5_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu5
% Index = get(handles.popupmenu4, 'Value');
selectedIndex = get(handles.popupmenu5, 'Value');
% system_type = 'ReDySim_Fixed-base_V2';
% analysis_type1 = 'InvDyn';

if selectedIndex  == 1
      plot_Base_COM_Legged_For(handles);
end
if selectedIndex  == 2
      plot_Base_Euler_Legged_For(handles);
end
if selectedIndex  == 3
      plot_Rate_Base_COM_Legged_For(handles);
end
if selectedIndex  == 4
      plot_Rate_Base_Euler_Legged_For(handles);
end
if selectedIndex  == 5
      plot_Joint_angle_Legged_For(handles);
end
if selectedIndex  == 6
      plot_Rate_Joint_angle_Legged_For(handles);
end
if selectedIndex  == 7
      plot_Potential_en_Legged_For(handles); 
end
if selectedIndex  == 8
      plot_Kinetic_en_Legged_For(handles); 
end


   
% --- Executes during object creation, after setting all properties.
function popupmenu5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu6.
function popupmenu6_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu6 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu6
selectedIndex = get(handles.popupmenu6, 'Value');
if selectedIndex  == 1
      plot_Base_COM_Legged_Inv(handles);
end
if selectedIndex  == 2
      plot_Base_Euler_Legged_Inv(handles);
end
if selectedIndex  == 3
      plot_Rate_Base_COM_Legged_Inv(handles);
end
if selectedIndex  == 4
      plot_Rate_Base_Euler_Legged_Inv(handles);
end
if selectedIndex  == 5
      plot_Joint_angle_Legged_Inv(handles);
end
if selectedIndex  == 6
      plot_Rate_Joint_angle_Legged_Inv(handles);
end
if selectedIndex  == 7
      plot_tor_Legged_Inv(handles);
end
if selectedIndex  == 8
      plot_Potential_en_Legged_Inv(handles); 
end
if selectedIndex  == 9
      plot_Kinetic_en_Legged_Inv(handles); 
end



% --- Executes during object creation, after setting all properties.
function popupmenu6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Exit_GUI.
function Exit_GUI_Callback(hObject, eventdata, handles)
% hObject    handle to Exit_GUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(home_screen)
cd ..


% --- Executes on button press in save_push_button.
function save_push_button_Callback(hObject, eventdata, handles)
% hObject    handle to save_push_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Save_input_file(handles)


% --- Executes on button press in Load_push_button.
function Load_push_button_Callback(hObject, eventdata, handles)
% hObject    handle to Load_push_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file, path] = uigetfile({'*.m';'*.slx';'*.mat';'*.*'},'File Selector');

Source_To_Destination(handles, file , path);
copy_input_example_files(handles);
load_input(handles);

function Source_To_Destination(handles, file , path)
    [system_type, analysis_type] = inflate_available_examples1(handles);
    
    source = fullfile(path, file);
    dest = fullfile(pwd, system_type);
    cd .
    dest2= pwd;
    copyfile (source, dest2);

function copy_input_file(handles,  name, folder)
    [system_type, analysis_type] = inflate_available_examples1(handles);
    
    source = fullfile(pwd, name);
    dest = fullfile(pwd, system_type, analysis_type, folder, name);
 	
    if exist(source, 'file') == 2
        copyfile (source, dest);
    end
   
function copy_input_example_files(handles)

example_names = get(handles.popupmenu2, 'String');
selected_example = example_names(get(handles.popupmenu2, 'value'));
selected_example = selected_example{1};


copy_input_file(handles,'inputs.mat',selected_example);
% copy_file(handles,'animate2.m',selected_example);
% copy_file(handles,'for_kine.m', selected_example);
% copy_file(handles,'initials.m',selected_example);
% copy_file(handles,'inputs2.m', selected_example);
% copy_file(handles,'Jacobian.m', selected_example);
% copy_file(handles,'torque.m', selected_example);
% copy_file(handles,'trajectory.m', selected_example);
% copy_file(handles,'inv_kine.m', selected_example);

% read_file_table(handles);
% schematic(handles)

function reset_button_Callback(hObject, eventdata, handles)
% read_file_table(handles);
copy_default_input_example_files(handles);
load_input(handles);


function copy_default_input_file(handles,  name, folder)
    [system_type, analysis_type] = inflate_available_examples1(handles);
    
    source = fullfile(pwd,system_type, analysis_type, folder,'default_input', name);
    dest = fullfile(pwd, system_type, analysis_type, folder, name);
 	
    if exist(source, 'file') == 2
        copyfile (source, dest);
    end
   
function copy_default_input_example_files(handles)

example_names = get(handles.popupmenu2, 'String');
selected_example = example_names(get(handles.popupmenu2, 'value'));
selected_example = selected_example{1};


copy_default_input_file(handles,'inputs.mat',selected_example);