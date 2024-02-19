function D = region_descriptors(image, corners, window_sz, descriptor_type)
    
    num_corners = size(corners, 1);
    half_sz = floor(window_sz / 2);
    
    % Pad the image to handle corners near the borders
    padded_image = padarray(image, [half_sz half_sz], 'symmetric');
    
    % Adjust corner coordinates due to padding
    corners = corners + half_sz;
    
    if strcmp(descriptor_type, 'pixels')
        D = zeros(num_corners, window_sz * window_sz);
    elseif strcmp(descriptor_type, 'histogram')
        D = zeros(num_corners, 32); % assuming 8-bit grayscale images for the histogram
    else
        error('Unknown descriptor type');
    end
    
    for i = 1:num_corners
        x = corners(i, 1);
        y = corners(i, 2);
        
        % Extract window from the padded image
        window = padded_image(y-half_sz:y+half_sz, x-half_sz:x+half_sz);
        
        if strcmp(descriptor_type, 'pixels')
            D(i, :) = window(:)';
        elseif strcmp(descriptor_type, 'histogram')
            % Normalize pixel intensities in the window by subtracting the mean
            normalized_window = double(window) - mean(window(:));
            normalized_window = normalized_window / norm(normalized_window);
            % Create histogram
            D(i, :) = histcounts(normalized_window, 32, 'Normalization', 'probability');
        end
    end
    
end
