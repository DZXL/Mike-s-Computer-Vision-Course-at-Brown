image= magic(10);
filter=ones(3,3);
matlab_output=imfilter(image,filter); 
my_output=my_conv(image,filter);

subplot 121;
imshow(uint8(matlab_output));
title('matlaboutput');

subplot 122;
imshow(uint8(my_output));
title('myoutput');
