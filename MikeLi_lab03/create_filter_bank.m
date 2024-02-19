function filter_bank = create_filter_bank()
    filter_bank = cell(1, 48); % Initialize a cell array for filters

    % Define parameters for filters
    scales = [1, 2, 3];
    orientations = [0, 30, 60, 90, 120, 150];

    index = 1;
    for scale = scales
        for orientation = orientations
            % Create odd-symmetric filters
            filter_bank{index} = create_odd_symmetric_filter(scale, orientation);
            index = index + 1;

            % Create even-symmetric filters
            filter_bank{index} = create_even_symmetric_filter(scale, orientation);
            index = index + 1;
        end
    end

    % Create Laplacian of Gaussian (LOG) filters
    for scale = scales
        filter_bank{index} = fspecial('log', [5*scale, 5*scale], scale);
        index = index + 1;
    end

    % Create Gaussian filters
    for scale = 1:4
        filter_bank{index} = fspecial('gaussian', [5*scale, 5*scale], scale);
        index = index + 1;
    end
end

