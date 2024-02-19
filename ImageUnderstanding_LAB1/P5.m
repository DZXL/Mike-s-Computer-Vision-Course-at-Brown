myimg1 = imread('P5/1.jpg');
myimg2 = imread('P5/2.jpg');
myimg3 = imread('P5/3.jpg');
myimg4 = imread('P5/4.jpg');
myimg5 = imread('P5/5.jpg');
myimg6 = imread('P5/6.jpg');
myimg7 = imread('P5/7.jpg');
myimg8 = imread('P5/8.jpg');
myimg9 = imread('P5/9.jpg');
myimg10 = imread('P5/10.jpg');
myimg11 = imread('P5/11.jpg');
myimg12 = imread('P5/12.jpg');
myimg13 = imread('P5/13.jpg');
myimg14 = imread('P5/14.jpg');
myimg15 = imread('P5/15.jpg');
myimg16 = imread('P5/16.jpg');
myimg17 = imread('P5/17.jpg');
myimg18 = imread('P5/18.jpg');
myimg19 = imread('P5/19.jpg');
myimg20 = imread('P5/20.jpg');

myimg1 = double(rgb2gray(myimg1));
myimg2 = double(rgb2gray(myimg2));
myimg3 = double(rgb2gray(myimg3));
myimg4 = double(rgb2gray(myimg4));
myimg5 = double(rgb2gray(myimg5));
myimg6 = double(rgb2gray(myimg6));
myimg7 = double(rgb2gray(myimg7));
myimg8 = double(rgb2gray(myimg8));
myimg9 = double(rgb2gray(myimg9));
myimg10 = double(rgb2gray(myimg10));
myimg11 = double(rgb2gray(myimg11));
myimg12 = double(rgb2gray(myimg12));
myimg13 = double(rgb2gray(myimg13));
myimg14 = double(rgb2gray(myimg14));
myimg15 = double(rgb2gray(myimg15));
myimg16 = double(rgb2gray(myimg16));
myimg17 = double(rgb2gray(myimg17));
myimg18 = double(rgb2gray(myimg18));
myimg19 = double(rgb2gray(myimg19));
myimg20 = double(rgb2gray(myimg20));

%5.1
Timg=(myimg1+myimg2+myimg3+myimg4+myimg5+myimg6+myimg7+myimg8+myimg9+myimg10+myimg11+myimg12+myimg13+myimg14+myimg15+myimg16+myimg17+myimg18+myimg19+myimg20);
meanimg=Timg/20;
stdimg=sqrt(double(((myimg1-meanimg).^2+(myimg2-meanimg).^2+(myimg3-meanimg).^2+(myimg4-meanimg).^2+(myimg5-meanimg).^2+(myimg6-meanimg).^2+(myimg7-meanimg).^2+(myimg8-meanimg).^2+(myimg9-meanimg).^2+(myimg10-meanimg).^2+(myimg11-meanimg).^2+(myimg12-meanimg).^2+(myimg13-meanimg).^2+(myimg14-meanimg).^2+(myimg15-meanimg).^2+(myimg16-meanimg).^2+(myimg17-meanimg).^2+(myimg18-meanimg).^2+(myimg19-meanimg).^2+(myimg20-meanimg).^2)/20));
imshow(uint8(meanimg));
imshow(uint8(stdimg));

%5.2
sum1=sum((myimg1-meanimg),"all");
sum2=sum((myimg2-meanimg),"all");
sum3=sum((myimg3-meanimg),"all");
sum4=sum((myimg4-meanimg),"all");
sum5=sum((myimg5-meanimg),"all");
sum6=sum((myimg1-meanimg),"all");
sum7=sum((myimg2-meanimg),"all");
sum8=sum((myimg3-meanimg),"all");
sum9=sum((myimg4-meanimg),"all");
sum10=sum((myimg5-meanimg),"all");
sum11=sum((myimg1-meanimg),"all");
sum12=sum((myimg2-meanimg),"all");
sum13=sum((myimg3-meanimg),"all");
sum14=sum((myimg4-meanimg),"all");
sum15=sum((myimg5-meanimg),"all");
sum16=sum((myimg1-meanimg),"all");
sum17=sum((myimg2-meanimg),"all");
sum18=sum((myimg3-meanimg),"all");
sum19=sum((myimg4-meanimg),"all");
sum20=sum((myimg5-meanimg),"all");

max([sum1,sum2,sum3,sum4,sum5,sum6,sum7,sum8,sum9,sum10,sum11,sum12,sum13,sum14,sum15,sum16,sum17,sum18,sum19,sum20])

%5.3
p1=myimg1(1,1);
p2=myimg2(1,1);
p3=myimg3(1,1);
p4=myimg4(1,1);
p5=myimg5(1,1);
p6=myimg6(1,1);
p7=myimg7(1,1);
p8=myimg8(1,1);
p9=myimg9(1,1);
p10=myimg10(1,1);

p11=myimg11(1,1);
p12=myimg12(1,1);
p13=myimg13(1,1);
p14=myimg14(1,1);
p15=myimg15(1,1);
p16=myimg16(1,1);
p17=myimg17(1,1);
p18=myimg18(1,1);
p19=myimg19(1,1);
p20=myimg20(1,1);

hist([p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16,p17,p18,p19,p20])

