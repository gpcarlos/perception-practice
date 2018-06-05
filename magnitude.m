% -- Characteristics Extraction --
%          (time domain)
% Function magnitude
%
% Alternative to energy.
% Lower dynamic range and lower complexity.

function output = magnitude(segments, window)
    window = repmat(window,1,size(segments,2));
    output = abs(segments')*window;
    output = output(:,1);
end