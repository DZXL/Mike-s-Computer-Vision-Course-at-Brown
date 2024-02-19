% Initialize
run('vl_setup');

% Read images
img1 = imread('img1.png');
img2 = imread('img2.png');

% Convert images to single precision grayscale (VLFeat requirement)
I1 = single(rgb2gray(img1));
I2 = single(rgb2gray(img2));

% Detect and extract SIFT keypoints and descriptors
[f1, d1] = vl_sift(I1);
[f2, d2] = vl_sift(I2);

% Use Lowe's test ratio for filtering matches
[matches, scores] = vl_ubcmatch(d1, d2, 0.9);


[~, sortedIndices] = sort(scores, 'ascend');
bestMatches = matches(:, sortedIndices(1:10));


figure; 

imshowpair(img1, img2, 'montage');
hold on;


plot(f1(1, bestMatches(1, :)), f1(2, bestMatches(1, :)), 'bo');
plot(f2(1, bestMatches(2, :)) + size(I1, 2), f2(2, bestMatches(2, :)), 'bo');
title('VlFeat');
line([f1(1, bestMatches(1, :)); f2(1, bestMatches(2, :)) + size(I1, 2)], ...
     [f1(2, bestMatches(1, :)); f2(2, bestMatches(2, :))], 'Color', 'r');

% Calculate accuracy using H matrix
H = load('H_1to2.txt');  % Load transformation matrix
correct_matches = 0;
for i = 1:size(bestMatches, 2)
    transformed_point = H * [f1(1:2, bestMatches(1, i)); 1];
    transformed_point = transformed_point(1:2) / transformed_point(3); % Homogenize
    dist = norm(transformed_point - f2(1:2, bestMatches(2, i)));
    if dist <= 200  % Threshold for match
        correct_matches = correct_matches + 1;
    end
end
% Compute accuracy
accuracy = correct_matches / size(bestMatches, 2);
fprintf('Accuracy for SIFT matches: %f\n', accuracy);
