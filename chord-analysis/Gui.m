function varargout = Gui(varargin)
% GUI MATLAB code for Gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Gui

% Last Modified by GUIDE v2.5 14-Nov-2014 10:53:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Gui_OpeningFcn, ...
    'gui_OutputFcn',  @Gui_OutputFcn, ...
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


% --- Executes just before Gui is made visible.
function Gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Gui (see VARARGIN)

% Choose default command line output for Gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Gui_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function progress_Callback(hObject, eventdata, handles)
% hObject    handle to progress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
t=floor(get(hObject,'Value')/handles.fs);
if mod(t,60)<10
    str=[num2str(floor(t/60)) ':0' num2str(mod(t,60))];
else
    str=[num2str(floor(t/60)) ':' num2str(mod(t,60))];
end
set(handles.time,'String',str);
plot(handles.timeLine,[get(hObject,'Value') get(hObject,'Value')],get(handles.waveAxis,'Ylim'),'Color','r');
set(handles.timeLine,'Color','None','XTick',[],'YTick',[],'XTickLabel',[],'YTickLabel',[]);
set(handles.timeLine,'Xlim',get(handles.waveAxis,'Xlim'),'Ylim',get(handles.waveAxis,'Ylim'));
handles.lineSample=floor(get(hObject,'Value'))+1;
if (handles.track)
    currentPos=floor((floor(get(hObject,'Value'))+1)/handles.distance)+1;
    if (size(handles.toneSequence,1)>=currentPos);
       thisTones=handles.toneSequence(currentPos,:);
       bar(handles.accuAmpPlot,[1:length(thisTones)],thisTones);
       set(handles.accuAmpPlot,'XTickLabel',{'C','C#','D','D#','E','F','F#','G','G#','A','A#','B'});
    end
end
guidata(hObject,handles);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function progress_CreateFcn(hObject, eventdata, handles)
% hObject    handle to progress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in playButton.
function playButton_Callback(hObject, eventdata, handles)
% hObject    handle to playButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

value=floor(get(handles.progress,'Value'))+1;
play(handles.audioPlayer,value);
if strcmp(get(handles.timer,'Running'),'off')
    start(handles.timer);
end
guidata(hObject,handles);

function GUIUpdate(hObject,eventdata,handles)
t=floor(handles.audioPlayer.CurrentSample/handles.fs);
if mod(t,60)<10
    str=[num2str(floor(t/60)) ':0' num2str(mod(t,60))];
else
    str=[num2str(floor(t/60)) ':' num2str(mod(t,60))];
end
set(handles.time,'String',str);
set(handles.progress,'Value',handles.audioPlayer.CurrentSample);
if strcmp(handles.audioPlayer.Running,'off')
    stop(handles.timer)
end 
if (handles.track)
    currentPos=floor(handles.audioPlayer.CurrentSample/handles.distance)+1;
    if (size(handles.toneSequence,1)>=currentPos);
       thisTones=handles.toneSequence(currentPos,:);
       bar(handles.accuAmpPlot,[1:length(thisTones)],thisTones);
       set(handles.accuAmpPlot,'XTickLabel',{'C','C#','D','D#','E','F','F#','G','G#','A','A#','B'});
    end
end



% --- Executes on button press in pauseButton.
function pauseButton_Callback(hObject, eventdata, handles)
% hObject    handle to pauseButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.audioPlayer.pause;
set(handles.progress,'Value',handles.audioPlayer.CurrentSample);
stop(handles.timer);
%draw the Line
plot(handles.timeLine,[handles.audioPlayer.CurrentSample handles.audioPlayer.CurrentSample],get(handles.waveAxis,'Ylim'),'Color','r');
set(handles.timeLine,'Color','None','XTick',[],'YTick',[],'XTickLabel',[],'YTickLabel',[]);
set(handles.timeLine,'Xlim',get(handles.waveAxis,'Xlim'),'Ylim',get(handles.waveAxis,'Ylim'));
handles.lineSample=handles.audioPlayer.CurrentSample;
guidata(hObject,handles);


% --- Executes on button press in stopButton.
function stopButton_Callback(hObject, eventdata, handles)
% hObject    handle to stopButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.audioPlayer.pause;
set(handles.progress,'Value',1);
stop(handles.timer);
guidata(hObject,handles);



function time_Callback(hObject, eventdata, handles)
% hObject    handle to time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of time as text
%        str2double(get(hObject,'String')) returns contents of time as a double


