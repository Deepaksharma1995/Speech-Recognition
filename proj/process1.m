function [seq]=process1

rec_time=4;
n=16;
channel=1;
fs=44100;

%%
% speech for what can i do

%%
obj1=audiorecorder(fs,n,channel);
disp('speak')
recordblocking(obj1,rec_time);
disp('recording ended');

z=getaudiodata(obj1);

%%
bpfilt= designfilt('bandpassiir','FilterOrder',20,'HalfPowerFrequency1',100,'HalfPowerFrequency2',10e3,'SampleRate',fs);
f_speech=filter(bpfilt,z);

%%
seq=checkSpeech(f_speech);      %returns operation to be performed

switch seq
    case 1
        disp('toggling lights');
    case 2
        disp('toggling fan');
end

end