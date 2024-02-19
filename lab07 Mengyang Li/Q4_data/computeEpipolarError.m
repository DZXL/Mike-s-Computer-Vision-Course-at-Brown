function errors = computeEpipolarError(F, x1s, x2s)
    
    num_points = size(x1s, 2);
    errors = zeros(1, num_points);
    
    for i = 1:num_points
        x1 = [x1s(:, i); 1]; 
        x2 = [x2s(:, i); 1];
        
        error = x2' * F * x1;
        errors(i) = abs(error);
    end
end
