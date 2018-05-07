function varargout = simulating_popup(varargin)
% SIMULATING_POPUP MATLAB code for simulating_popup.fig
%      SIMULATING_POPUP, by itself, creates a new SIMULATING_POPUP or raises the existing
%      singleton*.
%
%      H = SIMULATING_POPUP returns the handle to a new SIMULATING_POPUP or the handle to
%      the existing singleton*.
%
%      SIMULATING_POPUP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIMULATING_POPUP.M with the given input arguments.
%
%      SIMULATING_POPUP('Property','Value',...) creates a new SIMULATING_POPUP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before simulating_popup_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to simulating_popup_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help simulating_popup

% Last Modified by GUIDE v2.5 22-Apr-2018 23:06:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @simulating_popup_OpeningFcn, ...
                   'gui_OutputFcn',  @simulating_popup_OutputFcn, ...
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


% --- Executes just before simulating_popup is made visible.
function simulating_popup_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to simulating_popup (see VARARGIN)

% Choose default command line output for simulating_popup
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% load inputs.mat;
% T=Tp;
% dt=steps;
% for i=Tp:dt:0
%   t=i;
%   t=num2str(t);
%   title(['Current time t=',t],'fontweight','normal','fontsize',10);
% end


% [system_type, analysis_type] = inflate_available_examples1(handles);
% cd(system_type);
% cd(analysis_type);
% load timevar.dat;
% T=timevar;
% for i=1:length(T)
%     textLabel= sprintf('Variable C = %f', T);
%     set(handles.text5,'String',textLabel);
% end
% cd ..
% cd ..
% UIWAIT makes simulating_popup wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = simulating_popup_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes when figure1 is resized.
function figure1_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
