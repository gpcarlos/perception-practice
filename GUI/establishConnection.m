% Function establishConnection
%
% Establish bluetooth connection with our robot

function b = establishConnection
    b = Bluetooth('DCE06',1);
    fopen(b);
end