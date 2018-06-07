% -- Preprocessing --
% Function windowing
%
% Apply a window to the segments
%
% segments: signal segments
% window: 'rectangular', 'hamming' or 'hanning'

function segments_windowed = windowing(segments, window)
    switch window
        case 'rectangular'
            win = rectwin(size(segments,1));
        case 'hamming'
            win = hamming(size(segments,1));
        case 'hanning'
            win = hanning(size(segments,1));
        otherwise
            disp('wrong window!!!')
    end
    win = repmat(win,1,size(segments,2));
    segments_windowed = segments.*win;
end