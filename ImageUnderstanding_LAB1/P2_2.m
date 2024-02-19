myImage = imread('white_blood_cells.png');

doubleImage = double(myImage);
img=255-doubleImage;

imshow(uint8(img))