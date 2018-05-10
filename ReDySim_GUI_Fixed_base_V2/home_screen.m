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

% Last Modified by GUIDE v2.5 10-May-2018 10:56:15

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
%   cd(get(handles.popupmenu2,'String')); 
%   [n dof type alp a b bt dx dy dz m g  Icxx Icyy Iczz Icxy Icyz Iczx aj al]=inputs();
%   animate2(handles);
    [n dof type alp a b th bt r dx dy dz m g  Icxx Icyy Iczz Icxy Icyz Iczx aj al Tp steps]=inputs();
%     animate2(handles);
%     animate2;
    cd ..;
    cd ..;
    
    handles.n = n;
    handles.dof = dof;
    handles.type = type;
    handles.g = g;
    handles.Tp = Tp;
    handles.steps = steps;
    handles.table_data2 = [ al ];
    handles.table_data1 = [alp, a, b, th, bt, r, dx, dy, dz, m, Icxx, Icyy, Iczz, Icxy, Icyz, Iczx, aj];
    handles.table_columns2 = {'al'};
    handles.table_columns1 = {'alp', 'a', 'b','th', 'bt','r', 'dx', 'dy', 'dz', 'm', 'Icxx', 'Icyy', 'Iczz', 'Icxy', 'Icyz', 'Iczx', 'aj'};
    set(handles.uitable3,'data',handles.table_data2,'ColumnName',handles.table_columns2);
    set(handles.uitable1,'data',handles.table_data1,'ColumnName',handles.table_columns1);
    set(handles.edit_gx,'string',handles.g(1));
    set(handles.edit_gy,'string',handles.g(2));
    set(handles.edit_gz,'string',handles.g(3));
    set(handles.edit_dof,'string',handles.dof);
    set(handles.edit_n,'string',handles.n);
    set(handles.edit_type,'string',handles.type);
    set(handles.edit_Tp,'string',handles.Tp);
    set(handles.edit_steps,'string',handles.steps);
    
%     [system_type, analysis_type] = inflate_available_examples1(handles);
%     cd(system_type);
%     cd(analysis_type);
%     animate2(handles);
%     cd ..
%     cd ..
    
    
function write_input_file(handles)
    [system_type, analysis_type] = inflate_available_examples1(handles);
    cd(system_type);
    cd(analysis_type);
%     copy_example_files(handles)

    inputs_file =  matfile('inputs.mat','Writable',true);
%     animate2(handles);
    cd ..
    cd ..
    
    dof = get(handles.edit_dof, 'string');
    gx = get(handles.edit_gx, 'string');
    gy = get(handles.edit_gy, 'string');
    gz = get(handles.edit_gz, 'string');
    n = get(handles.edit_n, 'string');
    Tp = get(handles.edit_Tp, 'string');
    steps = get(handles.edit_steps, 'string');
   
    [dof, status] = str2num(dof);
    if status==0 || dof < 0
        dof = 1;
    end
    
    [n, status] = str2num(n);
    if status==0 || n < 0
        n = 0;
    end
    
    [Tp, status] = str2num(Tp);
    if status==0 || Tp < 0
        Tp = 0;
    end
    
    [steps, status] = str2num(steps);
    if status==0 || steps < 0
        steps = 0;
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
    %[alp, a, b, bt, dx, dy, dz, m, Icxx, Icyy, Iczz, Icxy, Icyz, Iczx, aj, al]
    inputs_file.alp = tableData1(:,1);
    inputs_file.a = tableData1(:,2);
    inputs_file.b = tableData1(:,3);
    inputs_file.th = tableData1(:,4); 
    inputs_file.bt = tableData1(:,5);
    inputs_file.r = tableData1(:,6);
    inputs_file.dx = tableData1(:,7);
    inputs_file.dy = tableData1(:,8);
    inputs_file.dz = tableData1(:,9);
    inputs_file.m = tableData1(:,10);
    inputs_file.Icxx = tableData1(:,11);
    inputs_file.Icyy = tableData1(:,12);
    inputs_file.Iczz = tableData1(:,13);
    inputs_file.Icxy = tableData1(:,14);
    inputs_file.Icyz = tableData1(:,15);
    inputs_file.Iczx = tableData1(:,16);
    inputs_file.aj = tableData1(:,17);
    inputs_file.al = tableData2(:,1);
    
    inputs_file.dof = dof;
    inputs_file.gx = gx;
    inputs_file.gy = gy;
    inputs_file.gz = gz;
    inputs_file.n = n;
    inputs_file.Tp = Tp;
    inputs_file.steps = steps;
   
   

