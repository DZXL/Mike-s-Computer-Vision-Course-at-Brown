folderPath = 'walking/';  

files = dir(fullfile(folderPath, '*.ppm'));
numFrames = length(files);


% Read the first image to get dimension information
firstImage = imread([folderPath 'track100.ppm']);
[height, width, channels] = size(firstImage);
% Initialize a 3D array to store all frames
videoSequence = zeros(height, width, numFrames, 'uint8');  
videoSequence(:, :, 1) = rgb2gray(firstImage);  
% Read the remaining frames
for i = 2:numFrames
    framePath = sprintf('%strack%d.ppm', folderPath, i+99);  
    frame = imread(framePath);
    videoSequence(:, :, i) = rgb2gray(frame);  
end


N = size(videoSequence, 3); % Number of frames
M = 50; % Number of corners to track
m = 5; % Window size parameter
K = 15; % Maximum number of iterations
accuracy_threshold = 0.01; % Convergence threshold

% Step 1: Perform your corner detection on the first frame
corners = corner_detector(videoSequence(:,:,1)); % Implement this function yourself

% Step 2: Pick the top M corners
strong_corners = selectTopCorners(corners, M); % Implement this function yourself

% Initialize tracked_corners
tracked_corners = cell(N, 1);
tracked_corners{1} = strong_corners;

% Step 3: Loop through frames
for i = 1:N-1
    current_frame = videoSequence(:,:,i);
    next_frame = videoSequence(:,:,i+1);
    
    % Compute gradients

    current_frame = im2double(current_frame);
    [dx, dy] = gradient(current_frame);

    
    new_strong_corners = [];
    
    % Loop through each strong corner
    for j = 1:size(strong_corners, 1)
        px = strong_corners(j, 1);
        py = strong_corners(j, 2);
        
        % Step 8: Make meshgrid
        [X, Y] = meshgrid(px-m:px+m, py-m:py+m);
        
        % Step 9, 10: Interpolation
        W0 = interp2(current_frame, X, Y, 'linear', 0);
        Ix = interp2(dx, X, Y, 'linear', 0);
        Iy = interp2(dy, X, Y, 'linear', 0);
        
        % Initialize displacement vector v
        v = [0, 0];
        
        % Iterative update
        for k = 1:K
            % Step 14, 15: Update window and interpolate
            next_frame = im2double(next_frame);

            Wk = interp2(next_frame, X+v(1), Y+v(2), 'linear', 0);
            
            % Compute deltaI and bk, and update v (steps 16-19)
            % This part will involve implementing Equation 2 and Equation 3 from your algorithm
            % Let's assume computeUpdate() is a function that does this.
            eta = computeUpdate(W0, Wk, Ix, Iy); % Implement this function yourself
            
            if norm(eta) < accuracy_threshold
                break;
            end
            
            v = v + eta;
        end
        
        % Step 21-25: Check for convergence
        if norm(eta) < accuracy_threshold
            new_strong_corners = [new_strong_corners; px+v(1), py+v(2)];
        end
    end
    
    strong_corners = new_strong_corners;
    tracked_corners{i+1} = strong_corners;
end


for i = 1:numFrames
    imshow(videoSequence(:,:,i), []);
    hold on;
    plot(tracked_corners{i}(:,1), tracked_corners{i}(:,2), 'ro');
    hold off;
    pause(0.1);
end




