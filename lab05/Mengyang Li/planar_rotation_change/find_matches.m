function [indx_1st_best, indx_2nd_best, simi_1st_best, simi_2nd_best] = find_matches(D1, D2, similarity_type)

    numD1 = size(D1, 1);
    indx_1st_best = zeros(numD1, 1);
    indx_2nd_best = zeros(numD1, 1);
    simi_1st_best = zeros(numD1, 1);
    simi_2nd_best = zeros(numD1, 1);

    for i = 1:numD1
        descriptor = D1(i, :);
        if strcmp(similarity_type, 'SSD') % Sum of Squared Distance
            distances = sum((D2 - descriptor).^2, 2);
            [sortedDistances, sortedIndices] = sort(distances, 'ascend');
            
        elseif strcmp(similarity_type, 'NCC') % Normalized Cross Correlation
            meanD1 = mean(descriptor);
            meanD2 = mean(D2, 2);
            ncc = sum((meanD2-D2) .* (descriptor - meanD1), 2) ./ (norm(descriptor - meanD1) .* sqrt(sum((D2 - meanD2).^2, 2)));
            [sortedDistances, sortedIndices] = sort(ncc, 'ascend');
            
        elseif strcmp(similarity_type, 'Chi-Square') % Chi-Square Distance for histograms
            normalizedD2 = D2 ./ sum(D2, 2);
            normalizedDesc = descriptor / sum(descriptor);
            chiSquareDist = 0.5 * sum(((normalizedD2 - normalizedDesc).^2) ./ (normalizedD2 + normalizedDesc + 1e-10), 2);
            [sortedDistances, sortedIndices] = sort(chiSquareDist, 'ascend');
            
        else
            error('Unknown similarity type');
        end
        
        indx_1st_best(i) = sortedIndices(1);
        indx_2nd_best(i) = sortedIndices(2);
        simi_1st_best(i) = sortedDistances(1);
        simi_2nd_best(i) = sortedDistances(2);
    end
end
