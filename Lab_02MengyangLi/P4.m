f33=ones(3);
f55=ones(5);
f77=ones(7);

image = imread('figures/salt_and_pepper_coins.png');
image = double(image);

%min
min33=NL_conv(image, f33,'min');
min55=NL_conv(image, f55,'min');
min77=NL_conv(image, f77,'min');
figure;
subplot 131;
imshow(uint8(min33));
title('min33');
subplot 132;
imshow(uint8(min55));
title('min55');
subplot 133;
imshow(uint8(min77));
title('min77');

%max
max33=NL_conv(image, f33,'max');
max55=NL_conv(image, f55,'max');
max77=NL_conv(image, f77,'max');
figure;
subplot 131;
imshow(uint8(max33));
title('max33');
subplot 132;
imshow(uint8(max55));
title('max55');
subplot 133;
imshow(uint8(max77));
title('max77');

%median
median33=NL_conv(image, f33,'median');
median55=NL_conv(image, f55,'median');
median77=NL_conv(image, f77,'median');
figure;
subplot 131;
imshow(uint8(median33));
title('median33');
subplot 132;
imshow(uint8(median55));
title('median55');
subplot 133;
imshow(uint8(median77));
title('median77');