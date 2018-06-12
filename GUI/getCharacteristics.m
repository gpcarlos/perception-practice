% -- Characteristics extraction --
% Function getCharacteristics
%
% Characteristics extraction using cepstral analysis
%
% segments: signal segments

function characteristics = getCharacteristics(segments)

    segments_windowed = windowing(segments, 'hamming');
    
    %% Cepstrum
    ceps = rceps(segments_windowed);
    ceps_coeff = ceps(2:13,:);
    
    %% Delta Cepstrum
    p = 10;
    mask = -p:p;
    extended_mask = repmat(mask,size(ceps_coeff,1),1);
    extended_coeff = [zeros(size(ceps_coeff,1),p) ceps_coeff ... 
                      zeros(size(ceps_coeff,1),p)];              
    domain = [zeros(1,p) ones(1,size(ceps_coeff,2)) zeros(1,p)];
    
    for i=1:size(ceps_coeff,2)
        delta(:,i) = sum(extended_mask.*extended_coeff(:,i:2*p+i),2);
        delta_den = sum((mask.^2).*domain(i:2*p+i));
        delta(:,i) = delta(:,i)./delta_den;
    end
    
    %% Postprocessing
    characteristics = [ceps_coeff;delta];
    mean_=zeromean(characteristics);
    characteristics = mean_./repmat(stdpat(characteristics) ... 
        ,1,size(characteristics,2));
end