% -- Characteristics Extraction --
%          (time domain)
% Function energy
%
% It allows us to distinguish reliably:
%   - The voice and the silence 
%   - The deaf sounds and the sounds

function output = energy(segments, window)
    window = repmat(window,1,size(segments,2));
    output = (segments'.^2)*(window.^2);
    output = output(:,1);
end