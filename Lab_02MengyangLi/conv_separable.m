function output = conv_separable(image, kernel)

    [imageHeight, imageWidth] = size(image);
    horizontalOutput = zeros(imageHeight, imageWidth);
    output = zeros(imageHeight, imageWidth);
    
    % horizontal convolution
    for i = 1:imageHeight
        horizontalOutput(i, :) = my_conv(image(i, :), kernel(1, :));
    end
    
    % vertical convolution
    for j = 1:imageWidth
        output(:, j) = my_conv(horizontalOutput(:, j), kernel(:, 1));
    end
end
