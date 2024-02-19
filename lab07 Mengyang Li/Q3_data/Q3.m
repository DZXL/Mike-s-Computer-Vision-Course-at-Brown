% Load data
K = load('Calibration_Matrix.mat').K;
Rg = load('GT_pose.mat').GT_pose.R; % Ground truth rotation matrix
Tg = load('GT_pose.mat').GT_pose.T; % Ground truth translation vector

% Read images
img1 = imread('1.jpg'); 
img2 = imread('2.jpg'); 

% Use VLFeat library to extract and match SIFT features
[fa, da] = vl_sift(single(rgb2gray(img1)));
[fb, db] = vl_sift(single(rgb2gray(img2)));
[matches, scores] = vl_ubcmatch(da, db);

% Extract coordinates of matched points
matchedPoints1 = fa(1:2, matches(1, :))';
matchedPoints2 = fb(1:2, matches(2, :))';

% Normalize coordinates
gamma1 = K \ [matchedPoints1'; ones(1, size(matchedPoints1, 1))];
gamma2 = K \ [matchedPoints2'; ones(1, size(matchedPoints2, 1))];

% 2. Estimate essential matrix using RANSAC
[finalE, inlierIdx] = Ransac4Essential(gamma1, gamma2, K);

% 3. Recover R and T based on estimated E
[U, S, V] = svd(finalE);
W = [0 -1 0; 1 0 0; 0 0 1];
R1 = U * W * V';
R2 = U * W' * V';
T1 = U(:, 3);
T2 = -U(:, 3);

% 4. Evaluate the recovered R and T
possible_Rs = {R1, R1, R2, R2};
possible_Ts = {T1, T2, T1, T2};
minError = Inf;
validR = [];
validT = [];

for i = 1:4
    R = possible_Rs{i};
    T = possible_Ts{i};
    
    errorR = acos((trace(Rg' * R) - 1) / 2);
    errorT = abs(dot(Tg, T) - 1);
    
    totalError = errorR + errorT;
    if totalError < minError
        minError = totalError;
        validR = R;
        validT = T;
    end
end

fprintf('Errors of rotation: %f\n', acos((trace(Rg' * validR) - 1) / 2));
fprintf('Errors of translation: %f\n', abs(dot(Tg, validT) - 1));
