function [ threshold ] = getSegment( image )
I = imread(image);
g = rgb2gray(I);
threshold = getThreshold(image);
np = g >= threshold;
imshow(np);
% edges = edge(np,'canny');
% [H,theta,rho] = hough(edges);
% P = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
% lines = houghlines(edges,theta,rho,P,'FillGap',10,'MinLength',1);
% figure, imshow(I), hold on
% for k = 1:length(lines);
%        xy = [lines(k).point1; lines(k).point2];
%        plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
% end
end

