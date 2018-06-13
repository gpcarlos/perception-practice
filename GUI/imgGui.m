function varargout = imgGui(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @imgGui_OpeningFcn, ...
                   'gui_OutputFcn',  @imgGui_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before imgGui is made visible.
function imgGui_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

cam = webcam(1);
handles.cam = cam;
guidata(hObject,handles);

% --- Outputs from this function are returned to the command line.
function varargout = imgGui_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

cam = handles.cam;
%cam.resolution = '640x480';
global b;

old = snapshot(cam);
old = flip(old,2); %Rotate the image.

img = snapshot(cam);
img = flip(img,2);
% img = imresize(img,0.5);
rojo = img(:,:,1);
verde= img(:,:,2);
azul= img(:,:,3);
esPiel = [];
img2 = [];
rVerde = rojo-verde;
for i=1:size(verde,1)
   for j=1:size(verde,2)
       if(rojo(i,j)>90 && verde(i,j)>35 && azul(i,j)>15)&& ...
          ((max([rojo(i,j),verde(i,j),azul(i,j)]) - min([rojo(i,j),verde(i,j),azul(i,j)]))>15) && ...
          (abs(rojo(i,j)-verde(i,j))>15 && rojo(i,j)>verde(i,j) && rojo(i,j)>azul(i,j))
            img2(i,j)=1;
       else
           img2(i,j)=0;
       end
   end
end
ele = strel('disk',2);
img2 = imopen(img2,ele);
old = img2;

op = true;
p = size(old,1) * size(old,2) * 0.00001; %Number of acceptable noise pixels to detect a movement.

while op
   % subplot (1,2,1), imshow(snapshot(cam)), title('Camera');
    img = snapshot(cam);
           img = flip(img,2);
          % img = imresize(img,0.5);
           rojo = img(:,:,1);
           verde= img(:,:,2);
           azul= img(:,:,3);
           esPiel = [];
           img2 = [];
           rVerde = rojo-verde;
           for i=1:size(verde,1)
               for j=1:size(verde,2)
                   if(rojo(i,j)>90 && verde(i,j)>35 && azul(i,j)>15)&& ...
                      ((max([rojo(i,j),verde(i,j),azul(i,j)]) - min([rojo(i,j),verde(i,j),azul(i,j)]))>15) && ...
                      (abs(rojo(i,j)-verde(i,j))>15 && rojo(i,j)>verde(i,j) && rojo(i,j)>azul(i,j))
                        img2(i,j)=1;
                   else
                       img2(i,j)=0;
                   end
               end
           end
           %ele = strel('disk',2);
           img2 = imopen(img2,ele);
           new = img2;
           %imshow(new)
        var = new - old;
        %var(var<0)=1;
        e=strel('square',2);
        var=imerode(var,e);
        imshow(var), title('Processed');

       %subplot (1,2,1), imshow(snapshot(cam)), title('Camera');

       if(sum(sum(var)) > p)
            m = movement(var);
            if (m == 5)
                op = false; %Stop the loop and the program
                fclose(b);
                delete(b);
                close all;

            else
                if(m == 6)
                    op = false;
                    close all;
                    speech;
                   
                else
                    moveRobot(b, m);
                end
            end
            %pause(3);
        end

        old = new;
        %pause (0.01);
    

end
