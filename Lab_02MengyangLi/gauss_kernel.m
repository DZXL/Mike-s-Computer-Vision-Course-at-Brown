function [filter] = gauss_kernel(filter_size, sigma)
    [x, y] = meshgrid(-floor(filter_size/2):floor(filter_size/2),...
        -floor(filter_size/2):floor(filter_size/2));
    filter = exp(-(x.^2 + y.^2) / (2 * sigma^2));
    
    % Normalize
    filter = filter / sum(filter(:));
end