% --- Executes just before home_screen is made visible.
function Save_input_file(handles)
[system_type, analysis_type] = inflate_available_examples1(handles);
    cd(system_type);
    cd(analysis_type);
%     copy_example_files(handles)

    inputs_file =  matfile('inputs.mat','Writable',true);
%     animate2(handles);
    cd ..
    cd ..
    
    dof = get(handles.edit_dof, 'string');
    gx = get(handles.edit_gx, 'string');
    gy = get(handles.edit_gy, 'string');
    gz = get(handles.edit_gz, 'string');
    n = get(handles.edit_n , 'string');
    Tp = get(handles.edit_Tp , 'string');
    steps = get(handles.edit_steps , 'string');
    type = get(handles.edit_type,'string');
    
    [dof, status] = str2num(dof);
    if status==0 || dof < 0
        dof = 1;
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
    
    [n, status] = str2num(n);
    if status==0
        n = 0;
    end
    
    [Tp, status] = str2num(Tp);
    if status==0
        Tp = 0;
    end
    
    [steps, status] = str2num(steps);
    if status==0
        steps = 0;
    end
    
    [type, status] = str2num(type);
    if status==0
        type = 0;
    end
    
    tableData1 = get(handles.uitable1, 'data');
    tableData2 = get(handles.uitable3, 'data');
    %[alp, a, b, bt, dx, dy, dz, m, Icxx, Icyy, Iczz, Icxy, Icyz, Iczx, aj, al]
   alp = tableData1(:,1);
   a = tableData1(:,2);
   b = tableData1(:,3);
   th = tableData1(:,4); 
   bt = tableData1(:,5);
   r = tableData1(:,6);
   dx = tableData1(:,7);
   dy = tableData1(:,8);
   dz = tableData1(:,9);
   m = tableData1(:,10);
   Icxx = tableData1(:,11);
   Icyy = tableData1(:,12);
   Iczz = tableData1(:,13);
   Icxy = tableData1(:,14);
   Icyz = tableData1(:,15);
   Iczx = tableData1(:,16);
   aj = tableData1(:,17);
   al = tableData2(:,1);
    
   dof = dof;
   gx = gx;
   gy = gy;
   gz = gz;
   n = n;
   type = type;
   Tp = Tp;
   steps = steps;
   
   g=[gx;gy;gz];
   
   uisave({'alp','n','a','b', 'type', 'th', 'bt', 'r', 'dx', 'dy', 'dz', 'm' ,'g' ,'Icxx', 'Icyy' ,'Iczz', 'Icxy', 'Icyz', 'Iczx', 'aj', 'al', 'dof', 'Tp', 'steps'},'inputs')
   
%    save inputs.mat alp n a b type th bt r dx dy dz m g Icxx Icyy Iczz Icxy Icyz Iczx  aj al dof Tp steps
                  
function [system_type, analysis_type] = inflate_available_examples1(handles)

% selectedIndex = get(handles.popupmenu1, 'value');
system_type = 'ReDySim_Fixed-base_V2';
%  analysis_type = 'InvDyn';

% if selectedIndex  == 1
%     system_type = 'ReDySim_Fixed-base_V2';
% end


% if selectedIndex == 2
%     system_type = 'ReDySim_Fixed-base_V1';
% end
% if selectedIndex == 3
%     system_type = 'ReDySim_Flaoting-base';
% end
% if selectedIndex == 4
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
analysis_type = analysis_type1;
% selection = get(handles.uibuttongroup1, 'SelectedObject');
% selection = get(selection, 'String');

% if selection == 'Inverse Dynamics'
%     analysis_type = 'InvDyn';
% else
%     analysis_type = 'ForDyn';
% end

% handles.system_type = system_type;
% handles.analysis_type = analysis_type;
% files = dir(fullfile(pwd, handles.system_type, handles.analysis_type)); % cretes full path to the folder
% % files = dir(fullfile(pwd, handles.analysis_type));
% dir_flags = [files.isdir]; %gives confirmation for folder and file in the directory
% files = files(dir_flags);
% files = files(3:size(files));
% set(handles.popupmenu2,'string',{files.name});

function [analysis_type1] = inflate_available_examples2(handles)
% selectedIndex1 = get(handles.popupmenu1, 'value');
 system_type = 'ReDySim_Fixed-base_V2';
