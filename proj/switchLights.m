function [lights]=switchLights(obj_a,pin,curr_lights)
%function to toggle lights

writeDigitalPin(obj_a,pin,~curr_lights);
lights=~curr_lights;

%%
%lights toggled speech

end