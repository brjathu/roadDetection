fontSize = 10;
I = imread('aerial.jpg');
grayImage = rgb2gray(I);
% Get the dimensions of the image.  
% numberOfColorBands should be = 1.
[rows, columns, numberOfColorBands] = size(grayImage);
% Display the original gray scale image.
subplot(1,2,1);
imshow(I);
title('Initial Image', 'FontSize', fontSize);
subplot(1,2,2);
imshow(grayImage);
title('Identified Roads', 'FontSize', fontSize);