% --- Executes during object creation, after setting all properties.
function time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function startTime_Callback(hObject, eventdata, handles)
% hObject    handle to startTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of startTime as text
%        str2double(get(hObject,'String')) returns contents of startTime as a double


% --- Executes during object creation, after setting all properties.
function startTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function endTime_Callback(hObject, eventdata, handles)
% hObject    handle to endTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of endTime as text
%        str2double(get(hObject,'String')) returns contents of endTime as a double


% --- Executes during object creation, after setting all properties.
function endTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to endTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in startPointButton.
function startPointButton_Callback(hObject, eventdata, handles)
% hObject    handle to startPointButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.startSample=handles.lineSample;
t=floor(handles.startSample/handles.fs);
if mod(t,60)<10
    str=[num2str(floor(t/60)) ':0' num2str(mod(t,60))];
else
    str=[num2str(floor(t/60)) ':' num2str(mod(t,60))];
end
set(handles.startTime,'String',str);
if handles.endSample~=-1
   set(handles.cutButton,'Enable','on'); 
   set(handles.estimateButton,'Enable','on');
end
guidata(hObject,handles);


% --- Executes on button press in endPointButton.
function endPointButton_Callback(hObject, eventdata, handles)
% hObject    handle to endPointButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.endSample=handles.lineSample;
t=floor(handles.endSample/handles.fs);
if mod(t,60)<10
    str=[num2str(floor(t/60)) ':0' num2str(mod(t,60))];
else
    str=[num2str(floor(t/60)) ':' num2str(mod(t,60))];
end
set(handles.endTime,'String',str);
if handles.startSample~=-1
   set(handles.cutButton,'Enable','on'); 
   set(handles.calculateButton,'Enable','on');
   set(handles.estimateButton,'Enable','on');
end
guidata(hObject,handles);


% --- Executes on button press in calculateButton.
function calculateButton_Callback(hObject, eventdata, handles)
% hObject    handle to calculateButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
time = 0.05;
distance = floor(handles.fs * time);
handles.distance = distance;
stftLength=16384;
thisSample=1;
toneSequence=[];
while (thisSample+stftLength<length(handles.data))
    data=handles.data(thisSample:thisSample+stftLength-1);
    [t,f,a] = stft(stftLength,data,handles.fs,8000);
    val=get(handles.popUpMode,'Value');
    str=get(handles.popUpMode,'String');
    switch str{val}
        case 'Equal'
            weighedAmpLoudness=getUnweighedAmpSqr(getAccuAmp(t,f,a,0.2));
        case 'Bass First'
            weighedAmpLoudness=getDefaultWeighedAmpSqr(getAccuAmp(t,f,a,0.2));
        case 'Default'
            weighedAmpLoudness=getUnweighedAmpSqr(getAccuAmp(t,f,a,0.2));
    end
    weighedNameLoudness=getWeighedNameSqr(weighedAmpLoudness);
    toneSequence = [toneSequence;weighedNameLoudness];
    handles.toneSequence=toneSequence;
    thisSample = thisSample+distance;
end
handles.toneSequence = toneSequence;
handles.track=true;
delete(handles.timer);
handles.timer = timer('ExecutionMode','fixedRate',...
    'Period', 0.05,...
    'TimerFcn', {@GUIUpdate,handles});
stop(handles.timer);
guidata(hObject,handles);

% --- Executes on button press in estimateButton.
function estimateButton_Callback(hObject, eventdata, handles)
% hObject    handle to estimateButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (handles.startSample<handles.endSample)
    data=handles.data(handles.startSample:handles.endSample);
    if (length(data)>16384)
        [handles.t1,handles.f1,handles.a1]=stft(16384,data,handles.fs,8000);
        [handles.t2,handles.a2]=getNoteTimeAmp(handles.t1,handles.f1,handles.a1,0.2);
        handles.accuAmp=getAccuAmp(handles.t1,handles.f1,handles.a1,0.2);
        handles.instAmp=getInstAmp(handles.a2);
        val=get(handles.popUpMode,'Value');
        str=get(handles.popUpMode,'String');
        switch str{val}
            case 'Equal'
                weighedAmpLoudness=getUnweighedAmpSqr(handles.accuAmp);
            case 'Bass First'
                weighedAmpLoudness=getDefaultWeighedAmpSqr(handles.accuAmp);
            case 'Default'
                weighedAmpLoudness=getUnweighedAmpSqr(handles.accuAmp);
        end
        
        weighedNameLoudness=getWeighedNameSqr(weighedAmpLoudness);
        %set(handles.accuAmpPlot,'xtick',1:108);
        %set(handles.accuAmpPlot,'XTickLabel',{'C',' ','D',' ','E','F',' ','G',' ','A',' ','B'});
        %plot(handles.plot3,[1:length(handles.instAmp)],handles.instAmp);
        %set(handles.plot3,'xtick',1:108);
        %set(handles.plot3,'XTickLabel',{'C',' ','D',' ','E','F',' ','G',' ','A',' ','B'});
        bar(handles.plot3,[1:length(weighedNameLoudness)],weighedNameLoudness);
        set(handles.plot3,'XTickLabel',{'C','C#','D','D#','E','F','F#','G','G#','A','A#','B'});
    end
