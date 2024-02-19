myImage = imread('snowman.jpg');
doubleImage = double(myImage);
img=doubleImage;
I0=80;
I1=180;
for i= 1:200
    for j= 1:255
        if img(i,j)>=I0 && img(i,j)<=I1
            img(i,j)=255;
        else
            img(i,j)=0;
        end
    end
end
imshow(uint8(img))