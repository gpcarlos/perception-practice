% -- Preprocessing --
% Function pre_emphasis
%
% Applies the pre-emphasis filter to reduce the dynamic range.
% Voice signal dims as the frequency increases.
%
% signal: audio signal
% a: pre-emphasis degree. It is usually in the range 0.9 to 1.0  

function signal = pre_emphasis(signal, a)
    signal = filter([1 -a], 1, signal);
end