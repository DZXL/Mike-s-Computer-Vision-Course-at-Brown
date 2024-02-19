% 1. Resize the images
img1_raw = imread('1.jpg');
img2_raw = imread('2.jpg');
img1 = imresize(img1_raw, 0.25);
img2 = imresize(img2_raw, 0.25);
K = load('CalibrationMatrix.mat').K;

% 2. Estimate the Essential Matrix using RANSAC
[fa, da] = vl_sift(single(rgb2gray(img1)));
[fb, db] = vl_sift(single(rgb2gray(img2)));
[matches, scores] = vl_ubcmatch(da, db);
gamma1 = fa(1:2, matches(1, :));
gamma2 = fb(1:2, matches(2, :));
g1 = K \ [gamma1; ones(1, size(gamma1', 1))];
g2 = K \ [gamma2; ones(1, size(gamma2', 1))];
[E, inlierIdx] = Ransac4Essential(g1, g2, K);

% 3. Find valid relative poses
[U, S, V] = svd(E);
W = [0 -1 0; 1 0 0; 0 0 1];
R1 = U * W * V';
R2 = U * W' * V';
T1 = U(:, 3);
T2 = -U(:, 3);
if det(R1)<0||det(R2)<0
    E=-E;
    [U, S, V] = svd(E);
    R1 = U * W * V';
    R2 = U * W' * V';
    T1 = U(:, 3);
    T2 = -U(:, 3);
end


% Given 4 possible combinations of R and T
R_candidates = {R1, R2, R1, R2};
T_candidates = {T1, T2, T2, T1};

max_count = 0;
final_R = [];
final_T = [];

inlier1=[gamma1;ones(1,size(gamma1,2))];
inlier2=[gamma2;ones(1,size(gamma2,2))];

% depth calculation
for i = 1:4
    R_temp = R_candidates{i};
    T_temp = T_candidates{i};
    count = 0;
    for j = 1:size(inlierIdx, 2)
        y1 = K'*inlier1(:, inlierIdx(j));
        y2 = K'*inlier2(:, inlierIdx(j));
        
        A = [-R_temp * y1, y2];
        depth = pinv(A) * T_temp; 
        
        rho1 = depth(1);
        rho2 = depth(2);
        % check if two depth positive
        if rho1 > 0 && rho2 > 0
            count = count + 1;
        end
    end
    
    if count > max_count
        max_count = count;
        final_R = R_temp;
        final_T = T_temp;
    end
end


% Final selected R and T
R = final_R;
T = final_T;

% 4. Densify matched points
[denseMatchImg1, denseMatchImg2, denseInlierIndx] = Densification(E, K, gamma1, gamma2, inlierIdx, img1_raw);
% 5. Triangulation

num_inliers = size(denseInlierIndx,2);
finalPoints = zeros(num_inliers, 3);  % 3D points matrix
three_point1= zeros(num_inliers, 3);
three_point2= zeros(num_inliers, 3);
colors = zeros(num_inliers, 3);  % 3D points from second image
    % RGB colour matrix from second image

for j = 1:num_inliers
    y1 = denseMatchImg1(:, denseInlierIndx(j));
    y2 = denseMatchImg2(:, denseInlierIndx(j));
        
    A = [-R * y1, y2];
    depth = pinv(A) * T; 
        
    rho1 = depth(1);
    rho2 = depth(2);
    
    three_point1(j,:) = rho1 .* y1;  
    three_point2(j,:) = rho2 .* y2;
    
    y1_in2=R*y1+T;
    
    finalPoint=(y1_in2'+y2')/2;
    finalPoints(j,:)=finalPoint';

    colors(j,:) = double(squeeze(img2(y2(2),y2(1),:))')/255;

end

% Display results
figure;
scatter3(finalPoints(:,1), finalPoints(:,2), finalPoints(:,3), 50, colors, 'filled');
title('Reconstructed 3D Points with Colour from second Image');
xlabel('X');
ylabel('Y');
zlabel('Z');
axis equal;

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



