% 1. Load three images
I1 = imread('halfdome-05.png');
I2 = imread('halfdome-06.png');
I3 = imread('halfdome-07.png');

I1_gray = rgb2gray(im2double(I1));
I2_gray = rgb2gray(im2double(I2));
I3_gray = rgb2gray(im2double(I3));

% 2. Feature detection and descriptor extraction for I1 and I2
[features1, descriptors1] = vl_sift(single(I1_gray));
[features2, descriptors2] = vl_sift(single(I2_gray));

% 3. Feature matching
[matches, scores] = vl_ubcmatch(descriptors1, descriptors2);
matches1 = features1(1:2, matches(1, :))';
matches2 = features2(1:2, matches(2, :))';

% 4. Estimate homography matrix from I1 to I2 using RANSAC
finalH12 = Ransac4Homography(matches1, matches2);

% 5. Stitch I1 and I2 using the homography matrix
[warpedImg12, x12, y12, warpImgWeight12] = getNewImg(finalH12, I1, I2);

% 6. Blend the stitched images
blendedImg12 = blendImgs(warpedImg12, I1, x12, y12, 'weightBlend', warpImgWeight12);

% 7. Feature detection and descriptor extraction for blendedImg12 and I3
blendedImg12_gray = rgb2gray(im2double(blendedImg12/255));
[features12, descriptors12] = vl_sift(single(blendedImg12_gray));
[features3, descriptors3] = vl_sift(single(I3_gray));

% 8. Feature matching
[matches, scores] = vl_ubcmatch(descriptors12, descriptors3);
matches12 = features12(1:2, matches(1, :))';
matches3 = features3(1:2, matches(2, :))';

% 9. Estimate homography matrix from blendedImg12 to I3 using RANSAC
finalH123 = Ransac4Homography(matches12, matches3);

% 10. Stitch blendedImg12 and I3 using the homography matrix
[warpedImg123, x123, y123, warpImgWeight123] = getNewImg(finalH123, blendedImg12, I3);

% 11. Blend the stitched images
blendedImg123 = blendImgs(warpedImg123, blendedImg12, x123, y123, 'weightBlend', warpImgWeight123);

% 12. Visualize the final result
imshow(uint8(blendedImg123));
