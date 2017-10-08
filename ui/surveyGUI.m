function varargout = surveyGUI(varargin)
% SURVEYGUI MATLAB code for surveyGUI.fig
%      SURVEYGUI, by itself, creates a new SURVEYGUI or raises the existing
%      singleton*.
%
%      H = SURVEYGUI returns the handle to a new SURVEYGUI or the handle to
%      the existing singleton*.
%
%      SURVEYGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SURVEYGUI.M with the given input arguments.
%
%      SURVEYGUI('Property','Value',...) creates a new SURVEYGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before surveyGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to surveyGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help surveyGUI

% Last Modified by GUIDE v2.5 05-Oct-2017 19:49:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @surveyGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @surveyGUI_OutputFcn, ...
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


% --- Executes just before surveyGUI is made visible.
function surveyGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to surveyGUI (see VARARGIN)

% Choose default command line output for surveyGUI
handles.output = hObject;

handles.users = ["Anna", "Braeden", "Cameron", "computer", "Corey"];
handles.presets = 5;
handles.currentPreset = 1;
handles.currentUser = 1;
handles.surveyName = [];
handles.dispQuestion = 0;
axes(handles.axes1);

guidata(hObject, handles);


%timers
handles.timer = timer(...
    'ExecutionMode', 'fixedRate', ...       % Run timer repeatedly.
    'Period', 0.1, ...                      % Initial period is 0.1 sec.
    'TimerFcn', {@setUser,hObject}); % Specify callback function.

start(handles.timer)


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes surveyGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = surveyGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in buSubmit.
function buSubmit_Callback(hObject, eventdata, handles)
% hObject    handle to buSubmit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.surveyName = handles.Name.String;
currentPreset = handles.currentPreset;
currentUser = handles.currentUser;

currentResults = zeros(1,3);
questionList = ["first","second","third"];

for i = 1:3
    for x = 1:5
        structName = strcat(questionList(1,i),string(x));
        cellName = cellstr(structName);
        
        if(handles.(cellName{1}).Value)
           currentResults(1,i) = x; 
        end
    end
end

feedback = handles.feedback.String;



handles.FullResults{currentPreset}.name = handles.surveyName;
handles.FullResults{currentPreset}.results(:,:, handles.currentUser) = currentResults;
handles.FullResults{currentPreset}.feedback{currentUser} = feedback;

handles.currentUser = handles.currentUser + 1;




if(handles.currentUser > length(handles.users))
   handles.currentUser = 1;
   
   handles.currentPreset = handles.currentPreset + 1;
   handles.dispQuestion = 1;
   
   if (handles.currentPreset > handles.presets)
      handles.currentPreset = 1000; 
      
   end
end

guidata(hObject, handles);



function feedback_Callback(hObject, eventdata, handles)
% hObject    handle to feedback (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of feedback as text
%        str2double(get(hObject,'String')) returns contents of feedback as a double


% --- Executes during object creation, after setting all properties.
function feedback_CreateFcn(hObject, eventdata, handles)
% hObject    handle to feedback (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in third1.
function third1_Callback(hObject, eventdata, handles)
% hObject    handle to third1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of third1


% --- Executes on button press in third2.
function third2_Callback(hObject, eventdata, handles)
% hObject    handle to third2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of third2


% --- Executes on button press in third3.
function third3_Callback(hObject, eventdata, handles)
% hObject    handle to third3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of third3


% --- Executes on button press in third4.
function third4_Callback(hObject, eventdata, handles)
% hObject    handle to third4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of third4


% --- Executes on button press in third5.
function third5_Callback(hObject, eventdata, handles)
% hObject    handle to third5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of third5

function setUser(~,~,hObject)
handles = guidata(hObject);

if(handles.dispQuestion)
    if (handles.currentPreset == 1000)
        handles.FullResults{5}.selected = posInput(5);
        handles.dispQuestion = 0;
    else
        handles.FullResults{handles.currentPreset - 1}.selected = posInput(handles.currentPreset - 1);
        handles.dispQuestion = 0;
    end
    guidata(hObject, handles);
end

if(handles.currentPreset == 1000 )
   stop(handles.timer);
   set(handles.writtenDirections, 'String',"You have completed all the questions, thank you");
   
   writeToFile(handles);
   
   return;
%    delete(handles);
end

userName = getenv('username');

location = ['C:\Users\',userName,'\Documents\survey\results\'];
userfolder = handles.users(1,handles.currentUser);
preset = string(handles.currentPreset);

img_location = strcat(location, userfolder, '\', preset,'\',preset,'.jpg');
text_location = strcat(location, userfolder, '\', preset,'\',preset,'.txt');

img = imread(char(img_location));
text = fileread(char(text_location));

set(handles.writtenDirections, 'String',text);


imshow(img, 'Parent', handles.axes1);

% guidata(hObject,handles);



function Name_Callback(hObject, eventdata, handles)
% hObject    handle to Name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Name as text
%        str2double(get(hObject,'String')) returns contents of Name as a double


% --- Executes during object creation, after setting all properties.
function Name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function writeToFile(handles)
userName = getenv('username');


name = char(handles.FullResults{1}.name);
file = fopen(['C:\Users\',userName,'\Documents\survey\surveyResults\',name,'.txt'],'w');

file_feedback = fopen(['C:\Users\',userName,'\Documents\survey\surveyResults\',name,'_feedback','.txt'],'w');


for i = 1:handles.presets
   results = handles.FullResults{i}.results;
   feedback = handles.FullResults{i}.feedback;
   best = handles.FullResults{i}.selected;
   
   for x = 1:length(handles.users)
      fprintf(file, '%s,', string(results(:,:,x)));
      fprintf(file_feedback, '%s \r\n\r\n' , feedback{x});
   end
   
   fprintf(file, '%s', string(best));
   
   fprintf(file, '\r\n');
end

fclose(file);
fclose(file_feedback);

