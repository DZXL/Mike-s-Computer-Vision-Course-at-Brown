function [output] = NL_conv(image, filter,cmd)

    [ImageH, ImageW] = size(image);
    [FilterH, FilterW] = size(filter);
    PadHeight = floor(FilterH / 2);
    PadWidth = floor(FilterW / 2);

    % Initialize the output(same size with ori)
    output = zeros(ImageH, ImageW);

    % zero-padding around
    Image = padarray(image, [PadHeight, PadWidth]);

    % Convolution
    for i = 1 : ImageH
        for j = 1 : ImageW
            
            Region = Image(i : i + FilterH - 1, j : j + FilterW - 1);

            % Perform element-wise multiplication and sum
            if strcmp( cmd, 'max')
                output(i, j) = max(Region(:));
            elseif strcmp( cmd, 'min')
                output(i, j) = min(Region(:));
            elseif strcmp( cmd, 'median')
                output(i, j) = median(Region(:));    
            end
        end
    end
end
