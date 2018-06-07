% -- Recognition technique --
% Function dtwGlobal
%
% Dynamic Time Warping. Global restrictions
%
% pattern: word to compare
% test: word to test
% w: window

function error = dtwGlobal(pattern, test, w)
    D = ones(size(pattern,2)+1, size(test,2)+1) * Inf; 
    D(1,1) = 0;
    
    w = max(w,abs(size(D,1)-size(D,2)));

    for i=2:size(D,1)
        for j=max(2,i-w):min(size(D,2),i+w)
            dist = d_euclid(pattern(:,i-1),test(:,j-1));
            D(i,j) = dist + min(min(D(i-1,j),D(i,j-1)), ... 
                D(i-1,j-1));
        end
    end
    
    error = D(end,end);
end