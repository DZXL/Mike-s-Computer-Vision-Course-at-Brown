
img1 = imread('img1.png');
img2 = imread('img2.png');

img1_gray = (img1);
img2_gray = (img2);


corners1 = corner(img1_gray, 'Harris');
corners2 = corner(img2_gray, 'Harris');

window_sz = 9; 

descriptor_types = {'pixels', 'pixels', 'histogram'};
similarity_types = {'SSD', 'NCC', 'Chi-Square'};

H = load('H_1to2.txt');  

for idx = 1:length(descriptor_types)
    descriptor_type = descriptor_types{idx};
    similarity_type = similarity_types{idx};

    D1 = region_descriptors(img1_gray, corners1, window_sz, descriptor_type);
    D2 = region_descriptors(img2_gray, corners2, window_sz, descriptor_type);

    [indx_1st_best, indx_2nd_best, simi_1st_best, simi_2nd_best] = find_matches(D1, D2, similarity_type);

    % Bidirectional consistency
    [indx_1st_best_reverse, ~, ~, ~] = find_matches(D2, D1, similarity_type);
    bidirectional_matches = (indx_1st_best_reverse(indx_1st_best) == (1:length(indx_1st_best))');

    % Unique correspondence
    unique_matches = true(size(indx_1st_best));
    [~, unique_ind] = unique(indx_1st_best, 'stable');
    non_unique = setdiff(1:length(indx_1st_best), unique_ind);
    for ni = non_unique
        if simi_1st_best(ni) > simi_1st_best(unique_ind(indx_1st_best(ni) == indx_1st_best(unique_ind)))
            unique_matches(ni) = false;
        end
    end

    alpha = 0.7;  
    valid_matches = simi_1st_best < alpha * simi_2nd_best & bidirectional_matches & unique_matches;

    matches1 = corners1(valid_matches, :);
    matches2 = corners2(indx_1st_best(valid_matches), :);

    % Visualization
    N = min(10, sum(valid_matches));
    visualize_matches(img1_gray, img2_gray, matches1, matches2, N);
    title([descriptor_type ' vs ' similarity_type]);  % title

    % accuracy
    correct_matches = 0;
    for i = 1:size(matches1, 1)
        transformed_point = H * [matches1(i, :) 1]';
        transformed_point = transformed_point(1:2) / transformed_point(3); 
        dist = norm(transformed_point - matches2(i, :)');
        if dist <= 200  % threshold
            correct_matches = correct_matches + 1;
        end
    end

    % accuracy
    accuracy = correct_matches / size(matches1, 1);
    fprintf('Accuracy for %s vs %s: %f\n', descriptor_type, similarity_type, accuracy);
end
