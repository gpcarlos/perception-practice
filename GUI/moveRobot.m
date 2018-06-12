% Function moveRobot
%
% Move our robot
%
% b: Bluetooth object
% m: move / class recognized

function moveRobot(b, m)
    switch m
        case 1 % Forward
            fprintf(b,"f"); pause(2); fprintf(b,"s");
        case 2 % Back    
            fprintf(b,"b"); pause(2); fprintf(b,"s");
        case 3 % Left
            fprintf(b,"l"); pause(2); fprintf(b,"s");         
        case 4 % Right
            fprintf(b,"r"); pause(2); fprintf(b,"s");        
    end
end