% Load the images
img1 = imread('1.png');
img2 = imread('2.png');
K=load('Calibration_Matrix.mat').K;
load('E_1to2.mat', 'E');
E1to2 = inv(K')*E*inv(K);
E2to1 = E1to2'; % Directly obtain E2to1 using transpose

% Detect SIFT keypoints using VLFeat
[f1, d1] = vl_sift(single(rgb2gray(img1)));
[f2, d2] = vl_sift(single(rgb2gray(img2)));

% Match SIFT descriptors
[matches, scores] = vl_ubcmatch(d1, d2, 0.9);

[~, sortedIndices] = sort(scores, 'ascend');
top_matches = matches(:, sortedIndices(1:20));

% Begin plotting the images and corresponding epipolar lines
figure;

% Plot img1 and the epipolar lines corresponding to img2
subplot(1,2,1);
imshow(img1);
hold on;
for i = 1:size(top_matches, 2)
    plot(f1(1, top_matches(1, i)), f1(2, top_matches(1, i)), 'ro');
    drawEpipolarLines(E2to1, [f2(1:2, top_matches(2, i)); 1], size(img1));
end
hold off;

% Plot img2 and the epipolar lines corresponding to img1
subplot(1,2,2);
imshow(img2);
hold on;
for i = 1:size(top_matches, 2)
    plot(f2(1, top_matches(2, i)), f2(2, top_matches(2, i)), 'ro');
    drawEpipolarLines(E1to2, [f1(1:2, top_matches(1, i)); 1], size(img2));
end
hold off;

% 4. Calculate reprojection errors
reprojection_errors1 = zeros(1, size(top_matches, 2));
reprojection_errors2 = zeros(1, size(top_matches, 2));

for i = 1:size(top_matches, 2)
    % For points in img1
    x = f1(1, top_matches(1, i));
    y = f1(2, top_matches(1, i));
    line_coeffs = E2to1 * [f2(1:2, top_matches(2, i)); 1];
    A = line_coeffs(1);
    B = line_coeffs(2);
    C = line_coeffs(3);
    reprojection_errors1(i) = abs(A*x + B*y + C) / sqrt(A^2 + B^2);
    
    % For points in img2
    x = f2(1, top_matches(2, i));
    y = f2(2, top_matches(2, i));
    line_coeffs = E1to2 * [f1(1:2, top_matches(1, i)); 1];
    A = line_coeffs(1);
    B = line_coeffs(2);
    C = line_coeffs(3);
    reprojection_errors2(i) = abs(A*x + B*y + C) / sqrt(A^2 + B^2);
end

% Define a 2-pixel threshold
threshold = 2;
inliers1 = reprojection_errors1 < threshold;
inliers2 = reprojection_errors2 < threshold;

% Calculate the ratio of outliers
outliers_ratio = 1 - sum(inliers1 & inliers2) / size(top_matches, 2);
disp(['Outliers ratio: ', num2str(outliers_ratio)]);
