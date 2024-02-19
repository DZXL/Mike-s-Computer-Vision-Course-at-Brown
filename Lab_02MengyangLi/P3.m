H1=3;
H2=5;
H3=7;
s1=0.5;
s2=1;
s3=2;

V1 = fspecial('gaussian',H1,s1);
T1=gauss_kernel(H1, s1);
T2=gauss_kernel(H1, s2);
T3=gauss_kernel(H1, s3);

T4=gauss_kernel(H2, s1);
T5=gauss_kernel(H2, s2);
T6=gauss_kernel(H2, s3);

T7=gauss_kernel(H3, s1);
T8=gauss_kernel(H3, s2);
T9=gauss_kernel(H3, s3);

lenna = imread('figures/Lenna.png');
lenna = double(lenna);
traffic = imread('figures/traffic.jpg');
traffic=double(traffic);

t1_lenna=my_conv(lenna, T1);
t2_lenna=my_conv(lenna, T2);
t3_lenna=my_conv(lenna, T3);
t4_lenna=my_conv(lenna, T4);
t5_lenna=my_conv(lenna, T5);
t6_lenna=my_conv(lenna, T6);
t7_lenna=my_conv(lenna, T7);
t8_lenna=my_conv(lenna, T8);
t9_lenna=my_conv(lenna, T9);

t1_traffic=my_conv(traffic, T1);
t2_traffic=my_conv(traffic, T2);
t3_traffic=my_conv(traffic, T3);
t4_traffic=my_conv(traffic, T4);
t5_traffic=my_conv(traffic, T5);
t6_traffic=my_conv(traffic, T6);
t7_traffic=my_conv(traffic, T7);
t8_traffic=my_conv(traffic, T8);
t9_traffic=my_conv(traffic, T9);

figure;
subplot 331;
imshow(uint8(t1_lenna));
title('t1.Lenna');
subplot 332;
imshow(uint8(t2_lenna));
title('t2.Lenna');
subplot 333;
imshow(uint8(t3_lenna));
title('t3.Lenna');
subplot 334;
imshow(uint8(t4_lenna));
title('t4.Lenna');
subplot 335;
imshow(uint8(t5_lenna));
title('t5.Lenna');
subplot 336;
imshow(uint8(t6_lenna));
title('t6.Lenna');
subplot 337;
imshow(uint8(t7_lenna));
title('t7.Lenna');
subplot 338;
imshow(uint8(t8_lenna));
title('t8.Lenna');
subplot 339;
imshow(uint8(t9_lenna));
title('t9.Lenna');

figure;
subplot 331;
imshow(uint8(t1_traffic));
title('t1.traffic');
subplot 332;
imshow(uint8(t2_traffic));
title('t2.traffic');
subplot 333;
imshow(uint8(t3_traffic));
title('t3.traffic');
subplot 334;
imshow(uint8(t4_traffic));
title('t4.traffic');
subplot 335;
imshow(uint8(t5_traffic));
title('t5.traffic');
subplot 336;
imshow(uint8(t6_traffic));
title('t6.traffic');
subplot 337;
imshow(uint8(t7_traffic));
title('t7.traffic');
subplot 338;
imshow(uint8(t8_traffic));
title('t8.traffic');
subplot 339;
imshow(uint8(t9_traffic));
title('t9.traffic');


