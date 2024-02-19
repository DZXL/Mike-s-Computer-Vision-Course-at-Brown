bds1=imread("bds1.jpg");
bds2=imread("bds2.jpg");
bds3=imread("bds3.jpg");
bds4=imread("bds4.jpg");
bds5=imread("bds5.jpg");
bds6=imread("bds6.jpg");


image1 = rgb2gray(bds1);
image2 = rgb2gray(bds2);
image3 = rgb2gray(bds3);
image4 = rgb2gray(bds4);
image5 = rgb2gray(bds5);
image6 = rgb2gray(bds6);

edges1 = edge(image1, 'canny', [0.1 0.2], 0.5);
edges2 = edge(image2, 'canny', [0.1 0.2], 0.5);
edges3 = edge(image3, 'canny', [0.1 0.2], 0.5);
edges4 = edge(image4, 'canny', [0.1 0.2], 0.5);
edges5 = edge(image5, 'canny', [0.2 0.3], 0.5);
edges6 = edge(image6, 'canny', [0.1 0.2], 0.5);



figure;
imshow(edges1)

figure;
imshow(edges2)


figure;
imshow(edges3)


figure;
imshow(edges4)


figure;
imshow(edges5)

figure;
imshow(edges6)




