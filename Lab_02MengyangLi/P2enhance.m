IA = imread('figures/ImageA.jpg');
IA = double(IA);
IB = imread('figures/ImageB.jpg');
IB=double(IB);

la44=[0,1,0;1,-4,1;0,1,0];
la88=[1,1,1;1,-8,1;1,1,1];

la44_IA=my_conv(IA, la44);
la88_IA=my_conv(IA, la88);

la44_IB=my_conv(IB, la44);
la88_IB=my_conv(IB, la88);

figure;
subplot 311;
imshow(uint8(IA));
title('ori.IA');
subplot 312;
imshow(uint8(la44_IA));
title('la44.IA');
subplot 313;
imshow(uint8(la88_IA));
title('la88.IA');

figure;
subplot 311;
imshow(uint8(IB));
title('ori.IB');
subplot 312;
imshow(uint8(la44_IB));
title('la44.IB');
subplot 313;
imshow(uint8(la88_IB));
title('la88.IB');
