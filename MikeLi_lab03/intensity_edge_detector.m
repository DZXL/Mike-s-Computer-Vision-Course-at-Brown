function edge_img = intensity_edge_detector(image, threshold)
    %Load the image and convert to grayscale
    image = rgb2gray(image);
    %smooth it with a Gaussian filter 
    image = imgaussfilt(image, 0.5);

    %compute the first deriva- tives in the x and y direction.
    [dy, dx] = gradient(double(image));

    %Create a magnitude map M of the gradient image
    M = sqrt(dx.^2 + dy.^2);
    
    %view the actual gradient vectors
    quiver(dy, dx);

    %Perform non-max supression:
    [rows, cols] = size(image);
    for r = 2:rows-1
        for c = 2:cols-1
            angle = atan2(dy(r, c), dx(r, c)) * 180 / pi;
            if (angle > 157.5 && angle <= 180) || (angle >= -180 && angle <= -157.5)
                q = M(r - 1, c);
                qbar = M(r + 1, c);
            elseif angle > -157.5 && angle <= -112.5
                q = M(r + 1, c - 1);
                qbar = M(r - 1, c + 1);
            elseif angle > -112.5 && angle <= -67.5
                q = M(r, c - 1);
                qbar = M(r, c + 1);
            elseif angle > -67.5 && angle <= -22.5
                q = M(r - 1, c - 1);
                qbar = M(r + 1, c + 1);
            else
                q = M(r - 1, c);
                qbar = M(r + 1, c);
            end
            if M(r, c) < q || M(r, c) < qbar
                M(r, c) = 0;
            end
        end
    end

    % Create a binary edge image by thresholding.
    for i=1:rows
        for j=1:cols
            if M(i,j)>threshold
                edge_img(i,j) = 1;
            else
                edge_img(i,j) = 0;
            end
        end
    end
end
