% -- Preprocessing --
% Function segmentation
%
% Partition the signal into data segments
%
% signal: audio signal
% num_samples: number of samples
% displ: displacement between each segment

function segments = segmentation(signal, num_samples, displ)
    segments = buffer(signal, num_samples, ...
        num_samples-displ, 'nodelay');
    % overlap: num_samples-displ
end