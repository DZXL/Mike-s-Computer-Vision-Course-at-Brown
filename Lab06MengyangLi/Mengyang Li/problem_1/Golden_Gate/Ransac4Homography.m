function finalH = Ransac4Homography(matches1, matches2)
    numMatches = size(matches1, 1);
    maxInliers = 0;
    finalH = [];
    
    for i = 1:1000 % Set the number of iterations at least 1000.
        % (a) Pick 4 random candidate correspondences
        indices = randperm(numMatches, 4);
        p1 = matches1(indices,:);
        p2 = matches2(indices,:);
        
        % Compute the homography matrix
        H = computeHomography(p1, p2);
        
        % (b) Transform all features using the computed homography
        inliers = 0;
        for j = 1:numMatches
            transformed_point = H * [matches1(j, :) 1]';
            transformed_point = transformed_point(1:2) / transformed_point(3); % Homogenize
            dist = norm(transformed_point - matches2(j, :)');
            if dist <= 1 % 1 pixel threshold
                inliers = inliers + 1;
            end
        end
        
        if inliers > maxInliers
            maxInliers = inliers;
            finalH = H;
        end
    end
end
