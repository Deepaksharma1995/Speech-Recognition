function audio 
%function to create audio file database
%%
rec_time=1.5;   %change rec length 

obj=audiorecorder(44100,16,1);

%%
filename=input('Enter file name: ','s');

disp('recording');
recordblocking(obj,rec_time);
disp('recording done');

%%
y=getaudiodata(obj);

bpfil=designfilt('bandpassiir','FilterOrder',30,'HalfPowerFrequency1',100,'HalfPowerFrequency2',10000,'SampleRate',44100);
fil_y=filter(bpfil,y);

audiowrite(filename,fil_y,44100);
% correction=955 samples, clipping of samples

end