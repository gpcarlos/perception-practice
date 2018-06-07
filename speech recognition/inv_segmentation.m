% Function inv_segmentation
%
% Process inverse to segmentation.
%
% segments: signal segment
% displ: displacement between each segment

function word = inv_segmentation(segments, displ)
    word = [];
    for i=1:size(segments,2)
        word = [word; segments(1:displ,i)];
    end
end
