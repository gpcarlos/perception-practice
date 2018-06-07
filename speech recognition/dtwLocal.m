% -- Recognition technique --
% Function dtwLocal
%
% Dynamic Time Warping. Local restrictions
%
% pattern: word to compare
% test: word to test

function error = dtwLocal(pattern, test)
    D = zeros(size(pattern,2)+1, size(test,2)+1);
    D(2:end,1) = Inf; D(1,2:end) = Inf; D(1,1) = 0;

    for i=2:size(D,1)
        for j=2:size(D,2)
            dist = d_euclid(pattern(:,i-1),test(:,j-1));
            D(i,j) = dist + min(min(D(i-1,j),D(i,j-1)), ... 
                D(i-1,j-1));
        end
    end
    
    error = D(end,end);
end