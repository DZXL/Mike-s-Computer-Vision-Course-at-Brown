myImage = imread('ImageA.jpg');
doubleImage = double(myImage);
bimg1=doubleImage*1.1;
dimg1=doubleImage*0.9;
bimg2=doubleImage+25;
dimg2=doubleImage-25;
bimg3=doubleImage+50;
dimg3=doubleImage-50;


subplot 231;
imshow(uint8(bimg1));
title('10% brighter')

subplot 234;
imshow(uint8(dimg1));
title('10% darker')

subplot 232;
imshow(uint8(bimg2));
title('25 brighter')

subplot 235;
imshow(uint8(dimg2));
title('25 darker')

subplot 233;
imshow(uint8(bimg3));
title('50 brighter')

subplot 236;
imshow(uint8(dimg3));
title('50 darker')