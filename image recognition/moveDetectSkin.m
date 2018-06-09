addpath('../connection');
clear all
close all
clc

addpath('../connection');

cam = webcam(1);
old = snapshot(cam);
old = flip(old,2); %Rotate the image.
%old = rgb2gray(old); %Grayscale image
%old = im2bw(old,graythresh(old)); %Black and white image
 img = snapshot(cam);
       img = imresize(img,0.5);
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

while true
%     new = snapshot(cam);
%     new = flip(new,2);%Rotate the image.
    %new = rgb2gray(new);%Grayscale image
    %new = im2bw(new,graythresh(new));%Black and white image
     img = snapshot(cam);
       img = imresize(img,0.5);
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
       new = img2;
       %imshow(new)
    var = new - old;
    %var(var<0)=1;
    e=strel('square',2);
    var=imerode(var,e);
    imshow(var);
    old = new;
    pause (0.01);
end

delete(cam)