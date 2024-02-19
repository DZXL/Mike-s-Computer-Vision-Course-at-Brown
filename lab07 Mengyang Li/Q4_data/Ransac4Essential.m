function [finalE, inlierIdx] = Ransac4Essential(gamma1, gamma2, K)
    % Set parameters
    numIterations = 1000; % This is a predefined number of iterations, adjustable as needed
    threshold = 2; % As you mentioned, using 2 pixels as the threshold
    maxInliers = 0; % To store the maximum number of inliers
    finalE = []; % Final essential matrix
    inlierIdx = []; % Indices of the inliers

    for i = 1:numIterations
        % Randomly select 5 pairs of matched points
        idx = randperm(size(gamma1, 2), 5);
        samplePoints1 = gamma1(:, idx);
        samplePoints2 = gamma2(:, idx);

        % Compute the essential matrix using your fivePointAlgorithmSelf function
        Es_cell = fivePointAlgorithmSelf(cat(3, samplePoints1', samplePoints2'));

        % Iterate over all returned essential matrices
        for j = 1:length(Es_cell)
            E = Es_cell{j}; % Extract the essential matrix from the cell array
            % Compute the epipolar lines
            l = E * gamma1;
            % Compute distances to the epipolar lines
            d = sum((gamma2 .* l) ./ sqrt(l(1, :).^2 + l(2, :).^2), 1);
            inliers = abs(d) < threshold;

            % Check if more inliers are found
            if sum(inliers) > maxInliers
                maxInliers = sum(inliers);
                finalE = E;
                inlierIdx = find(inliers);
            end
        end
    end
end
