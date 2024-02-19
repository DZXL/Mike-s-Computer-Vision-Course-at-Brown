% Initialization
run('vl_setup');

% Initialize a list of images and a list to store features
image_files = {'1.png', '2.png', '3.png', '4.png', '5.png'};
num_images = length(image_files);
features = cell(1, num_images);
descriptors = cell(1, num_images);

% For each image, extract SIFT features
for i = 1:num_images
    I = imread(image_files{i});
    if size(I, 3) == 3
        I = rgb2gray(I);
    end
    I = single(I);
    [f, d] = vl_sift(I, 'PeakThresh', 8, 'EdgeThresh', 25);
    features{i} = f;
    descriptors{i} = d;
end

% Initialize a canvas and display the first image
figure; imshow(uint8(imread(image_files{1}))); hold on; title('use vl');

% Starting from the first image, find matches for each feature in subsequent images
num_features = size(features{1}, 2);
colors = jet(20); % Generate 20 different colors
for j = 1:min(20, num_features)
    current_feature = features{1}(1:2, j);
    current_descriptor = descriptors{1}(:, j);
    survived = true; % Mark whether this feature has found matches in all images

    track_positions = current_feature;

    for k = 2:num_images
        [match, ~] = vl_ubcmatch(current_descriptor, descriptors{k});
        
        if isempty(match)
            survived = false;
            break; % Current feature did not find a match in subsequent images
        end
        
        next_feature = features{k}(1:2, match(2));
        track_positions = [track_positions, next_feature];
        
        % Update current feature and descriptor for next iteration
        current_feature = next_feature;
        current_descriptor = descriptors{k}(:, match(2));
    end

    if survived
        % If the feature found matches in all images, draw its trajectory
        plot(track_positions(1, :), track_positions(2, :), '-o', 'Color', colors(j, :));
    end
end

hold off;