%  analysis_type = 'InvDyn';

% if selectedIndex1  == 1
%     system_type = 'ReDySim_Fixed-base_V2';
% end

% if selectedIndex1 == 2
%     system_type = 'ReDySim_Fixed-base_V1';
% end
% if selectedIndex1 == 3
%     system_type = 'ReDySim_Flaoting-base';
% end
% if selectedIndex1 == 4
%     system_type = 'ReDySim_Legged-robot';
% end
% if selectedIndex1 == 5
%     system_type = 'ReDysim_Symbolic';
% end

selectedIndex2 = get(handles.popupmenu4, 'Value');
% system_type = 'ReDySim_Fixed-base_V2';
analysis_type1 = 'InvDyn';

if selectedIndex2  == 1
    analysis_type1 = 'ForDyn';
    set(handles.popupmenu6, 'visible', 'off');
    set(handles.popupmenu5, 'visible', 'on');
    %   cd(analysis_type1)
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
files = dir(fullfile(pwd, handles.system_type, handles.analysis_type)); % cretes full path to the folder
% files = dir(fullfile(pwd, handles.analysis_type));
dir_flags = [files.isdir]; %gives confirmation for folder and file in the directory
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
   
function copy_example_files(handles)

example_names = get(handles.popupmenu2, 'String');
selected_example = example_names(get(handles.popupmenu2, 'value'));
selected_example = selected_example{1};


copy_file(handles,'animate.m',selected_example);
copy_file(handles,'animate2.m',selected_example);
copy_file(handles,'for_kine.m', selected_example);
copy_file(handles,'initials.m',selected_example);
copy_file(handles,'inputs2.m', selected_example);
copy_file(handles,'Jacobian.m', selected_example);
copy_file(handles,'torque.m', selected_example);
copy_file(handles,'trajectory.m', selected_example);
copy_file(handles,'inv_kine.m', selected_example);

% read_file_table(handles);
% schematic(handles)
    
function load_input(handles)
example_names = get(handles.popupmenu2, 'String');
selected_example = example_names(get(handles.popupmenu2, 'value'));
selected_example = selected_example{1};


% 
% name = 'inputs.m';
    [system_type, analysis_type] = inflate_available_examples1(handles);
    cd (system_type);
    cd (analysis_type);
    cd (selected_example);

%    [n dof type alp a b bt dx dy dz m g  Icxx Icyy Iczz Icxy Icyz Iczx aj al]=inputs();
%     load inputs.mat
    [n dof type alp a b th bt r dx dy dz m g  Icxx Icyy Iczz Icxy Icyz Iczx aj al Tp steps]=inputs();
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
    inputs_file.dof = dof;
    inputs_file.type = type;
    inputs_file.alp = alp;
    inputs_file.a = a;
    inputs_file.b = b;
    inputs_file.th = th;
    inputs_file.bt = bt;
    inputs_file.r = r;
    inputs_file.dx = dx;
    inputs_file.dy =dy;
    inputs_file.dz = dz;
    inputs_file.m = m;
    inputs_file.g = g;
    inputs_file.aj = aj;
    inputs_file.al = al;
    inputs_file.Icxx = Icxx;
    inputs_file.Icxy = Icxy;
    inputs_file.Icyy = Icyy;
    inputs_file.Icyz = Icyz;
    inputs_file.Iczz = Iczz;
    inputs_file.Iczx = Iczx;
    inputs_file.Tp = Tp;
    inputs_file.steps = steps;
    
    read_file_table(handles);
    
%     schematic(handles);

% --- Executes on selection change in popupmenu2.


function schematic(handles)
 [system_type, analysis_type] = inflate_available_examples1(handles);
 cd(system_type);
 cd(analysis_type);
 animate2(handles);
 cd ..
 cd ..
 
function animate_linker(handles)
    str = 'debug';
    [system_type, analysis_type] = inflate_available_examples1(handles);
    cd (system_type);
    cd (analysis_type);
%   axes(handles.axes1)
    animate(handles);
    cd ..
    cd ..

% ReDySim sys_ode. This module contains ODE of system under study
% Contibutors: Dr. Suril Shah and Prof S. K. Saha @IIT Delhi

