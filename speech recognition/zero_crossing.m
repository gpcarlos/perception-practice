% -- Characteristics Extraction --
%          (time domain)
% Function zero_crossing
%
% Indicate the number of times a continuous signal takes the zero value

function output = zero_crossing(segments, window)
    segments = abs(sign(segments(1:end-1,:))-sign(segments(2:end,:)))./2;
    window = repmat(window,1,size(segments,2));
    output = (segments'*window)./size(segments,2);
    output = output(:,1);
end