end

chord=chordEstimation(weighedNameLoudness);
set(handles.chord,'String',chord);
guidata(hObject,handles);


% --- Executes on button press in openFile.
function openFile_Callback(hObject, eventdata, handles)
% hObject    handle to openFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile(...
    {'*.wav;*.mp3;*.ogg;*.wma','Sound(*.wav;*.mp3;*.ogg;*.wma)';...
    '*,*','所有文件(*.*)'}, ...
    'Please choose one sound file');
handles.fileName=filename;
handles.pathName=pathname;
[data,handles.fs]=audioread([pathname filename]);
data=data(:,1);
handles.data=data;
set(handles.timeLine,'Color','None','XTick',[],'YTick',[],'XTickLabel',[],'YTickLabel',[]);
plot(handles.waveAxis,data);
set(handles.progress,'Max',length(data)-2);
handles.audioPlayer=audioplayer(handles.data,handles.fs);
%plot
plot(handles.timeLine,[get(hObject,'Value') get(hObject,'Value')],get(handles.waveAxis,'Ylim'),'Color','r');
set(handles.timeLine,'Color','None','XTick',[],'YTick',[],'XTickLabel',[],'YTickLabel',[]);
set(handles.timeLine,'Xlim',get(handles.waveAxis,'Xlim'),'Ylim',get(handles.waveAxis,'Ylim'));
handles.lineSample=handles.audioPlayer.CurrentSample;
handles.track=false;
handles.timer = timer('ExecutionMode','fixedRate',...
    'Period', 0.05,...
    'TimerFcn', {@GUIUpdate,handles});
stop(handles.timer);
set(handles.playButton,'Enable','on')
set(handles.pauseButton,'Enable','on')
set(handles.stopButton,'Enable','on')
set(handles.endPointButton,'Enable','on')
set(handles.startPointButton,'Enable','on')
set(handles.calculateButton,'Enable','on');
handles.startSample=-1;
handles.endSample=-1;
guidata(hObject,handles);


% --- Executes on button press in exit.
function exit_Callback(hObject, eventdata, handles)
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(gcf);
try
    stop(handles.timer);
    delete(handles.timer);
    delete(handles.audioPlayer);
catch
    
end


% --- Executes during object creation, after setting all properties.
function timeLine_CreateFcn(hObject, eventdata, handles)
% hObject    handle to timeLine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate timeLine


% --- Executes on button press in cutButton.
function cutButton_Callback(hObject, eventdata, handles)
% hObject    handle to cutButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
stop(handles.timer);
delete(handles.timer);
catch
end
handles=rmfield(handles,'timer');
handles.data=handles.data(handles.startSample:handles.endSample);
plot(handles.waveAxis,handles.data);
set(handles.progress,'Max',length(handles.data)-2);
set(handles.progress,'Value',0)
delete(handles.audioPlayer);
handles=rmfield(handles,'audioPlayer');
handles.audioPlayer=audioplayer(handles.data,handles.fs);
%plot
plot(handles.timeLine,[get(hObject,'Value') get(hObject,'Value')],get(handles.waveAxis,'Ylim'),'Color','r');
set(handles.timeLine,'Color','None','XTick',[],'YTick',[],'XTickLabel',[],'YTickLabel',[]);
set(handles.timeLine,'Xlim',get(handles.waveAxis,'Xlim'),'Ylim',get(handles.waveAxis,'Ylim'));
handles.lineSample=handles.audioPlayer.CurrentSample;
handles.track=false;
handles.timer = timer('ExecutionMode','fixedRate',...
    'Period', 0.05,...
    'TimerFcn', {@GUIUpdate,handles});
stop(handles.timer);
guidata(hObject,handles);


% --- Executes on selection change in popUpMode.
function popUpMode_Callback(hObject, eventdata, handles)
% hObject    handle to popUpMode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popUpMode contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popUpMode


% --- Executes during object creation, after setting all properties.
function popUpMode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popUpMode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
