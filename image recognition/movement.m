function m = movement(difImage)

   col = size(difImage, 2);
   row = size(difImage, 1);
   
   quaC1 = round(col/3); %Size of the first quadrant by columns of the image.
   quaC2 = quaC1*2; %Second quadrant and the third is the number of columns.
   
   quaR1 = round(row/3); %Size of the first quadrant by rows of the image.
   quaR2 = quaR1*2; %Second quadrant and the third is the number of rows.
   
   pQuadran = [sum(sum(difImage(:,1:quaC1))), sum(sum(difImage(1:quaR1,quaC1:quaC2)))+sum(sum(difImage(quaR2:row,quaC1:quaC2))), sum(sum(difImage(:,quaC2:col)))];
   %In the middle quadrant by columns, we don't add the central quadrant to
   %substract the arm movement.
   
   [~, quaCMax] = max(pQuadran); %Index of the quadrant of maximum number of movement pixel.
   p = quaC1 * quaR1 * 0.0001; %Number of acceptable noise pixels.
   
   switch quaCMax
       case 1 %Right movement.
           m = 3;
%            disp('You move to the Left!!');
           %pause(2);
       case 2 %Up or Down movement
           nPix = sum(sum(difImage(1:quaR1,quaC1:quaC2)));
           if(nPix > 0)
               m = 1;
%                disp('You move Up!!');
               %pause(2);
           else
               nPix = sum(sum(difImage(quaR2:row,quaC1:quaC2)));
               if(nPix > 0)
                   m = 2;
%                    disp('You move Down!!');
                   %pause(2);
               else
                   m = 0;
               end
           end
        case 3 %Speech or left movement
           nPix = sum(sum(difImage(1:quaR1,quaC2:col)));
           if(nPix < p)
               m = 4;
%                disp('You move to the Right!!');
               %pause(2);
           else
               m = 5;
               disp('You move to Speech Recognition!!');
               %pause(2);
           end
   end
   
end