run('vl_setup');
% 1. Extract SIFT features from the left and right images.
I1_color = imread('img1.png');
I2_color = imread('img2.png');

% Convert images to grayscale if they are RGB
if size(I1_color, 3) == 3
    I1_gray = rgb2gray(I1_color);
else
    I1_gray = I1_color;
end

if size(I2_color, 3) == 3
    I2_gray = rgb2gray(I2_color);
else
    I2_gray = I2_color;
end

% Convert grayscale images to SINGLE class
I1 = single(I1_gray);
I2 = single(I2_gray);

[f1, d1] = vl_sift(I1, 'PeakThresh', 25, 'EdgeThresh', 30);
[f2, d2] = vl_sift(I2, 'PeakThresh', 25, 'EdgeThresh', 30);

% 2. Apply the homography matrix
H = load('H_1to2.txt'); % Load the provided homography matrix

% Convert feature points to homogeneous coordinates
homogeneous_f1 = [f1(1:2, :); ones(1, size(f1, 2))];
transformed_f1 = H * homogeneous_f1;

% Convert back from homogeneous coordinates to Cartesian coordinates
transformed_f1 = transformed_f1 ./ transformed_f1(3, :);

% 3. Find the closest features and remove those beyond the image boundaries
threshold_distance = 2;
[matches, scores] = vl_ubcmatch(d1, d2);

% 4. Calculate repeatability
num_correspondences = length(matches);
num_left_features = size(f1,2);
repeatability_rate = num_correspondences / num_left_features;

fprintf('Repeatability rate: %f\n', repeatability_rate);

% Plot the matched features and connecting lines
matched_f1 = f1(1:2, matches(1, :));
matched_f2 = f2(1:2, matches(2, :));

% Create a composite image
I3 = cat(2, uint8(I1), uint8(I2));

figure; imshow(I3); 
hold on;
plot(matched_f1(1, :), matched_f1(2, :), 'ro');
plot(matched_f2(1, :) + size(I1, 2), matched_f2(2, :), 'bo');

for i = 1:size(matched_f1, 2)
    line([matched_f1(1, i), matched_f2(1, i) + size(I1, 2)], ...
         [matched_f1(2, i), matched_f2(2, i)], 'Color', 'g');
end

hold off;
