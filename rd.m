function varargout = rd(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @rd_OpeningFcn, ...
                   'gui_OutputFcn',  @rd_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
function rd_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);
function varargout = rd_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

%--- this is to load image to both axes...
function loadImageButton_Callback(hObject, eventdata, handles)
 [filename, pathname] = uigetfile({'*.jpg';'*.bmp'},'File Selector');
 image = strcat(pathname, filename);
 axes(handles.original);
 imshow(image);
 axes(handles.edit);
 hold off;
 cla reset;
 axes(handles.edit);
 imshow(image);


% --- this will convert the loaded image to grayscale
function GrayScaleButton_Callback(hObject, eventdata, handles)
I = getimage(handles.original);
g = rgb2gray(I);
axes(handles.edit);
imshow(g);

% --- this will identify the edges based on canny method
function EdgesButton_Callback(~, eventdata, handles)
I = getimage(handles.original);
g = rgb2gray(I);
threshold = getThreshold(g);
np = g >= threshold;
edges = edge(np,'canny');
axes(handles.edit);
hold off;
cla reset;
axes(handles.edit);
imshow(edges), hold on

function saveImage_Callback(hObject, eventdata, handles)
F = getframe(handles.edit);
Image = frame2im(F);
imwrite(Image, 'results/Result.jpg')


% --- Executes on button press in Lines.
function Lines_Callback(hObject, eventdata, handles)
I = getimage(handles.original);
g = rgb2gray(I);
threshold = getThreshold(g);
lines = getLines(g,threshold);
axes(handles.edit);
hold off;
cla reset;
axes(handles.edit);
imshow(I), hold on
for k = 1:length(lines);
       xy = [lines(k).point1; lines(k).point2];
       plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
end 

%--- obtain the threshold for grayscale of loaded image
%--- this is based on 95 percent concept
function [threshold] = getThreshold(g)
n = 256;
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

%--- detect lines 
function [lines] = getLines(g,threshold)
np = g >= threshold;
edges = edge(np,'canny');
[H,theta,rho] = hough(edges);
P = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
lines = houghlines(edges,theta,rho,P,'FillGap',300,'MinLength',20);


function detectRoad_Callback(hObject, eventdata, handles)

