image= magic(10);
filter=ones(3,3);
matlab_output=imfilter(image,filter); 
my_output=my_conv(image,filter);
my_2=conv_separable(image, filter);

subplot 131;
imshow(uint8(matlab_output));
title('matlaboutput');

subplot 132;
imshow(uint8(my_output));
title('myoutput');


subplot 133;
imshow(uint8(my_2));
title('my.sep.output');


image= imread('figures/Lenna.png');
image = double(image);

%1
disp('5 × 5 Box Filter');
f1=1/25*[1,1,1,1,1;1,1,1,1,1;1,1,1,1,1;1,1,1,1,1;1,1,1,1,1];
tic;
conv_separable(image,f1);
ts1 = toc;
tic;
my_conv(image,f1);
tm1 = toc;
disp(['time for conv_separable:',num2str(ts1)]);
disp(['time for my_conv:',num2str(tm1)]);
disp(' ');
%2
disp('5 × 5 circular shape filter');
f2=1/25*[0,1,1,1,0;1,1,1,1,1;1,1,1,1,1;1,1,1,1,1;0,1,1,1,0];
tic;
conv_separable(image,f2);
ts2 = toc;
tic;
my_conv(image,f2) ;
tm2 = toc;
disp(['time for conv_separable:',num2str(ts2)]);
disp(['time for my_conv:',num2str(tm2)]);
disp(' ');
%3
disp('7 × 7 Gaussian with sigma of 0.5');
f3=gauss_kernel(7, 0.5);
tic;
conv_separable(image,f3);
ts3 = toc;
tic;
my_conv(image,f3);
tm3 = toc;
disp(['time for conv_separable:',num2str(ts3)]);
disp(['time for my_conv:',num2str(tm3)]);
disp(' ');
%4
disp('17 x 17 Gaussian with sigma of 0.5');
f4=gauss_kernel(17, 0.5);
tic;
conv_separable(image,f4);
ts4 = toc;
tic;
my_conv(image,f4); 
tm4 = toc;
disp(['time for conv_separable:',num2str(ts4)]);
disp(['time for my_conv:',num2str(tm4)]);
disp(' ');
%5
disp('35 × 35 Gaussian with sigma of 2');
f5=gauss_kernel(35, 2);
tic;
conv_separable(image,f5);
ts5 = toc;
tic;
my_conv(image,f5);
tm5 = toc;
disp(['time for conv_separable:',num2str(ts5)]);
disp(['time for my_conv:',num2str(tm5)]);
