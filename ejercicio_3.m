function varargout = ejercicio_3(varargin)
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ejercicio_3_OpeningFcn, ...
                   'gui_OutputFcn',  @ejercicio_3_OutputFcn, ...
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
% --- Executes just before ejercicio_3 is made visible.
function ejercicio_3_OpeningFcn(hObject, eventdata, handles, varargin)
% Choose default command line output for ejercicio_3
% Leer imagen de diagrama
image(imread('Viga.png'),'parent',handles.axes3)
set(handles.axes3,'XTick',[],'YTick',[])
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
% --- Outputs from this function are returned to the command line.
function varargout = ejercicio_3_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;
% ______________________________________________________
% --- FUNCIÓN DEL BOTÓN DE CÁLCULO Y GRAFICACIÓN.
function plotear_Callback(hObject, eventdata, handles)
% Tomar datos de los edit-text

F1=str2double(get(handles.Fuerza1,'String'));
M1=str2double(get(handles.Momento1,'String'));
W1=str2double(get(handles.carga1,'String'));
W2=str2double(get(handles.carga2,'String'));
%Distancias:
d1=str2double(get(handles.dis1,'String'));
d2=str2double(get(handles.dis2,'String'));
d3=str2double(get(handles.dis3,'String'));
dt=d1+d2+d3;

% Cálculo de Ra y Rb
C = -(M1 + F1*d1 - (W1*d2^2)/2 - (W2*d3*(d2 + d3/3))/2)/d2;
B = F1 - C + W1*d2 + (W2*d3)/2;
% Escribir el resultado de Ra y Rb
set(handles.resultado_b,'String',[num2str(B),' [N]'])
set(handles.resultado_c,'String',[num2str(C),' [N]'])
% Ejecución del algoritmo
x=0:0.01:dt;
for i=1:length(x)
    if x(i)<=d1
        V(i)=-F1;
        M(i)=-F1*x(i)-M1;
    end
    if x(i)>=d1 && x(i)<=d1+d2
        V(i)=-F1+B-W1*(x(i)-d1);
        M(i)=-F1*x(i)-M1+B*(x(i)-d1)+(W1*((x(i)-d1)^2)/2);
    end
    if x(i)>=d1+d2 && x(i)<=dt
        delta(i)= x(i)-(d1+d2);
        Feq(i)=-W2*delta(i)^2/(2*d3) + W2*delta(i);
        x_trazo(i)= (delta(i)*((1/2)-(delta(i))/(3*d3)))/(1-(delta(i))/(2*d3));
        
        V(i)= -F1+B-(W1*d2)+C-Feq(i);
        M(i)=-M1-F1*x(i)+B*(x(i)-d1)-(W1*d2*(x(i)-(d1+(d2/2))))+C*(x(i)-(d1+d2))-Feq(i)*(x(i)-(d1+d2+x_trazo(i)));
    end

end
% Gráfica de V.
axes(handles.axes1); 
plot(x,V,'Color','g','LineWidth',1.5);
xlabel('x[m]');ylabel('V[N]');grid on
% Gráfica de M.
axes(handles.axes2);
plot(x,M,'Color','r','LineWidth',1.5);
xlabel('x[m]');ylabel('M[Nm]');grid on

% --------
% zoom on

% Funciones de los Edit-Text (no se usan)
function dis2_Callback(hObject, eventdata, handles)
function Fuerza1_Callback(hObject, eventdata, handles)
function Momento1_Callback(hObject, eventdata, handles)
function carga1_Callback(hObject, eventdata, handles)
function carga2_Callback(hObject, eventdata, handles)
function dis1_Callback(hObject, eventdata, handles)
function dis3_Callback(hObject, eventdata, handles)
