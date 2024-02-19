function drawEpipolarLines(E, point, imgSize)
    % Compute the coefficients A, B, C for the corresponding epipolar line
    xi = point(1);
    eta = point(2);
    
    A = E(1,1)*xi + E(1,2)*eta + E(1,3);
    B = E(2,1)*xi + E(2,2)*eta + E(2,3);
    C = E(3,1)*xi + E(3,2)*eta + E(3,3);
    
    % Determine the range of x values for the entire image width
    x_values = 1:imgSize(2);
    
    % Compute y values using the formula above
    y_values = -(A .* x_values + C) ./ B;
    
    % Draw the epipolar line
    plot(x_values, y_values, 'g-');
end