function[]= plot_energy_Fixed_V2_For(handles)
    [system_type, analysis_type] = inflate_available_examples1(handles);
    cd (system_type);
    cd (analysis_type);
    
    load envar.dat;
    load timevar.dat;
    EN=envar;
    T=timevar;
    n=inputs();
    axes(handles.axes1)

    set(0,'DefaultLineLineWidth',1.5,'DefaultLineMarkerSize',3);
    plot(T,EN(:,1),T,EN(:,2),T,EN(:,3),T,EN(:,4));
    xlabel('time (s)','FontSize',10);
    ylabel('Energy (J)','FontSize',10);
    h=legend('Potential','Kinetic','Actuator','Total');
    set(h,'Orientation','horizontal','Color', 'none','Box', 'off','Location','northoutside','fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5);
    cd ..
    cd ..     

function [] = plot_tor_Fixed_V2_For(handles)
    
[system_type, analysis_type] = inflate_available_examples1(handles);
cd (system_type);
cd (analysis_type);

load statevar.dat;
load timevar.dat;
Y=statevar;
T=timevar;
axes(handles.axes1)


[n, y0, ti, tf, incr, rtol, atol, int_type] = initials();
for i= 1:length(T)
    y=Y(i,:);
    t=T(i);
    [acc(i,:), tau_d(i,:)] =sys_ode(t,y,n,tf);
end


set(0,'DefaultLineLineWidth',1.5,'DefaultLineMarkerSize',3);
% subplot(2,1,1);
plot(T,tau_d);
% set (gca,'fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
% xlim([0 2.8])
h=legend('\tau_1','\tau_2','\tau_3','\tau_4','\tau_5','\tau_6','\tau_7','\tau_8','\tau_9','\tau_{10}','\tau_{11}','\tau_{12}','\tau_{13}','\tau_{14}','\tau_{15}','\tau_{16}','\tau_{17}','\tau_{18}','\tau_{19}','\tau_{20}');
set(h,'Orientation','v','Color', 'none','Box', 'off','Location','northeast','FontAngle','italic','fontsize',10,'fontweight','normal','fontname','times new romans','linewidth',0.5)
% for i=1:12
%     gKey{i}=sprintf('trace %d',i);
% end
% gridLegend(h,12,'location','westoutside','Fontsize',8,'Box','off','XColor',[1 1 1],'YColor',[1 1 1])
% h=legend('Joint Torque');
% set(h,'Orientation','horizontal','Color', 'none','Box', 'off','Location','northoutside','fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5);
xlabel('time (s)','FontSize',10);
ylabel('Joint torque (N.m)','FontSize',10);


% set(h,'Orientation','horizontal','Color', 'none','Box', 'off','Location','northoutside','fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5)
% axes(handles.axes1)
% subplot(2,1,2);
% plot(T,acc(:,n+1:2*n));
% set (gca,'fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
% % xlim([0 2.8])
% xlabel('time (s)','FontSize',10);
% ylabel('Joint accelerations (rad/s^2)','FontSize',10);

cd ..
cd ..

function [] = plot_acc_Fixed_V2_For(handles)
    
[system_type, analysis_type] = inflate_available_examples1(handles);
cd (system_type);
cd (analysis_type);

load statevar.dat;
load timevar.dat;
Y=statevar;
T=timevar;
axes(handles.axes1)


[n, y0, ti, tf, incr, rtol, atol, int_type] = initials();
for i= 1:length(T)
    y=Y(i,:);
    t=T(i);
    [acc(i,:), tau_d(i,:)] =sys_ode(t,y,n,tf);
end


set(0,'DefaultLineLineWidth',1.5,'DefaultLineMarkerSize',3);
% subplot(2,1,1);
% plot(T,tau_d);
% % set (gca,'fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
% % xlim([0 2.8])
% h=legend('Total');
% set(h,'Orientation','horizontal','Color', 'none','Box', 'off','Location','northoutside','fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5);
% xlabel('time (s)','FontSize',10);
% ylabel('Joint torque (N.m)','FontSize',10);


% set(h,'Orientation','horizontal','Color', 'none','Box', 'off','Location','northoutside','fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5)
% axes(handles.axes1)
% subplot(2,1,2);
plot(T,acc(:,n+1:2*n));
% set (gca,'fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
% % xlim([0 2.8])
% h=legend('Joint accelerations (rad/s^2)');
% h=columnlegend(3, cellstr(num2str([1:20]')), 'location', 'southeast');
% h=legend('$\ddot{\theta_1}$','$\ddot{\theta_2}$','$\ddot{\theta_3}$','$\ddot{\theta_4}$','$\ddot{\theta_5}$','$\ddot{\theta_6}$','$\ddot{\theta_7}$','$\ddot{\theta_8}$','$\ddot{\theta_9}$','$\ddot{\theta_{10}}$','$\ddot{\theta_{11}}$','$\ddot{\theta_{12}}$');
% h.NumColumns = 2;
h=legend('$\ddot{\theta_1}$','$\ddot{\theta_2}$','$\ddot{\theta_3}$','$\ddot{\theta_4}$','$\ddot{\theta_5}$','$\ddot{\theta_6}$','$\ddot{\theta_7}$','$\ddot{\theta_8}$','$\ddot{\theta_9}$','$\ddot{\theta_{10}}$','$\ddot{\theta_{11}}$','$\ddot{\theta_{12}}$','$\ddot{\theta_{13}}$','$\ddot{\theta_{14}}$','$\ddot{\theta_{15}}$','$\ddot{\theta_{16}}$','$\ddot{\theta_{17}}$','$\ddot{\theta_{18}}$','$\ddot{\theta_{19}}$','$\ddot{\theta_{20}}$');
set(h,'interpreter','latex','Orientation','v','Location','northeast','Color', 'none','Box', 'off','FontAngle','italic','fontsize',10,'fontweight','normal','fontname','times new romans','linewidth',0.5)
% set(h,'Orientation','horizontal','Color', 'none','Box', 'off','Location','northoutside','fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5);
xlabel('time (s)','FontSize',10);
ylabel('Joint accelerations (rad/s^2)','FontSize',10);

cd ..
cd ..


function[]=plot_motion_Joint_angles_Fixed_V2_For(handles)
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
 axes(handles.axes1)
% cla reset;
% figure;
% subplot(2,1,1);
plot(T,Y(:,1:n))
h=legend('\theta_1','\theta_2','\theta_3','\theta_4','\theta_5','\theta_6','\theta_7','\theta_8','\theta_9','\theta_{10}','\theta_{11}','\theta_{12}','\theta_{13}','\theta_{14}','\theta_{15}','\theta_{16}','\theta_{17}','\theta_{18}','\theta_{19}','\theta_{20}');
% set(h,'Orientation','h','Location','best','Color', 'none','Box', 'off','FontAngle','italic','fontsize',10,'fontweight','normal','fontname','times new romans','linewidth',0.5)
set(h,'Orientation','v','Location','northeast','Color', 'none','Box', 'off','FontAngle','italic','fontsize',10,'fontweight','normal','fontname','times new romans','linewidth',0.5)

% h=legend('Joint angles');
% set(h,'Orientation','horizontal','Color', 'none','Box', 'off','Location','northoutside','fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5)
% set (gca,'fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
xlabel('time (s)','FontSize',10);
ylabel('Joint angles (rad)','FontSize',10);

% axes(handles.axes2)
% subplot(2,1,2);
% plot(T,Y(:,n+1:2*n))
% set (gca,'fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
% xlabel('time (s)','FontSize',10);
% ylabel('Joint rates (rad/s)','FontSize',10);


cd ..
cd ..

function[]=plot_motion_Joint_rates_Fixed_V2_For(handles)
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
 axes(handles.axes1)
% cla reset;
% figure;
% subplot(2,1,1);
% plot(T,Y(:,1:n))
% h=legend('Total');
% set(h,'Orientation','horizontal','Color', 'none','Box', 'off','Location','northoutside','fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5)
% % set (gca,'fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
% xlabel('time (s)','FontSize',10);
% ylabel('Joint angles (rad)','FontSize',10);

% axes(handles.axes2)
% subplot(2,1,2);
plot(T,Y(:,n+1:2*n))
h=legend('$\dot{\theta_1}$','$\dot{\theta_2}$','$\dot{\theta_3}$','$\dot{\theta_4}$','$\dot{\theta_5}$','$\dot{\theta_6}$','$\dot{\theta_7}$','$\dot{\theta_8}$','$\dot{\theta_9}$','$\dot{\theta_{10}}$','$\dot{\theta_{11}}$','$\dot{\theta_{12}}$','$\dot{\theta_{13}}$','$\dot{\theta_{14}}$','$\dot{\theta_{15}}$','$\dot{\theta_{16}}$','$\dot{\theta_{17}}$','$\dot{\theta_{18}}$','$\dot{\theta_{19}}$','$\dot{\theta_{20}}$');
set(h,'interpreter','latex','Orientation','v','Location','northeast','Color', 'none','Box', 'off','FontAngle','italic','fontsize',10,'fontweight','normal','fontname','times new romans','linewidth',0.5)
% h=legend('Joint rates (rad/s)');
% set(h,'Orientation','horizontal','Color', 'none','Box', 'off','Location','northoutside','fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5)
% set (gca,'fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
xlabel('time (s)','FontSize',10);
ylabel('Joint rates (rad/s)','FontSize',10);


cd ..
cd ..

function[]=plot_motion_Joint_angles_Fixed_V2_Inv(handles)
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


axes(handles.axes1)
set(0,'DefaultLineLineWidth',1.5,'DefaultLineMarkerSize',3)
% cla reset;
% figure;
% subplot(3,1,1);
plot(T,Y(:,1:n))
h=legend('\theta_1','\theta_2','\theta_3','\theta_4','\theta_5','\theta_6','\theta_7','\theta_8','\theta_9','\theta_{10}','\theta_{11}','\theta_{12}','\theta_{13}','\theta_{14}','\theta_{15}','\theta_{16}','\theta_{17}','\theta_{18}','\theta_{19}','\theta_{20}');
set(h,'Orientation','v','Location','northeast','Color', 'none','Box', 'off','FontAngle','italic','fontsize',10,'fontweight','normal','fontname','times new romans','linewidth',0.5)
% h=legend('Joint angles (rad)');
% set(h,'Orientation','horizontal','Color', 'none','Box', 'off','Location','northoutside','fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5)
% set (gca,'fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
xlabel('time (s)','FontSize',10);
ylabel('Joint angles (rad)','FontSize',10);

% axes(handles.axes2)
% subplot(3,1,2);
% plot(T,Y(:,(n+1):(2*n)))
% set (gca,'fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
% xlabel('time (s)','FontSize',10);
% ylabel('Joint rates (rad/s)','FontSize',10);
% 
% subplot(3,1,3);
% plot(T,Y(:,(2*n+1):(3*n)))
% set (gca,'fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
% xlabel('time (s)','FontSize',10);
% ylabel('Joint acceleration (rad/s^2)','FontSize',10);

cd ..
cd ..

function[]=plot_motion_Joint_rates_Fixed_V2_Inv(handles)
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


axes(handles.axes1)
set(0,'DefaultLineLineWidth',1.5,'DefaultLineMarkerSize',3)
% cla reset;
% figure;
% subplot(3,1,1);
% plot(T,Y(:,1:n))
% h=legend('Joint rates (rad/s)');
% set(h,'Orientation','horizontal','Color', 'none','Box', 'off','Location','northoutside','fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5)
% % set (gca,'fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
% xlabel('time (s)','FontSize',10);
% ylabel('Joint angles (rad)','FontSize',10);

% axes(handles.axes2)
% subplot(3,1,2);
plot(T,Y(:,(n+1):(2*n)))
h=legend('$\dot{\theta_1}$','$\dot{\theta_2}$','$\dot{\theta_3}$','$\dot{\theta_4}$','$\dot{\theta_5}$','$\dot{\theta_6}$','$\dot{\theta_7}$','$\dot{\theta_8}$','$\dot{\theta_9}$','$\dot{\theta_{10}}$','$\dot{\theta_{11}}$','$\dot{\theta_{12}}$','$\dot{\theta_{13}}$','$\dot{\theta_{14}}$','$\dot{\theta_{15}}$','$\dot{\theta_{16}}$','$\dot{\theta_{17}}$','$\dot{\theta_{18}}$','$\dot{\theta_{19}}$','$\dot{\theta_{20}}$');
set(h,'interpreter','latex','Orientation','v','Location','northeast','Color', 'none','Box', 'off','FontAngle','italic','fontsize',10,'fontweight','normal','fontname','times new romans','linewidth',0.5)
% h=legend('Joint rates (rad/s)');
% set(h,'Orientation','horizontal','Color', 'none','Box', 'off','Location','northoutside','fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5)
% set (gca,'fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
xlabel('time (s)','FontSize',10);
ylabel('Joint rates (rad/s)','FontSize',10);
% 
% subplot(3,1,3);
% plot(T,Y(:,(2*n+1):(3*n)))
% set (gca,'fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
% xlabel('time (s)','FontSize',10);
% ylabel('Joint acceleration (rad/s^2)','FontSize',10);

cd ..
cd ..

function[]=plot_motion_Joint_accelerations_Fixed_V2_Inv(handles)
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


axes(handles.axes1)
set(0,'DefaultLineLineWidth',1.5,'DefaultLineMarkerSize',3)
% cla reset;
% figure;
% subplot(3,1,1);
% plot(T,Y(:,1:n))
% h=legend('Joint rates (rad/s)');
% set(h,'Orientation','horizontal','Color', 'none','Box', 'off','Location','northoutside','fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5)
% % set (gca,'fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
% xlabel('time (s)','FontSize',10);
% ylabel('Joint angles (rad)','FontSize',10);

% axes(handles.axes2)
% subplot(3,1,2);
% plot(T,Y(:,(n+1):(2*n)))
% set (gca,'fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
% xlabel('time (s)','FontSize',10);
% ylabel('Joint rates (rad/s)','FontSize',10);
% 
% subplot(3,1,3);
plot(T,Y(:,(2*n+1):(3*n)));
h=legend('$\ddot{\theta_1}$','$\ddot{\theta_2}$','$\ddot{\theta_3}$','$\ddot{\theta_4}$','$\ddot{\theta_5}$','$\ddot{\theta_6}$','$\ddot{\theta_7}$','$\ddot{\theta_8}$','$\ddot{\theta_9}$','$\ddot{\theta_{10}}$','$\ddot{\theta_{11}}$','$\ddot{\theta_{12}}$','$\ddot{\theta_{13}}$','$\ddot{\theta_{14}}$','$\ddot{\theta_{15}}$','$\ddot{\theta_{16}}$','$\ddot{\theta_{17}}$','$\ddot{\theta_{18}}$','$\ddot{\theta_{19}}$','$\ddot{\theta_{20}}$');
% h=legend('$\ddot{\theta_1}$','$\ddot{\theta_2}$','$\ddot{\theta_3}$','$\ddot{\theta_4}$','$\ddot{\theta_5}$','$\ddot{\theta_6}$','$\ddot{\theta_7}$','$\ddot{\theta_8}$','$\ddot{\theta_9}$','$\ddot{\theta_{10}}$','$\ddot{\theta_{11}}$','$\ddot{\theta_{12}}$');
set(h,'interpreter','latex','Orientation','v','Location','northeast','Color', 'none','Box', 'off','FontAngle','italic','fontsize',10,'fontweight','normal','fontname','times new romans','linewidth',0.5)
% h=legend('Joint accelerations (rad/s)');
% set(h,'Orientation','horizontal','Color', 'none','Box', 'off','Location','northoutside','fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5)
% set (gca,'fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
xlabel('time (s)','FontSize',10);
ylabel('Joint acceleration (rad/s^2)','FontSize',10);

cd ..
cd ..

function [] = plot_tor_Fixed_V2_Inv(handles)
    
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
axes(handles.axes1)
% cla reset;
% figure;
set(0,'DefaultLineLineWidth',1.5,'DefaultLineMarkerSize',3);
plot(T,Y);
h=legend('\tau_1','\tau_2','\tau_3','\tau_4','\tau_5','\tau_6','\tau_7','\tau_8','\tau_9','\tau_{10}','\tau_{11}','\tau_{12}','\tau_{13}','\tau_{14}','\tau_{15}','\tau_{16}','\tau_{17}','\tau_{18}','\tau_{19}','\tau_{20}');
set(h,'Orientation','v','Color', 'none','Box', 'off','Location','northeast','FontAngle','italic','fontsize',10,'fontweight','normal','fontname','times new romans','linewidth',0.5)
% h=legend('Joint Torque');
% set(h,'Orientation','horizontal','Color', 'none','Box', 'off','Location','northoutside','fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5)
% set (gca,'fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
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
    
files = dir(fullfile(pwd)) ;
dir_flags = [files.isdir];
files = files(dir_flags);
files = files(3:size(files));

% system_type = {'Fixed Base (v-2)', 'Fixed Base (v-1)', 'Floating Base', 'Legged Robot', 'Symbolic'}
system_type = {'Fixed Base (v-2)'};

% set(handles.popupmenu1,'string',system_type);

analysis_type = {'ForDyn','InvDyn'};
set(handles.popupmenu4,'string',analysis_type);


[system_type, analysis_type] = inflate_available_examples1(handles);

% inflate_available_examples1(handles);
% copy_file(handles,  name, folder);
copy_example_files(handles)
load_input(handles);
% read_file_table(handles);

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



function edit_dof_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dof (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dof as text
%        str2double(get(hObject,'String')) returns contents of edit_dof as a double


% --- Executes during object creation, after setting all properties.
function edit_dof_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dof (see GCBO)
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
% animate2.m;
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

% hObject    handle to reset_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% [system_type, analysis_type] = inflate_available_examples1(handles);
%     cd(system_type);
%     cd(analysis_type);
% %     cd(get(handles.popupmenu2,'String')); 
% %     [n dof type alp a b bt dx dy dz m g  Icxx Icyy Iczz Icxy Icyz Iczx aj al]=inputs();
%     [n dof type alp a b th bt r dx dy dz m g  Icxx Icyy Iczz Icxy Icyz Iczx aj al Tp steps]=inputs();
%     
% %     cd ..;
% %     cd ..;
%     
%     handles.n = n;
%     handles.dof = dof;
%     handles.type = type;
%     handles.g = g;
%     handles.Tp = Tp;
%     handles.steps = steps;
%     handles.table_data2 = [ al ];
%     handles.table_data1 = [ alp, a, b, th, bt, r, dx, dy, dz, m, Icxx, Icyy, Iczz, Icxy, Icyz, Iczx, aj];
%     handles.table_columns2 = {'al'};
%     handles.table_columns1 = {'alp', 'a', 'b','th', 'bt','r', 'dx', 'dy', 'dz', 'm', 'Icxx', 'Icyy', 'Iczz', 'Icxy', 'Icyz', 'Iczx', 'aj'};
%     set(handles.uitable3,'data',handles.table_data2,'ColumnName',handles.table_columns2);
%     set(handles.uitable1,'data',handles.table_data1,'ColumnName',handles.table_columns1);
%     set(handles.edit_gx,'string',handles.g(1));
%     set(handles.edit_gy,'string',handles.g(2));
%     set(handles.edit_gz,'string',handles.g(3));
%     set(handles.edit_dof,'string',handles.dof);
%     set(handles.edit_n,'string',handles.n);
%     set(handles.edit_type,'string',handles.type);
%     
%     cd ..;
%     cd ..;

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

% if strcmp(selection, 'ForDyn')==1
else
    clear all;
    fclose all;
    clc;
    runfor;
    energy;
end

cd ..
cd ..
 close(simulating_popup);
% hObject    handle to simulate_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on button press in plot_button.
function plot_button_Callback(hObject, eventdata, handles)

selection = get(handles.uibuttongroup2, 'SelectedObject');
selection = get(selection, 'String');

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

% Tp = get(handles.edit_Tp, 'String');
% [Tp, status] = str2num(Tp);
% if status==0 || Tp <= 0  
%     Tp = 1;
% end
% create_variable_file(Tp, 0);
% read_file_table(handles);

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
% steps = get(handles.edit_steps, 'String');
% [steps, status] = str2num(steps);
% if status==0 || steps <= 0  
%     steps = 1;
% end
% create_variable_file(steps, 0);
% read_file_table(handles);


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
      plot_motion_Joint_angles_Fixed_V2_For(handles);
end
if selectedIndex  == 2
      plot_motion_Joint_rates_Fixed_V2_For(handles);
end
if selectedIndex  == 3
      plot_acc_Fixed_V2_For(handles);
end
if selectedIndex  == 4
      plot_tor_Fixed_V2_For(handles);
end
if selectedIndex  == 5
      plot_energy_Fixed_V2_For(handles);
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
      plot_motion_Joint_angles_Fixed_V2_Inv(handles);
end
if selectedIndex  == 2
      plot_motion_Joint_rates_Fixed_V2_Inv(handles);
end
if selectedIndex  == 3
      plot_motion_Joint_accelerations_Fixed_V2_Inv(handles);
end
if selectedIndex  == 4
      plot_tor_Fixed_V2_Inv(handles);
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


% --- Executes on button press in save_push_button2.
function save_push_button2_Callback(hObject, eventdata, handles)
% hObject    handle to save_push_button2 (see GCBO)
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
% copy_input_file(handles, file,path);
% copy_input_example_files(handles,path);
copy_input_example_files(handles);
load_input(handles);

function Source_To_Destination(handles, file , path)
    [system_type, analysis_type] = inflate_available_examples1(handles);
    
    source = fullfile(path, file);
    dest = fullfile(pwd, system_type);
    cd .
    dest2= pwd;
    copyfile (source, dest2);
 	
%     if exist(source, 'file') == 2
%         copyfile (source, dest);
%     end
%    
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
