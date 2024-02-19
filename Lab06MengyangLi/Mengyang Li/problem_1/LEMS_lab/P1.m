% 1. Feature detection and descriptor extraction
I1 = imread('lems-01.png');
I2 = imread('lems-02.png');
I1_gray = rgb2gray(im2double(I1));
I2_gray = rgb2gray(im2double(I2));
[features1, descriptors1] = vl_sift(single(I1_gray));
[features2, descriptors2] = vl_sift(single(I2_gray));

% 2. Feature matching
[matches, scores] = vl_ubcmatch(descriptors1, descriptors2);
matches1 = features1(1:2, matches(1, :))';
matches2 = features2(1:2, matches(2, :))';

% 3. Estimate homography matrix using RANSAC
finalH = Ransac4Homography(matches1, matches2);

% 4. Stitch the two images using the final homography matrix
[warpedImg, x, y, warpImgWeight] = getNewImg(finalH, I1, I2);

% 5. Blend the stitched images
blendingAlgorithm = 'weightBlend';  % Choose appropriate algorithm as indicated by blendImgs.m
blendedImg = blendImgs(warpedImg, I1, x, y, blendingAlgorithm, warpImgWeight);

% 6. Visualization
imshow(uint8(blendedImg));
