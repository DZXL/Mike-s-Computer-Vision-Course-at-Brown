I1 = imread('img1.png');
if size(I1, 3) == 3
    I1 = rgb2gray(I1);
end
I1 = single(I1);

I2 = imread('img2.png');
if size(I2, 3) == 3
    I2 = rgb2gray(I2);
end
I2 = single(I2);

[frames1, descriptors1] = vl_sift(I1, 'PeakThresh', 10, 'edgethresh', 34);
[frames2, descriptors2] = vl_sift(I2, 'PeakThresh', 10, 'edgethresh', 30);
subplot 121
imshow(I1, []);
hold on;
plot(frames1(1,:),frames1(2,:),'r*');
hold off;

subplot 122
imshow(I2, []);
hold on;
plot(frames2(1,:),frames2(2,:),'bo');
hold off;
