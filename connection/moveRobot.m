% Function moveRobot
%
% Move our robot
%
% b: Bluetooth object
% m: move / class recognized

function moveRobot(b, m)
    switch m
        case 1 % Forward
            disp('You said... Forward!!');
            fprintf(b,"f"); pause(2); fprintf(b,"s");
        case 2 % Back    
            disp('You said... Back!!');
            fprintf(b,"b"); pause(2); fprintf(b,"s");
        case 3 % Left
            disp('You said... Left!!');
            fprintf(b,"l"); pause(1); fprintf(b,"s");         
        case 4 % Right
            disp('You said... Right!!');
            fprintf(b,"r"); pause(1); fprintf(b,"s");        
        case 5 % Stop
            disp('You said... Stop!!');
            fprintf(b,"s");     
        case 6 % Image
            disp('You said... Image!!');
            % Move to image gui
        case 7 % Speech
            % Move to speech gui
    end
end