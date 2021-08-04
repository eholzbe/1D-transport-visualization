function varargout = transportfit(varargin)
% TRANSPORTFIT M-file for transportfit.fig
%      TRANSPORT, by itself, creates a new TRANSPORT or raises the existing
%      singleton*.
%
%      H = TRANSPORT returns the handle to a new TRANSPORT or the handle to
%      the existing singleton*.
%
%      TRANSPORT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TRANSPORT.M with the given input arguments.
%
%      TRANSPORT('Property','Value',...) creates a new TRANSPORT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before transport_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to transport_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help transport

% Last modified by EH 4-Dec-2008

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @transport_OpeningFcn, ...
                   'gui_OutputFcn',  @transport_OutputFcn, ...
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


% --- Executes just before transport is made visible.
function transport_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to transport (see VARARGIN)

% Choose default command line output for transport
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes transport wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global xdata tdata cdata Dflag vflag lflag Rflag pn fn newfile
xdata = []; tdata = []; cdata = []; Dflag = 0; vflag = 0; lflag = 0; Rflag = 0;
pn = ''; fn = ''; newfile = 1;
% --- Outputs from this' function are returned to the command line.

function varargout = transport_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% Get default command line output from handles structure
varargout{1} = handles.output;
set(hObject, 'Visible', 'on')

