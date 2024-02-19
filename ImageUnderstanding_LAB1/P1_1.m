myImage = imread('white_blood_cells.png');
grayImage = rgb2gray(myImage);
doubleImage = double(grayImage);
img=doubleImage;
threshold=220;
for i= 1:480
    for j= 1:640
        if img(i,j)>threshold
            img(i,j)=0;
        else
            img(i,j)=255;
        end
    end
end
imshow(uint8(img))
