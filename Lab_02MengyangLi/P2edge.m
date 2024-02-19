IA = imread('figures/ImageA.jpg');
IA = double(IA);
IB = imread('figures/ImageB.jpg');
IB=double(IB);


px=[1,0,-1;1,0,-1;1,0,-1];
py=[1,1,1;0,0,0;-1,-1,-1];
sx=[1,0,-1;2,0,-2;1,0,-1];
sy=[1,2,1;0,0,0;-1,-2,-1];

px_IA=my_conv(IA, px);
py_IA=my_conv(IA, py);
sx_IA=my_conv(IA, sx);
sy_IA=my_conv(IA, sy);

px_IB=my_conv(IB, px);
py_IB=my_conv(IB, py);
sx_IB=my_conv(IB, sx);
sy_IB=my_conv(IB, sy);


figure;
subplot 511;
imshow(uint8(IA));
title('ori.IA');
subplot 512;
imshow(uint8(px_IA));
title('px.IA');
subplot 513;
imshow(uint8(py_IA));
title('py.IA');
subplot 514;
imshow(uint8(sx_IA));
title('sx.IA');
subplot 515;
imshow(uint8(sy_IA));
title('sy.IA');

figure;
subplot 511;
imshow(uint8(IB));
title('ori.IB');
subplot 512;
imshow(uint8(px_IB));
title('px.IB');
subplot 513;
imshow(uint8(py_IB));
title('py.IB');
subplot 514;
imshow(uint8(sx_IB));
title('sx.IB');
subplot 515;
imshow(uint8(sy_IB));
title('sy.IB');
