bds1=imread("bds1.jpg");
bds2=imread("bds2.jpg");
bds3=imread("bds3.jpg");
bds4=imread("bds4.jpg");
bds5=imread("bds5.jpg");
bds6=imread("bds6.jpg");



figure;
img1=intensity_edge_detector(bds1, 10);
imshow(img1)

figure;
img2=intensity_edge_detector(bds2, 12);
imshow(img2)


figure;
img3=intensity_edge_detector(bds3, 15);
imshow(img3)


figure;
img4=intensity_edge_detector(bds4, 20);
imshow(img4)


figure;
img5=intensity_edge_detector(bds5, 30);
imshow(img5)

figure;
img6=intensity_edge_detector(bds6, 23);
imshow(img6)



