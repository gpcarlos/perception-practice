clear all, close all

addpath('../speech recognition');

b = establishConnection;

t = 2; Fs = 8000; Ch = 1;
num_bits = 16; num_samples = 100;
displ = round(num_samples*0.75);

words = {'Forward', 'Back', 'Left', 'Right', 'Stop', 'Image'};
dtw_ = 'local'; % 'local' or 'global'
num_words = size(words,2);


fprintf('------------------\nPatterns recording\n------------------\n');
for i=1:num_words
    fprintf('--- Pattern Word %d (%s) ---\n',i,words{i});   
    signal = recording(t, Fs, Ch, num_bits);
    % Preprocessing
    signal = pre_emphasis(signal, 0.95);
    segments = segmentation(signal, num_samples, displ);
    segments_word = start_end(segments, 60);
    % Characteristics extraction
    pattern{i} = getCharacteristics(segments);
end

while true
    fprintf('--- Test Word ---\n');
        
    signal = recording(t, Fs, Ch, num_bits);
    % Preprocessing
    signal = pre_emphasis(signal, 0.95);
    segments = segmentation(signal, num_samples, displ);
    segments_word = start_end(segments, 60);
    % Characteristics extraction
    test = getCharacteristics(segments);
    
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
    moveRobot(b, class);
    disp('***** Press any key to test another word *****');
    pause
end