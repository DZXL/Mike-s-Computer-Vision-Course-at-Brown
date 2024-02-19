bds1=imread("bds1.jpg");
bds2=imread("bds2.jpg");
bds3=imread("bds3.jpg");
bds4=imread("bds4.jpg");
bds5=imread("bds5.jpg");
bds6=imread("bds6.jpg");

figure;
[img1,o1]=hist_edge_detector(bds1, 5,8,16);
[rows,cols]=size(img1);
for i=1:rows
    for j=1:cols
        if img1(i,j)>=0.35
            img1(i,j) = 1;
        else
            img1(i,j) = 0;
        end
    end
end
imshow(logical(img1));

figure;
[img2,o2]=hist_edge_detector(bds2, 5,8,16);
[rows,cols]=size(img2);
for i=1:rows
    for j=1:cols
        if img2(i,j)>=0.35
            img2(i,j) = 1;
        else
            img2(i,j) = 0;
        end
    end
end
imshow(logical(img2));

figure;
[img3,o3]=hist_edge_detector(bds3, 5,8,16);
[rows,cols]=size(img3);
for i=1:rows
    for j=1:cols
        if img3(i,j)>=0.35
            img3(i,j) = 1;
        else
            img3(i,j) = 0;
        end
    end
end
imshow(logical(img3));

figure;
[img4,o4]=hist_edge_detector(bds4, 5,8,16);
[rows,cols]=size(img4);
for i=1:rows
    for j=1:cols
        if img4(i,j)>=0.35
            img4(i,j) = 1;
        else
            img4(i,j) = 0;
        end
    end
end
imshow(logical(img4));

figure;
[img5,o5]=hist_edge_detector(bds5, 5,8,16);
[rows,cols]=size(img5);
for i=1:rows
    for j=1:cols
        if img5(i,j)>=0.35
            img5(i,j) = 1;
        else
            img5(i,j) = 0;
        end
    end
end
imshow(logical(img5));

figure;
[img6,o6]=hist_edge_detector(bds6, 5,8,16);
[rows,cols]=size(img6);
for i=1:rows
    for j=1:cols
        if img6(i,j)>=0.35
            img6(i,j) = 1;
        else
            img6(i,j) = 0;
        end
    end
end
imshow(logical(img6));
