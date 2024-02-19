% Load data
scene = load('scenePointCloud.mat');
locations = scene.scenePointCloud.Location;
colors = scene.scenePointCloud.Color;

% Initialize blank images for direct projections
image1_direct = zeros(1200, 1600, 3);
image2_direct = zeros(1200, 1600, 3);

% Define camera parameters
load('Calibration_Matrix');

R1 = [-0.2001, -0.8844, 0.4217;
      0.4337, 0.3060, 0.8475;
      -0.8786, 0.3524, 0.3224];
T1 = [-266.6953; -531.1814; 454.4060];

R2 = [0.0335, -0.8915, 0.4517;
      0.4268, 0.4215, 0.8001;
      -0.9037, 0.1660, 0.3946];
T2 = [-295.2071; -499.9407; 407.8815];



projected_points_camera1 = zeros(size(locations, 1), 5);
projected_points_camera2 = zeros(size(locations, 1), 5);

% Compute direct projections and save to respective images
for i = 1:size(locations, 1)
    point3D = locations(i, :);
    color = double(colors(i, :)) / 255;

    % Project using calibration and external parameters
    point2D_camera1 = projectPoint(K, R1, T1, point3D);
    point2D_camera2 = projectPoint(K, R2, T2, point3D);

    projected_points_camera1(i, 1:2) = point2D_camera1;
    projected_points_camera1(i, 3:5) = color;
    projected_points_camera2(i, 1:2) = point2D_camera2;
    projected_points_camera2(i, 3:5) = color;
end

% Form images using meshgrid and griddata
[X, Y] = meshgrid(1:1600, 1:1200);
Z_camera1(:,:,1) = griddata(projected_points_camera1(:, 1), projected_points_camera1(:, 2), projected_points_camera1(:, 3), X, Y, 'linear');
Z_camera1(:,:,2) = griddata(projected_points_camera1(:, 1), projected_points_camera1(:, 2), projected_points_camera1(:, 4), X, Y, 'linear');
Z_camera1(:,:,3) = griddata(projected_points_camera1(:, 1), projected_points_camera1(:, 2), projected_points_camera1(:, 5), X, Y, 'linear');
Z_camera2(:,:,1) = griddata(projected_points_camera2(:, 1), projected_points_camera2(:, 2), projected_points_camera2(:, 3), X, Y, 'linear');
Z_camera2(:,:,2) = griddata(projected_points_camera2(:, 1), projected_points_camera2(:, 2), projected_points_camera2(:, 4), X, Y, 'linear');
Z_camera2(:,:,3) = griddata(projected_points_camera2(:, 1), projected_points_camera2(:, 2), projected_points_camera2(:, 5), X, Y, 'linear');

% Display images formed using meshgrid and griddata
figure;
imshow(Z_camera1);
title('Formed Image Camera 1');

figure;
imshow(Z_camera2);
title('Formed Image Camera 2');
