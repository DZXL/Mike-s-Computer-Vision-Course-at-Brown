myImage = imread('white_blood_cells.png');

doubleImage = double(myImage);
img1=doubleImage;
img2=doubleImage;
for i= 1:480
    for j= 1:640
        img1(i,j)=floor(doubleImage(i,j)/32)*32+16;
        img2(i,j)=floor(doubleImage(i,j)/16)*16+8;
    end
end
     

subplot 121;
imshow(uint8(img1));
title('8 levels')

subplot 122;
imshow(uint8(img2));
title('16 levels')
