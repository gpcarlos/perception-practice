function varargout = speech(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @speech_OpeningFcn, ...
                   'gui_OutputFcn',  @speech_OutputFcn, ...
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

global t Fs Ch num_bits num_samples displ words dtw_ num_words b

t = 2; Fs = 8000; Ch = 1;
num_bits = 16; num_samples = 100;
displ = round(num_samples*0.75);

words = {'Forward', 'Back', 'Left', 'Right', 'Stop', 'Image'};
dtw_ = 'local'; % 'local' or 'global'
num_words = size(words,2);

% --- Executes just before speech is made visible.
function speech_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);


function varargout = speech_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


% --- Executes on button press in TRAINING
function pushbutton1_Callback(hObject, eventdata, handles)

    global t Fs Ch num_bits num_samples displ words num_words pattern

    for i=1:num_words
        msg = sprintf('--- Pattern Word (%s) ---\n',words{i});
        set(handles.text,'String',msg)
        signal = recording(t, Fs, Ch, num_bits, handles);
        % Preprocessing
        signal = pre_emphasis(signal, 0.95);
        segments = segmentation(signal, num_samples, displ);
        segments_word = start_end(segments, 60);
        % Characteristics extraction
        pattern{i} = getCharacteristics(segments_word);
    end
    
    msg = sprintf(' '); set(handles.text,'String',msg)
    set(handles.text1,'String',msg)
  

% --- Executes on button press in TEST
function pushbutton2_Callback(hObject, eventdata, handles)

    global t Fs Ch num_bits num_samples dtw_ displ num_words pattern b
    
    msg = sprintf('--- Test Word ---'); set(handles.text,'String',msg)
    
    signal = recording(t, Fs, Ch, num_bits, handles);
    % Preprocessing
    signal = pre_emphasis(signal, 0.95);
    segments = segmentation(signal, num_samples, displ);
    segments_word = start_end(segments, 60);
    % Characteristics extraction
    test = getCharacteristics(segments_word);
    
    % Dynamic Time Warping
    for nump=1:num_words
        switch dtw_
            case 'local'
                errors(nump) = dtwLocal(pattern{nump}, test);
            case 'global'
                errors(nump) = dtwGlobal(pattern{nump}, test, 0);
        end
    end
    
    % Move the robot
    [~, class] = min(errors);
    if class < 5
        moveRobot(b,class);
    else
       disp('Stop or Image');
    end
    
    msg = sprintf(' '); set(handles.text,'String',msg)
    set(handles.text1,'String',msg)


% --- Executes on button press in checkbox. DTW
function checkbox_Callback(hObject, eventdata, handles)

    global dtw_
    
    if get(hObject,'Value')
        dtw_ = 'local';
    else
        dtw_ = 'global';
    end
