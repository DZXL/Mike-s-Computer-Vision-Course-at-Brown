bds1=imread("bds1.jpg");
bds2=imread("bds2.jpg");
bds3=imread("bds3.jpg");
bds4=imread("bds4.jpg");
bds5=imread("bds5.jpg");
bds6=imread("bds6.jpg");


figure;
[Ih_ori1,Ih1,Il1]=dual_threshold_edge_linking(bds1, 10,20);
subplot 131
imshow(Ih_ori1)
title('Ih')
subplot 132
imshow(Ih1)
title('two_threshold')
subplot 133
imshow(Il1)
title('Il')

figure;
[Ih_ori2,Ih2,Il2]=dual_threshold_edge_linking(bds2, 12,20);
subplot 131
imshow(Ih_ori2)
title('Ih')
subplot 132
imshow(Ih2)
title('two_threshold')
subplot 133
imshow(Il2)
title('Il')


figure;
[Ih_ori3,Ih3,Il3]=dual_threshold_edge_linking(bds3, 18,27);
subplot 131
imshow(Ih_ori3)
title('Ih')
subplot 132
imshow(Ih3)
title('two_threshold')
subplot 133
imshow(Il3)
title('Il')


figure;
[Ih_ori4,Ih4,Il4]=dual_threshold_edge_linking(bds4, 15,30);
subplot 131
imshow(Ih_ori4)
title('Ih')
subplot 132
imshow(Ih4)
title('two_threshold')
subplot 133
imshow(Il4)
title('Il')



figure;
[Ih_ori5,Ih5,Il5]=dual_threshold_edge_linking(bds5, 15,30);
subplot 131
imshow(Ih_ori5)
title('Ih')
subplot 132
imshow(Ih5)
title('two_threshold')
subplot 133
imshow(Il5)
title('Il')


figure;
[Ih_ori6,Ih6,Il6]=dual_threshold_edge_linking(bds6, 10,30);
subplot 131
imshow(Ih_ori6)
title('Ih')
subplot 132
imshow(Ih6)
title('two_threshold')
subplot 133
imshow(Il6)
title('Il')


