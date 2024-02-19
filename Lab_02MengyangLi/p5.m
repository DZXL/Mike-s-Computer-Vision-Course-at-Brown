coin = imread('figures/salt_and_pepper_coins.png');
coin = double(coin);
traffic = imread('figures/traffic.jpg');
traffic=double(traffic);

gas=gauss_kernel(3, 0.1);
bf= 1/9*[1,1,1;1,1,1;1,1,1];
gas_coin=my_conv(coin, gas);
bf_coin=my_conv(coin, bf);

figure;
subplot 131;
imshow(uint8(min33));
title('ori.coin');
subplot 132;
imshow(uint8(gas_coin));
title('gas.coin');
subplot 133;
imshow(uint8(bf_coin));
title('bf.coin');

F=ones(3);
min=NL_conv(traffic, F,'min');
max=NL_conv(traffic, F,'max');
median=NL_conv(traffic, F,'median');
figure;
subplot 131;
imshow(uint8(min));
title('min.traffic');
subplot 132;
imshow(uint8(max));
title('max.traffic');
subplot 133;
imshow(uint8(median));
title('median.traffic');