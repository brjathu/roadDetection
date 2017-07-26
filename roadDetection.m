function[threshold]= roadDetection(image)
n = 4;
I = imread(image);
g = rgb2gray(I);
[counts,binlocations] = imhist(g,n);
sum = 0;
for i = 1:1:n;
    sum = sum + counts(i);
end 
i = 2;
while(i < n);
    temp = 0 ;
    for j = 1:1:n;    
        if binlocations(j) < (binlocations(i) + binlocations(i-1))/2;
            temp  = temp + counts(j);
        end 
    end 
    if (temp <  0.95 * sum);
      i = i + 1;  
    elseif (temp >= 0.95 * sum);
        threshold = (binlocations(i) + binlocations(i-1))/2;
    end   
end
end

