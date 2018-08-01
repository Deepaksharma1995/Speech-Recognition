function [fan]=switchFan(obj_a,pin,curr_fan)
%function to toggle fan

writeDigitalPin(obj_a,pin,~curr_fan);
fan=~curr_fan;

%%
%fan toggle speech

end