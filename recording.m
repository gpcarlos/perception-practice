% -- Signal Capture --
% Function recording
%
% Quantification, acquisition and sampling of the audio signal.
%
% t: recording time (seconds)
% Fs: sampling frequency
% Ch: channel. 1 = mono, 2 = stereo
% num_bits: number of bits to store each sample

function signal = recording(t, Fs, Ch, num_bits)
    recObj = audiorecorder(Fs, num_bits, Ch);
    disp('Countdown...'), pause(1), disp('3...'), pause(1)
    disp('2...'), pause(1), disp('1...'), pause(1)
    disp('Start speaking')
    recordblocking(recObj,t);
    disp('End of recording')
    signal = getaudiodata(recObj);
end