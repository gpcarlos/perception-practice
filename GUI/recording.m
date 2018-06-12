% -- Signal Capture --
% Function recording
%
% Quantification, acquisition and sampling of the audio signal.
%
% t: recording time (seconds)
% Fs: sampling frequency
% Ch: channel. 1 = mono, 2 = stereo
% num_bits: number of bits to store each sample

function signal = recording(t, Fs, Ch, num_bits, handles)
    recObj = audiorecorder(Fs, num_bits, Ch);
    msg = sprintf('Countdown...'); 
    set(handles.text1,'String',msg); pause(1)
    msg = sprintf('Countdown...\n3...'); 
    set(handles.text1,'String',msg); pause(1)
    msg = sprintf('Countdown...\n3...\n2...');  
    set(handles.text1,'String',msg); pause(1)
    msg = sprintf('Countdown...\n3...\n2...\n1...'); 
    set(handles.text1,'String',msg); pause(1)
    msg = sprintf('Countdown...\n3...\n2...\n1...\nStart speaking');
    set(handles.text1,'String',msg);
    recordblocking(recObj,t);
    msg = sprintf('Countdown...\n3...\n2...\n1...\nStart speaking\nEnd of recording');
    set(handles.text1,'String',msg); pause(1)
    signal = getaudiodata(recObj);
end