% Initialize an image list and a list for storing features
image_files = {'1.png', '2.png', '3.png', '4.png', '5.png'};
num_images = length(image_files);
features = cell(1, num_images);

% For each image, extract features using the corner_detector
for i = 1:num_images
    I = imread(image_files{i});
    corners = corner_detector(I);
    features{i} = corners(:, 1:2)'; % Transpose for consistency with previous format
end

% Sort the corners of the first image and take the top 20 strongest corners
corners_1 = corner_detector(imread(image_files{1}));
[~, sorted_indices] = sort(corners_1(:, 3), 'descend');
strongest_features = corners_1(sorted_indices(1:10), 1:2)';

% Update the first entry of features to include only the strongest corners
features{1} = strongest_features;

% Initialize canvas and display the first image
figure; imshow(uint8(imread(image_files{1}))); hold on; title('using corner detector');

% Starting from the first image, find matches for each corner in the subsequent images
num_features = size(features{1}, 2);
colors = jet(num_features);

for j = 1:num_features
    current_feature = features{1}(1:2, j);
    survived = true; % Flag to mark if the corner found matches in all images
    track_positions = current_feature;

    for k = 2:num_images
        % Use Euclidean distance to find the nearest corner
        distances = sqrt(sum((features{k} - current_feature).^2, 1));
        [min_distance, index] = min(distances);

        if min_distance > 100 % Set a threshold, adjust as needed
            survived = false;
            break; % Current corner didn't find a match in the subsequent images
        end
        
        next_feature = features{k}(1:2, index);
        track_positions = [track_positions, next_feature];
        
        % Update current corner for the next loop
        current_feature = next_feature;
    end

    if survived
        % If the corner found matches in all images, plot its trajectory
        plot(track_positions(1, :), track_positions(2, :), '-o', 'Color', colors(j, :));
    end
end

hold off;
