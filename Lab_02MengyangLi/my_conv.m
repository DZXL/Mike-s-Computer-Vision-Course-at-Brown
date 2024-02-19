function [output] = my_conv(image, filter)

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
            output(i, j) = sum(sum(Region .* filter));
        end
    end
end
