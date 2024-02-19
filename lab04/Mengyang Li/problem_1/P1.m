CircuitBoard =imread("board.png");
Coliseum=imread("coliseum.jpg");
Crane=imread("gantrycrane.png");





corners_detected = corner_detector(CircuitBoard);
figure;
imshow(CircuitBoard, []);
hold on;
plot(corners_detected(:,1), corners_detected(:,2), 'r.', 'MarkerSize', 10);
title('CircuitBoard')

corners_detected = corner_detector(Coliseum);
figure;
imshow(Coliseum, []);
hold on;
plot(corners_detected(:,1), corners_detected(:,2), 'r.', 'MarkerSize', 10);
title('Coliseum')

corners_detected = corner_detector(Crane);
figure;
imshow(Crane, []);
hold on;
plot(corners_detected(:,1), corners_detected(:,2), 'r.', 'MarkerSize', 10);
title('Crane')