function D_edit_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function D_edit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function v_edit_Callback(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.

function v_edit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function R_edit_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function R_edit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function T_edit_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function T_edit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function lambda_edit_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function lambda_edit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function L_edit_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function L_edit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in runbutton.
function runbutton_Callback(hObject, eventdata, handles)
global xdata tdata cdata Dflag vflag lflag Rflag

% Get user input from GUI
D = str2double(get(handles.D_edit,'String'));
v = str2double(get(handles.v_edit,'String'));
R = str2double(get(handles.R_edit,'String'));
lambda = str2double(get(handles.lambda_edit,'String'));
T = str2double(get(handles.T_edit,'String'));
L = str2double(get(handles.L_edit,'String'));
l = get(handles.listbox1,'Value');
Dflag = get(handles.radiobutton1,'Value');
vflag = get(handles.radiobutton2,'Value');
lflag = get(handles.radiobutton3,'Value');
Rflag = get(handles.radiobutton4,'Value');
Min = 1;   % injected mass, for instantaneous source
cin = 1;   % inflow concentration, for constant inflow

% Estimate parameters
if Dflag*vflag*lflag*Rflag > 0 
    msgbox('Maximal 3 parameters can be estimated!'); return 
end
Par0 = []; Parmin = []; Parmax = []; TolX = 1.e-16; eps = 1.e-12;
if Dflag Par0 = [Par0 D]; Parmin = [Parmin 1e-12]; Parmax = [Parmax 1e12]; end
if vflag Par0 = [Par0 v]; Parmin = [Parmin -1e12]; Parmax = [Parmax 1e12]; end
if lflag Par0 = [Par0 lambda]; Parmin = [Parmin 0]; Parmax = [Parmax 1e12]; end
if Rflag Par0 = [Par0 R]; Parmin = [Parmin 1]; Parmax = [Parmax 1e12]; end
if ~isempty(Par0)
    options = optimset ('MaxFunEvals',100,'TolX',TolX,'Display','iter','TolFun',eps);
    if l > 1
        [Par,resnorm,exitflag,output,lamb] = lsqcurvefit (@SolTrans2,Par0,tdata,cdata,...
        Parmin,Parmax,options,xdata,cin,D,v,lambda,R,Dflag,vflag,lflag,Rflag);
    else
        [Par,resnorm,exitflag,output,lamb] = lsqcurvefit (@SolTrans1,Par0,tdata,cdata,...
        Parmin,Parmax,options,xdata,Min,D,v,lambda,R,Dflag,vflag,lflag,Rflag);
    end
    if (exitflag <= 0) set(handles.edit7,'String','Algorithm did not converge'); 
    else
        set(handles.edit7,'String',['Squared 2-norm of residual: ', num2str(resnorm)])
    end
    if Dflag D = Par(1); set(handles.D_edit,'String',num2str(D)); Par(1) = []; end
    if vflag v = Par(1); set(handles.v_edit,'String',num2str(v)); Par(1) = []; end
    if lflag lambda = Par(1); set(handles.lambda_edit,'String',num2str(lambda)); Par(1) = []; end
    if Rflag R = Par(1); set(handles.R_edit,'String',num2str(R)); end
end

% Create space plot
map = colormap; y = map(1:7:end,:);
u = sqrt(v*v+4*lambda*R*D);
t = linspace (T/10,T,10);
e = ones (1,101);
axes(handles.xaxes);
x = linspace(0,L,101); 
for i = 1:size(t,2)      
    if l > 1
        h = 1./(2.*sqrt(D*R*t(i)));
        hh = plot (x,cin*0.5*(exp(((v-u)/(D+D)*x)+log(erfc(h*(R*x-e*u*t(i)))))+...
        exp(((v+u)/(D+D)*x)+log(erfc(h*(R*x+e*u*t(i)))))),'color',y(mod(i,10)+1,:));
    else
        hh = plot (x,Min*exp(-lambda*t(i)).*exp(-(R*x-e*v*t(i)).^2./(4*D*t(i)*R))./...
        (2.*sqrt(pi*D*t(i)/R)),'color',y(mod(i,10)+1,:));
    end
    set (hh,'LineWidth',2)
    hold on;     
end
xlim ([0 L]);
if l > 1 ylim ([0 1]); end
set(gca,'XTick',[L/10:L/10:L]);
grid on
lgd = legend (['0-' num2str(T/10)],[num2str(T/10) '-' num2str(T/5)],[num2str(T/5) '-' num2str(.3*T)],...
    [num2str(.3*T) '-' num2str(.4*T)],[num2str(.4*T) '-' num2str(T/2)],[num2str(T/2) '-' num2str(.6*T)],...
    [num2str(.6*T) '-' num2str(.7*T)],[num2str(.7*T) '-' num2str(.8*T)],...
    [num2str(.8*T) '-' num2str(.9*T)],[num2str(.9*T) '-' num2str(T)]);
hold off

% Create time plot
x = linspace (L/10,L,10)';
e = ones (11,1);
axes(handles.taxes);
for j = 1:10
    t = linspace (T*(j-1)/10,T*j/10,11)';
    for i = 1:length(x)
        if l > 1
            hh = plot(t,SolTrans2(0,t,x(i),cin,D,v,lambda,R,0,0,0,0),'color',y(mod(j,10)+1,:)); 
        else
            hh = plot(t,SolTrans1(0,t,x(i),Min,D,v,lambda,R,0,0,0,0),'color',y(mod(j,10)+1,:));
        end
        set (hh,'LineWidth',2) 
        hold on;
    end    
end
if ~isempty(Par0)
    j = 1; 
    for i=1:length(xdata)
        plot (tdata,cdata(j:j+length(tdata)-1),'ok'); hold on
        j = j+length(tdata);
    end
end
xlim ([0 T]);
if l > 1 ylim ([0 1]); end
set(gca,'XTick',[T/10:T/10:T]);
grid on
hold off
axes(handles.xaxes); 
uistack (lgd,'top'); set(lgd,'FontSize',6); 

% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
val = get(hObject,'Value');
switch val
case 1
    msgbox('E. Holzbecher, German University of Technology in Oman, E-mail: ekkehard.holzbecher@gutech.edu.om','Info','none'); 
    web https://www.researchgate.net/profile/Ekkehard_Holzbecher;
    uiwait;
case 2
    msgbox('Environmental Modelling using MATLAB, Springer Publ.','Info','none');
    web http://www.mathworks.de/matlabcentral/fileexchange/41147-environmental-modeling-using-matlab;
    uiwait;
case 3
    msgbox(['For selected transport parameters (diffusivity, velocity, decay constant, retardation) concentrations are plotted as function of space (at 10 equidistant time instants) and as function of time (at 10 equidistant locations). Colors are related to timeperiods!'...
        ' For given breakthrough curves selected parameters can be estimated.']);
case 4
    msgbox('Units for the parameters are noted in brackets below the data input. The user has to choose a length unit L and a time unit T, and specify the parameters in the corresponding units accordingly. Example: if the space unit is "cm" and time unit is "hour" the velocity input is "cm/hour".');
case 5        
    msgbox('Springer Publ., Heidelberg','Info','none');
    web http://www.springerlink.com/content/k11790l570676300/;
    uiwait;
case 6
    msgbox('MATLAB, MathWorks Inc, see: www.mathworks.com', 'Info','none'); 
    web www.mathworks.com;
    uiwait;        
end

% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
fn = uiputfile; savefig(fn)

% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)    % read button
global xdata tdata cdata newfile pn fn
%xdata = [20 40]'; tdata = linspace(2,100,49)'; L=100; T=100;  % for testing
%cdata = SolTrans1(0,tdata,xdata,1,1,1,0.00,2,0,0,0,0);        % for testing
set(handles.edit7,'String','Read xdata, tdata, cdata as numeric matrices from file');
if newfile 
    [fn,pn] = uigetfile({'*.xls;*.xlsx','Excel files (*.xls,*.xlsx)';...
    '*.dat;*.txt','Ascii files (*.dat,*.txt)'; '*.*',  'All Files (*.*)'},...
    'Recognized data files'); 
    set(handles.radiobutton5,'Enable','on');
