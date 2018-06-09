addpath('../connection');
clear all
close all
clc

addpath('../connection');

b = establishConnection;

cam = webcam(1);
old = snapshot(cam);
old = flip(old,2); %Rotate the image.
old = rgb2gray(old); %Grayscale image
%old = im2bw(old,graythresh(old)); %Black and white image

op = true;
p = size(old,1) * size(old,2) * 0.05; %Number of acceptable noise pixels to detect a movement.

while op
    
    new = snapshot(cam);
    new = flip(new,2);%Rotate the image.
    new = rgb2gray(new);%Grayscale image
    %new = im2bw(new,graythresh(new));%Black and white image
    var = new ~= old;
    %var(var<0)=1;
    e = strel('square',8);
    var = imerode(var,e);
    var = imerode(var,e);
    imshow(var);
    
    if(sum(sum(var)) > p)
        m = movement(var);
        if (m == 5)
            op = false; %Stop the loop and go to the speech recogntion
            
        else
            moveRobot(b, m);
        end
        %pause(3);
    end
   
    old = new;
    pause(1);
end

delete(cam)
delete(b)