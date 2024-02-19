board = imread('figures/Circuit_Board_degraded.png');
board = double(board);
chart = imread('figures/eyechart_degraded.jpg');
chart=double(chart);

psfb=load("figures/psf_circuit_board.mat");
psfb = psfb.psf_circuit_board;
psfc=load("figures/psf_eye_chart.mat");
psfc=psfc.psf_eye_chart;



Rboard = lucy_richardson(board, psfb);
Mboard=deconvlucy(board, psfb);
figure;
subplot 131;
imshow(uint8(board));
title('ori.board');
subplot 132;
imshow(uint8(Rboard));
title('restored.board');
subplot 133;
imshow(uint8(Mboard));
title('matlab.board');


Rchart = lucy_richardson(chart, psfc);
Mchart=deconvlucy(chart, psfc);
Med3_board=NL_conv(board, ones(3),'median');
Med3_chart=NL_conv(chart, ones(3),'median');
Med10_board=NL_conv(board, ones(10),'median');
Med10_chart=NL_conv(chart, ones(10),'median');

la44=[0,1,0;1,-4,1;0,1,0];
la_board=my_conv(board,la44);
la_chart=my_conv(chart,la44);


figure;
subplot 131;
imshow(uint8(chart));
title('ori.chart');
subplot 132;
imshow(uint8(Rchart));
title('restored.chart');
subplot 133;
imshow(uint8(Mchart));
title('matlab.chart');


figure;
subplot 231;
imshow(uint8(board));
title('ori.board');
subplot 232;
imshow(uint8(Rboard));
title('restored.board');
subplot 233;
imshow(uint8(Med3_board));
title('median3.board');
subplot 234;
imshow(uint8(Med10_board));
title('median10.board');
subplot 235;
imshow(uint8(la_board));
title('la.board');

figure;
subplot 231;
imshow(uint8(chart));
title('ori.chart');
subplot 232;
imshow(uint8(Rchart));
title('restored.chart');
subplot 233;
imshow(uint8(Med3_chart));
title('median3.chart');
subplot 234;
imshow(uint8(Med10_chart));
title('median10.chart');
subplot 235;
imshow(uint8(la_chart));
title('la.chart');

%challenge
gas=1/16*[1,2,1;2,4,2;1,2,1];
gas_board=my_conv(Rboard,gas);
gas_chart=my_conv(Rchart,gas);

figure;
subplot 131;
imshow(uint8(board));
title('ori.board');
subplot 132;
imshow(uint8(Rboard));
title('restored.board');
subplot 133;
imshow(uint8(gas_board));
title('smooth.board');

figure;
subplot 131;
imshow(uint8(chart));
title('ori.chart');
subplot 132;
imshow(uint8(Rchart));
title('restored.chart');
subplot 133;
imshow(uint8(gas_chart));
title('smooth.chart');