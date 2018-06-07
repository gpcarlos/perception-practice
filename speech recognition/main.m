clear all, close all

t = 2; Fs = 8000; Ch = 1;
num_bits = 16; num_samples = 100;
displ = round(num_samples*0.75);

words = {'Forward', 'Back', 'Left', 'Right', 'Stop', 'Image'};
wordstest= { 'Stop', 'Right', 'Image', 'Forward', 'Left', 'Back'};
dtw_ = 'local'; % 'local' or 'global'
num_words = size(words,2);

recordType = {'Patterns recording', 'Tests recording'};
for k=recordType
    disp('------------------'); disp(k{1}); disp('------------------');
    for i=1:num_words
        switch k{1}
            case 'Patterns recording'
                fprintf('--- Pattern Word %d (%s) ---\n',i,words{i});
            case 'Tests recording'
                fprintf('--- Test Word %d (%s) ---\n',i,wordstest{i});
        end
        
        signal = recording(t, Fs, Ch, num_bits);

        % Preprocessing
        signal = pre_emphasis(signal, 0.95);
        segments = segmentation(signal, num_samples, displ);
        segments_word = start_end(segments, 60);

        % Characteristics extraction
        switch k{1}
            case 'Patterns recording'
                pattern{i} = getCharacteristics(segments);
            case 'Tests recording'
                test{i} = getCharacteristics(segments);
        end
    end
end

% Dynamic Time Warping
for nump=1:num_words
    for numt=1:num_words
        switch dtw_
            case 'local'
                errors(nump,numt) = dtwLocal(pattern{nump}, test{numt});
            case 'global'
                errors(nump,numt) = dtwGlobal(pattern{nump}, test{numt}, 0);
        end
    end
end

[~, class] = min(errors);
disp(words(class))
disp('Should be:')
disp(wordstest)
