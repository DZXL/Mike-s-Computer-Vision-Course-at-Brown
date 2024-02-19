function topCorners = selectTopCorners(corners, M)
    % 对corners按响应值R进行排序
    [~, sortedIndices] = sort(corners(:, 3), 'descend');

    
    % 选择前M个具有最高响应值的角点
    topIndices = sortedIndices(1:min(M, length(sortedIndices)));
    
    % 输出这些角点
    topCorners = corners(topIndices, :);
end
