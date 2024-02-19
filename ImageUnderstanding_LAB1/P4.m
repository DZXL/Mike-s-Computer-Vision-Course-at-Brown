myImage = imread('white_blood_cells.png');
grayImage = rgb2gray(myImage);
doubleImage = double(grayImage);
img2=doubleImage(1:2:end,1:2:end);
img7=doubleImage(1:7:end,1:7:end);
     

subplot 121;
imshow(uint8(img2));
title('1/2 sampling')

subplot 122;
imshow(uint8(img7));
title('1/7 sampling')


