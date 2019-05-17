function varargout = test(varargin)
% test MATLAB code for test.fig
%      test, by itself, creates a new test or raises the existing
%      singleton*.
% test git 2
%      H = test returns the handle to a new test or the handle to
%      the existing singleton*.
%
%      test('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in test.M with the given input arguments.
%
%      test('Property','Value',...) creates a new test or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before test_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to test_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES
 
% Edit the above text to modify the response to help test
 
% Last Modified by GUIDE v2.5 17-May-2019 04:22:00
 
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @test_OpeningFcn, ...
                   'gui_OutputFcn',  @test_OutputFcn, ...
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
 
 
% --- Executes just before test is made visible.
function test_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to test (see VARARGIN)
 
% Choose default command line output for test
handles.output = hObject;
 
% Update handles structure
guidata(hObject, handles);
 
% UIWAIT makes test wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% =======================
% pradinë grafiø bûsena peákëlus garso failo
% =======================
global y1
global fs1
fs1=22000;
T=1;
t=0:1/fs1:(T-1/fs1);
y1=sin(2*pi*5*t).';
axes(handles.axes1);
plot(t*1000,y1)
xlabel('Miliseconds');
ylabel('Amplitude');
axes(handles.axes2);
xlabel('Miliseconds');
ylabel('Amplitude');
axes(handles.axes3);
xlabel('Miliseconds');
ylabel('Amplitude');
set(handles.edit3,'String',fs1);
update(handles)
 
 
% --- Outputs from this function are returned to the command line.
function varargout = test_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
% Get default command line output from handles structure
varargout{1} = handles.output;
 

function edit1_Callback(hObject, eventdata, handles)
% =======================
% teksto lango su daþniu pakeitimas
% =======================
update(handles)
 
% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% =======================
% teksto lango su daþniu inicializacija
% =======================
set(hObject,'String','1');
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
 
 
function edit2_Callback(hObject, eventdata, handles)
% =======================
% teksto lango su failu pakeitimas
% =======================
 
% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% =======================
% teksto lango su daþniu inicializacija
% =======================
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit3_Callback(hObject, eventdata, handles)
% =======================
% teksto lango su sample rate pakeitimas
% =======================
 
% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% =======================
% teksto lango su sample rate inicializacija
% =======================
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% =======================
% mygtuko “change” paspaudimas
% =======================
update(handles)

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% =======================
% mygtuko load paspaudimas
% =======================
 [file,path] = uigetfile('*.wav');
if isequal(file,0)
   disp('User selected Cancel');
else
   disp(['User selected ', fullfile(path,file)])
   set(handles.edit2,'String',fullfile(path,file));
   ufile(handles);
end
 
% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% =======================
% pradinio signalo play mygtuko paspaudimas
% =======================
play1()
 
% --- Executes on button press in pushbutton3.
function pushbutton4_Callback(hObject, eventdata, handles)
% =======================
% moduliuoto signalo play mygtuko paspaudimas
% =======================
play2()
% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% =======================
% sample rate pakeitimo mygtuko paspaudimas
% =======================
global y1
global fs1
global t1
global y2
global y3
fs=str2double(get(handles.edit3, 'String'));
[P,Q] = rat(fs/fs1);
fs1=fs;
y1 = resample(y1,P,Q);
y2 = resample(y2,P,Q);
y3 = resample(y3,P,Q);
t1 = resample(t1,P,Q);
T=(length(y1)*1/fs1)-(1/fs1);
t1=0:1/fs1:T;
axes(handles.axes1);
plot(t1*1000,y1)
xlabel('Miliseconds');
ylabel('Amplitude');
update(handles)
 
% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% =======================
% slider1 vertës pakytimo funkcija
% =======================
global mk
mk=get(handles.slider1, 'Value');
set(handles.text6, 'String',mk)
update(handles)
 
 
% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% =======================
% slider1 inicializacija
% =======================
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function ufile(handles)
% =======================
% failo ákëlimo funkcija
% =======================
global y1 
global fs1
[y1,fs1]=audioread(get(handles.edit2,'String'));
y1= y1(:,1); 
dt1= 1/fs1;
global t1 
t1= 0:dt1:(length(y1)*dt1)-dt1;
set(handles.edit3,'String',fs1);
axes(handles.axes1);
plot(t1*1000,y1);
xlabel('Miliseconds');
ylabel('Amplitude');
 
 
% =======================
% neðanèio signalo sukûrimo ir moduliavimo funkcija
% =======================
function update(handles)
global fs1
global y1
global y2
global y3
global mk
mk=get(handles.slider1, 'Value');
x=str2double(get(handles.edit1, 'String'));
if ~isnan(x)
f=x;
T=(length(y1)*1/fs1)-(1/fs1);
t=0:1/fs1:T;
y2=sin(2*pi*f*t).';
axes(handles.axes2);
y3=y1.*(1+mk*y2);
plot(t*1000,y3)
xlabel('Miliseconds');
ylabel('Amplitude');
axes(handles.axes3);
plot(t*1000,y2);
xlabel('Miliseconds');
ylabel('Amplitude');
else
   fprintf('klaida:blogas daznis\n')
end 
% =======================
% garso signalo atkûrimo funkcijos
% =======================
function play1()
global fs1
global y1
sound(y1,fs1);
 
function play2()
global fs1
global y3
sound(y3,fs1);
