% Function start_end
%
% Detect the start and end of a word. 
% It is based on the Rabiner-Sambur algorithm
%
% segments: signal segments
% num_segments_noise: number of segments at the beginnig 
%                     that we consider noise

function segments_word = start_end (segments, num_segments_noise)
    %% 1 Zero crossing and Magnitude
    Z = zero_crossing(segments, rectwin(size(segments,1)-1));
    M = magnitude(segments, rectwin(size(segments,1)));

    %% 2 Zero crossing and Magnitude of the ambient noise
    Zs = Z(1:num_segments_noise);
    Ms = M(1:num_segments_noise);

    %% 3 Thresholds
    UmbSupEnrg = 0.5*max(M);
    UmbInfEnrg = mean(Ms) + 2*std(Ms);
    UmbCruCero = mean(Zs) + 2*std(Zs);

    %% 4 At this point we guarantee the presence of signal
    ln_first = find(M(num_segments_noise+1:end) > UmbSupEnrg, 1, 'first') ...
        + num_segments_noise;
    ln_last = find(M(1:size(segments,2)-num_segments_noise-1) ... 
        > UmbSupEnrg, 1, 'last');

    %% 5 It could be the beginning and end of the word
    le_first = find(M(1:ln_first) < UmbInfEnrg, 1, 'last');
    le_last = find(M(ln_last:end) < UmbInfEnrg, 1, 'first') + ln_last;
    
    %% 6.1 Find the real beginning of the word
    n = le_first; thereIsANewPoint = false; times = 0;
    while 1<n & n>=le_first-25 & ~thereIsANewPoint
        if Z(n) < UmbCruCero
            thereIsANewPoint = times>=3;
            times = 0;
        else
            times = times + 1;
        end
        n = n - 1;
    end
    
    if thereIsANewPoint 
        theBeginning = n;
    else
        theBeginning = le_first;
    end
    
    %% 6.2 Find the real end of the word
    n = le_last; thereIsANewPoint = false; times = 0;
    while n<=le_last+25 & n<length(Z) & ~thereIsANewPoint
        if Z(n) < UmbCruCero
            thereIsANewPoint = times>=3;
            times = 0;
        else
            times = times + 1;
        end
        n = n + 1;
    end
    
    if thereIsANewPoint 
        theEnd = n;
    else
        theEnd = le_last;
    end
  
    %% The return
    segments_word = segments(:,theBeginning:theEnd);
end