end
uiimport (fullfile(pn,fn)); 
set(handles.edit7,'String','After finished data read activate and press any key to continue');
pause  % w = waitforbuttonpress; 
%uiwait (figure1_ButtonDownFcn)
if ~isempty(cdata) set(handles.edit7,'String',' '); end
if istable(cdata) cdata=table2array(cdata); end
if istable(tdata) tdata=table2array(tdata); end
if istable(xdata) xdata=table2array(xdata); end   
if ~ismatrix(cdata) | ~ismatrix(tdata)
    set(handles.edit7,'String','Import data type cannot be read'); end
if size (xdata,2) ~= 1 xdata=xdata'; end
if size (tdata,2) ~= 1 tdata=tdata'; cdata=cdata'; end
if size (tdata,2) ~= 1 
    set(handles.edit7,'String','Import data is not a vector or scalar'); end

function c = SolTrans1 (x,t,xdata,Min,D,v,lambda,R,Dflag,vflag,lflag,Rflag)
% Solute mass transfer from an instantaneous event 
Par = x;
if (Dflag) D = Par(1); Par(1) = []; end 
if (vflag) v = Par(1); Par(1) = []; end
if (lflag) lambda = Par(1); Par(1) = []; end
if (Rflag) R = Par(1); end
e = ones (length(t),1); c = [];
for i=1:length(xdata)
    c = [c Min*exp(-lambda*t).*exp(-(e*R*xdata(i)-v*t).^2./(4*D*R*t))./(2*sqrt(pi*D*t/R))];
end

function c = SolTrans2 (x,t,xdata,cin,D,v,lambda,R,Dflag,vflag,lflag,Rflag)
% Solute mass transfer from constant inflow 
Par = x;
if (Dflag) D = Par(1); Par(1) = []; end 
if (vflag) v = Par(1); Par(1) = []; end
if (lflag) lambda = Par(1); Par(1) = []; end
if (Rflag) R = Par(1); end
e = ones (length(t),1); u = sqrt(v*v+4*lambda*R*D); h = 1./(2.*sqrt(D*R*t)); c = []; 
for i=1:length(xdata)   
    c = [c cin*0.5*(exp(((v-u)/(D+D)*xdata(i))+log(erfc(h.*(e*R*xdata(i)-u*t))))+...
            exp(((v+u)/(D+D)*xdata(i))+log(erfc(h.*(e*R*xdata(i)+u*t)))))];
end

% --- Executes on button press in radiobutton1. Fit flag for diffusivity  
function radiobutton1_Callback(hObject, eventdata, handles)
global cdata Dflag
if Dflag == 1
    Dflag = 0
else
    if isempty(cdata) set(handles.edit7,'String','Read fit data'); end
    Dflag = 1;
end

% --- Executes on button press in radiobutton2. Fit flag for velocity
function radiobutton2_Callback(hObject, eventdata, handles)
global cdata vflag
if vflag == 1
    vflag = 0;
else
    if isempty(cdata) set(handles.edit7,'String','Read fit data'); end
    vflag = 1;
end

% --- Executes on button press in radiobutton3. Fit flag for lambda
function radiobutton3_Callback(hObject, eventdata, handles)
global cdata lflag
if lflag == 1
        lflag = 0;
else
    if isempty(cdata) set(handles.edit7,'String','Read fit data'); end
    lflag = 1;
end

% --- Executes on button press in radiobutton4. Fit flag for R
function radiobutton4_Callback(hObject, eventdata, handles)
global cdata Rflag
if Rflag == 1
    Rflag = 0;
else
    if isempty(cdata) set(handles.edit7,'String','Read fit data'); end   
    Rflag = 1;
end

% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)
global newfile
if newfile == 0
    newfile = 1;
else
    newfile = 0;
end

function edit7_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on mouse press over figure background.
function figure1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
