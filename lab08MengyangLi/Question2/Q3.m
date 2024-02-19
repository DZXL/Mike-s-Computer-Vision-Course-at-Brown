% Load data
load("Two_View_Correspondences.mat")
load("CalibrationMatrix.mat");
R = load("RelativePose.mat").rotation;
T = load("RelativePose.mat").translation;

% Compute the essential matrix E
E = skewSymmetric(T) * R; 

% Optimize for each pair of corresponding points
optimized_points = zeros(5);
guess=zeros(5);
num_points = size(img1_points, 1);
initial_guesses = zeros(num_points, 2, 2); % The first 2 represents two images, the second 2 represents x and y coordinates
% Projection matrix
P1 = K * [eye(3), [0; 0; 0]];
P2 = K * [R, T];

for i = 1:num_points
    gamma = img1_points(i, :);
    gamma_bar = img2_points(i, :);

    % Use mid-point triangulation as an initial estimate
    x0_3D = triangulateMidpoint(gamma, gamma_bar, K, R, T);

    % Project 3D point onto the two images
    projected_point1 = P1 * [x0_3D; 1];
    projected_point1 = projected_point1(1:2) / projected_point1(3); % Normalize

    projected_point2 = P2 * [x0_3D; 1];
    projected_point2 = projected_point2(1:2) / projected_point2(3); % Normalize

    % Save to initial_guesses
    initial_guesses(i, :, 1) = projected_point1;
    initial_guesses(i, :, 2) = projected_point2;

    % For the Lagrange multiplier, we can choose any initial estimate
    lagrange_multiplier_guess = 0; % For example

    x0 = [projected_point1(1),projected_point1(2),projected_point2(1),projected_point2(2),lagrange_multiplier_guess]; % Initialize lambda as 1

    Energy = @(x) evaluateEnergyFunction(x, gamma, gamma_bar, E);
    options = optimoptions('lsqnonlin', 'Display', 'iter');
    options.Algorithm = 'levenberg-marquardt';
    p_optimized = lsqnonlin(Energy, x0, [], [], options);

    % Store the optimized points
    guess(i,:)=x0;
    optimized_points(i, :) = p_optimized;
end

initial_errors=0;
optimized_errors=0;

for j=1:33
    initial_errors=initial_errors+evaluateEnergyFunction(guess(i,:), gamma, gamma_bar, E);
    optimized_errors=optimized_errors+evaluateEnergyFunction(optimized_points(i,:), gamma, gamma_bar, E);
end

initial_errors=initial_errors/33;
optimized_errors=optimized_errors/33;

% Display errors
fprintf('Initial total error: %f\n', initial_errors);
fprintf('Total error after optimization: %f\n', optimized_errors);

% Compare errors
if optimized_errors < initial_errors
    disp('The error has decreased after optimization!');
else
    disp('The error has not decreased after optimization.');
end

% Other functions remain unchanged

function X = triangulateMidpoint(gamma_hat, gamma_bar_hat, K, R, T)
    % Convert from homogeneous coordinates to Cartesian coordinates
    gamma_hat = [gamma_hat, 1];
    gamma_bar_hat = [gamma_bar_hat, 1];

    % Compute the camera center
    C1 = [0; 0; 0];
    C2 = -R' * T;

    % Get ray direction by inverting the intrinsic matrix
    ray1 = K \ gamma_hat';
    ray2 = R' * (K \ gamma_bar_hat');

    % Compute the nearest point of the two rays
    A = [ray1, -ray2];
    b = C2 - C1;
    lambda = pinv(A) * b;

    % Get two 3D points
    P1 = C1 + lambda(1) * ray1;
    P2 = C2 + lambda(2) * ray2;

    % Return the midpoint of the two points as the final 3D point
    X = 0.5 * (P1 + P2);
end

function Energy = evaluateEnergyFunction(x, gamma, gamma_bar, E)
    % Extract variables from x
    gamma_hat = x(1:2);
    gamma_bar_hat = x(3:4);
    lambda = x(5);
    gamma_hat = [gamma_hat, 1];
    gamma_bar_hat = [gamma_bar_hat, 1];
    gamma=[gamma, 1];
    gamma_bar=[gamma_bar,1];
    
    % Compute energy
    term1 = norm(gamma_hat - gamma)^2;
    term2 = norm(gamma_bar_hat - gamma_bar)^2;
    term3 = lambda * gamma_hat * E * gamma_bar_hat';
    
    Energy = term1 + term2 + term3;

    % fprintf('Current x: [%f, %f, %f, %f, %f], Energy value: %f\n', x(1), x(2), x(3), x(4), x(5), Energy);
end

function S = skewSymmetric(v)
    S = [0, -v(3), v(2);
         v(3), 0, -v(1);
         -v(2), v(1), 0];
end
