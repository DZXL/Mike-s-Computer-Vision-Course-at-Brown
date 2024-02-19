img1 = imread('img1.png');
img2 = imread('img2.png');

img1_gray = (rgb2gray(im2double(img1)));
img2_gray = (rgb2gray(im2double(img2)));

corners1 = corner(img1_gray, 'Harris');
corners2 = corner(img2_gray, 'Harris');

window_sz = 19; 

% Update descriptor and similarity types arrays
descriptor_types = {'pixels', 'pixels', 'histogram'};
similarity_types = {'SSD', 'NCC', 'Chi-Square'};

H = load('H_1to2.txt');  % Load transformation matrix

for idx = 1:length(descriptor_types)

    descriptor_type = descriptor_types{idx};
    similarity_type = similarity_types{idx};

    D1 = region_descriptors(img1_gray, corners1, window_sz, descriptor_type);
    D2 = region_descriptors(img2_gray, corners2, window_sz, descriptor_type);

    [indx_1st_best, indx_2nd_best, simi_1st_best, simi_2nd_best] = find_matches(D1, D2, similarity_type);

    alpha = 0.7;  
    valid_matches = simi_1st_best < alpha * simi_2nd_best;

    matches1 = corners1(valid_matches, :);
    matches2 = corners2(indx_1st_best(valid_matches), :);

    % Visualization
    N = min(10, sum(valid_matches));
    visualize_matches(img1_gray, img2_gray, matches1, matches2, N);
    title([descriptor_type ' vs ' similarity_type]);  % Set the title after visualizing

    % Calculate accuracy
    correct_matches = 0;
    for i = 1:size(matches1, 1)
        transformed_point = H * [matches1(i, :) 1]';
        transformed_point = transformed_point(1:2) / transformed_point(3); % Homogenize
        dist = norm(transformed_point - matches2(i, :)');
        if dist <= 300  % Threshold for match
            correct_matches = correct_matches + 1;
        end
    end
    % Compute accuracy
    accuracy = correct_matches / size(matches1, 1);
    fprintf('Accuracy for %s vs %s: %f\n', descriptor_type, similarity_type, accuracy);

end
