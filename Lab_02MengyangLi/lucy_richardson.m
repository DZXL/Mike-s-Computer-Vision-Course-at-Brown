function restored_image = lucy_richardson(degraded_image, psf)
    iters=10;
    % Initialize the estimate f_hat, set it to the degraded image
    f_hat = degraded_image;
    
    for i = 1:iters
        rightpart = degraded_image ./ conv2(f_hat, psf, 'same');
        right_convolution = conv2(rightpart, psf, 'same');
        f_hat = f_hat .* right_convolution;
    end
    restored_image = f_hat;
end
