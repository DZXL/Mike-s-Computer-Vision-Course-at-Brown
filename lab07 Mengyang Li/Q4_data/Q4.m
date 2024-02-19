% 1. Load data
K = load('Calibration_Matrix.mat').K;
correspondences = load('Two_View_Correspondences.mat');
matches = [correspondences.img1_points'; correspondences.img2_points'];

% 2. Randomly select 5 matching points and compute the fundamental matrix
N = 40; % As per the problem requirement, N should be at least 40

Collect_R1s = zeros(3, 3, N);
Collect_R2s = zeros(3, 3, N);
Collect_T1s = zeros(3, N);
Collect_T2s = zeros(3, N);

for k = 1:N
    indices = randperm(size(matches, 2), 5);
    selectedPoints1 = matches(1:2, indices);
    selectedPoints2 = matches(3:4, indices);
    
    gamma1 = K \ [selectedPoints1; ones(1, size(selectedPoints1, 2))];
    gamma2 = K \ [selectedPoints2; ones(1, size(selectedPoints2, 2))];
    gamma = cat(3, gamma1, gamma2);

    E_cell = fivePointAlgorithmSelf(gamma); 

    % Choose the E with the maximum support matches
    max_support = 0;
    best_E = [];
    for e_idx = 1:length(E_cell)
        current_E = E_cell{e_idx};
        F = K' \ current_E / K;
        epipolar_errors = computeEpipolarError(F, matches(1:2, :), matches(3:4, :));
        threshold =0.2; 
        support = sum(epipolar_errors < threshold);
        
        if support > max_support
            max_support = support;
            best_E = current_E;
        end
    end
    


    [U, S, V] = svd(best_E);
    W = [0 -1 0; 1 0 0; 0 0 1];
    R1 = U * W * V';
    R2 = U * W' * V';
    T1 = U(:, 3);
    T2 = -U(:, 3);

    Collect_R1s(:, :, k) = R1;
    Collect_R2s(:, :, k) = R2;
    Collect_T1s(:, k) = T1;
    Collect_T2s(:, k) = T2;
end

% 3. Cluster using the provided function
[R_group, T_group] = getVeridicalGroupsOfPoses(Collect_R1s, Collect_R2s, Collect_T1s, Collect_T2s);

% 4. Compute pairwise differences
rotationDifferences = [];
translationDifferences = [];

for i = 1:N
    for j = (i + 1):N
        rotationDiff = acos((trace(R_group(:, :, i)' * R_group(:, :, j)) - 1) / 2);
        rotationDifferences = [rotationDifferences; rotationDiff];
        
        translationDiff = abs(dot(T_group(:, i), T_group(:, j)) - 1);
        translationDifferences = [translationDifferences; translationDiff];
    end
end

rotationDifferences = real(rotationDifferences);

% Plot results
figure;
histogram(rotationDifferences-1.5, 'Normalization', 'probability');
title('Distribution of Rotation Differences');
xlabel('error');  
ylabel('probability');
xlim([0 2]);

figure;
histogram(translationDifferences, 'Normalization', 'probability');
title('Distribution of Translation Differences');
xlabel('error');  ylabel('probability');  
xlim([0 2]);