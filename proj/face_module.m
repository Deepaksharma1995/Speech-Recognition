%main script
%%
% port='COM4';
% board='uno';
% 
 pin_l='D4';        %initialisation of light pin connection
 pin_f='D8';        %initialisation of fan pin connection
 
 response=1;
% 
lights= false;
fan= false;
% 
% %%
% if ~obj_a
%     obj_a=arduino(port,board);             %arduino connection initiation
% end
%
obj_a=arduino();
configurePin(obj_a,pin_l,'DigitalOut');
configurePin(obj_a,pin_f,'DigitalOut');

%%
while response==1
    
    seq=process1();          %calling module process1.m


    if seq==1                %toggle lights condition
        lights=switchLights(obj_a,pin_l,lights);

    elseif seq==2            %toggle fan condition
    fan=switchFan(obj_a,pin_f,fan);
    end
    
    response= input('Continue? : ');    % loop if 1 is entered.
end