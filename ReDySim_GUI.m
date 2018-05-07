function varargout = ReDySim_GUI(varargin)
%REDYSIM_GUI M-file for ReDySim_GUI.fig
%      REDYSIM_GUI, by itself, creates a new REDYSIM_GUI or raises the existing
%      singleton*.
%
%      H = REDYSIM_GUI returns the handle to a new REDYSIM_GUI or the handle to
%      the existing singleton*.
%
%      REDYSIM_GUI('Property','Value',...) creates a new REDYSIM_GUI using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to ReDySim_GUI_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      REDYSIM_GUI('CALLBACK') and REDYSIM_GUI('CALLBACK',hObject,...) call the
%      local function named CALLBACK in REDYSIM_GUI.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ReDySim_GUI

% Last Modified by GUIDE v2.5 26-Feb-2018 16:06:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ReDySim_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @ReDySim_GUI_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before ReDySim_GUI is made visible.
function ReDySim_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for ReDySim_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ReDySim_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ReDySim_GUI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Fixed_Base_Robots.
function Fixed_Base_Robots_Callback(hObject, eventdata, handles)
% hObject    handle to Fixed_Base_Robots (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
curr_dir = 'ReDySim_GUI_Fixed_base_V2';
cd(curr_dir);
% home_screen;
home_screen('CloseRequestFcn',@my_closereq);




% --- Executes on button press in Floating_Base_Robots.
function Floating_Base_Robots_Callback(hObject, eventdata, handles)
% hObject    handle to Floating_Base_Robots (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
curr_dir = 'ReDySim_GUI_Floating_Base';
cd(curr_dir);
% home_screen;
home_screen('CloseRequestFcn',@my_closereq);



% --- Executes on button press in Legged_Robots.
function Legged_Robots_Callback(hObject, eventdata, handles)
% hObject    handle to Legged_Robots (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
curr_dir = 'ReDySim_GUI_Legged_Robot';
cd(curr_dir);
% home_screen;
home_screen('CloseRequestFcn',@my_closereq);
