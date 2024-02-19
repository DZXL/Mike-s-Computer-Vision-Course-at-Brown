% Initialize
run('vl_setup');

% 1. Read images
img1 = imread('img1.png');
img2 = imread('img2.png');

% 2. Extract features using your corner detector
corners1 = corner_detector(single(img1));
corners2 = corner_detector(single(img2));

% 3. Apply homography transformations
H = load('H_1to2.txt'); % Load given homography matrix

homogeneous_corners1 = [corners1(:, 1:2)'; ones(1, size(corners1, 1))];
transformed_corners1 = H * homogeneous_corners1;
transformed_corners1 = transformed_corners1 ./ transformed_corners1(3, :);

% 4. Matching features based on Euclidean distance (as an example)
threshold_distance = 2;
matched_pairs = [];

for i = 1:size(transformed_corners1, 2)
    x = transformed_corners1(1, i);
    y = transformed_corners1(2, i);
    distances = sqrt((corners2(:, 1) - x).^2 + (corners2(:, 2) - y).^2);
    
    [min_distance, index] = min(distances);
    
    if min_distance < threshold_distance
        matched_pairs = [matched_pairs; i, index];
    end
end

% Compute repeatability rate
num_correspondences = size(matched_pairs, 1);
num_left_features = size(corners1, 1);
repeatability_rate = num_correspondences / num_left_features;

fprintf('Repeatability rate: %f\n', repeatability_rate);
% Display the images and matched points
figure;
imshow(cat(2, img1, img2)); hold on;

% Plot points from both images
plot(corners1(:, 1), corners1(:, 2), 'ro');
plot(corners2(:, 1) + size(img1, 2), corners2(:, 2), 'go');
%plot(transformed_corners1(1, :) + size(img1, 2), transformed_corners1(2, :), 'r+');
figure;
imshow(img2);

hold on;
plot(transformed_corners1(1,matched_pairs(:, 1)),transformed_corners1(2,matched_pairs(:, 1)), 'r+');
hold on;
plot(corners2(matched_pairs(:, 2), 1),corners2(matched_pairs(:, 2), 2), 'go');


title('Feature points and matches');
legend('Image 1 Corners', 'Image 2 Corners');
