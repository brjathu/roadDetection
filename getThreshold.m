function[threshold]= getThreshold(image)
n = 256;
I = imread(image);
g = rgb2gray(I);
[counts,binlocations] = imhist(g,n);
sum = 0;
for i = 1:1:n;
    sum = sum + counts(i);
end 
cum = zeros(n);
cum(1) = counts(1);
for i = 2:1:n;
    cum(i) = cum(i-1) + counts(i);
end
i = 2;
while(i < n);
    if (cum(i) <  0.95 * sum);
      i = i + 1;  
    elseif (cum(i) >= 0.95 * sum);
        threshold = (binlocations(i) + binlocations(i-1))/2;
        break;
    end   
end


end

