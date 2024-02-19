bds1=imread("bds1.jpg");
bds2=imread("bds2.jpg");
bds3=imread("bds3.jpg");
bds4=imread("bds4.jpg");
bds5=imread("bds5.jpg");
bds6=imread("bds6.jpg");


figure;
img1=text_edge_detector1(bds1, 60);
imshow(img1)
title('tex1')
%{
figure;
img2=text_edge_detector(bds2, 50);
imshow(img2)
title('tex2')


figure;
img3=text_edge_detector(bds3, 58);
imshow(img3)
title('tex3')


figure;
img4=text_edge_detector(bds4, 59);
imshow(img4)
title('tex4')


figure;
img5=text_edge_detector(bds5, 60);
imshow(img5)
title('tex5')

figure;
img6=text_edge_detector(bds6,60);
imshow(img6)
title('tex6')
%}

