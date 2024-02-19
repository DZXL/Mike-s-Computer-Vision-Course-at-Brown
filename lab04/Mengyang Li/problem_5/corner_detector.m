function corners = corner_detector(image)

    % 1: Convert the image to grayscale and convert data type
    if size(image, 3) == 3
        image = rgb2gray(image);
    end

    image = im2double(image);

    % 2. Gaussian derivatives
    sigma1 = 1;
    window_size = ceil(6*sigma1);
    if mod(window_size, 2) == 0
        window_size = window_size + 1;
    end
    [Gx, Gy] = gradient(fspecial('gaussian', window_size, sigma1));

    % 3. Compute fx and fy
    fx = conv2(image, Gx, 'same');
    fy = conv2(image, Gy, 'same');

    % 4. Compute spatial maps
    fx2 = fx .* fx;
    fy2 = fy .* fy;
    fxfy = fx .* fy;

    % 5. Blur the spatial maps
    sigma2 = 2;
    window_size = ceil(6*sigma2);
    if mod(window_size, 2) == 0
        window_size = window_size + 1;
    end
    G = fspecial('gaussian', window_size, sigma2);
    Sx = conv2(fx2, G, 'same');
    Sy = conv2(fy2, G, 'same');
    Sxy = conv2(fxfy, G, 'same');

    % 6. Compute the determinant and trace of matrix M
    detM = Sx .* Sy - Sxy .* Sxy;
    trM = Sx + Sy;

    % 7. Compute the corner response
    alpha = 0.04;
    R = detM - alpha * (trM .* trM);

    % 8. Non-maximum suppression
    [rows, cols] = size(image);
    for i = 2:rows-1
        for j = 2:cols-1
            patch = R(i-1:i+1, j-1:j+1);
            if R(i,j) ~= max(patch(:))
                R(i,j) = 0;
            end
        end
    end

    % 9. Threshold R
    threshold = 0.1 * max(R(:));
    [corner_y, corner_x] = find(R > threshold);
    corner_R = R(R > threshold);
    
    % 返回一个包含x坐标、y坐标和响应值R的三列数组
    corners = [corner_x, corner_y, corner_R];
end
