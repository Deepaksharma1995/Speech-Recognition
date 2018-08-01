%a function to read input speech and to decide command specified in it.
function [seq]= checkSpeech(z) 

[x]=audioread('lights.mp4');
[y]=audioread('fan.mp4');

correction=955;     %clipping of file during audiowrite

x=x(correction+1:length(x));
y=y(correction+1:length(y));

frame1=length(x);
frame2=length(y);

seq=3;          %1=lights,2=fan,3=none
start=1;
a=[];           %for lights
b=[];           %for fan

%%
% obj1=audiorecorder(44100,16,1);
% disp('speak')
% recordblocking(obj1,4);
% disp('recording ended');
% 
% z=getaudiodata(obj1);
% 
% bpfilt= designfilt('bandpassiir','FilterOrder',30,'HalfPowerFrequency1',100,'HalfPowerFrequency2',10e3,'SampleRate',44100);
% z=filter(bpfilt,z);     
%%
while (start+frame1)<length(z)
    frag=z(start:(start+frame1)-1);    %fragment of speech selected
    a=[a,max(xcorr(frag,x))];           
    start=(start+frame1);
end

start=1;

while (start+frame2)<length(z)
    frag=z(start:(start+frame2)-1);    %fragment of speech selected
    b=[b,max(xcorr(frag,y))];
    start=start+frame2;
end

%%
if max(a)>max(b) 
    sound(x,44100);
    seq=1;
    
elseif max(a)<max(b) 
    sound(y,44100);
    seq=2;
    
else
    disp('equal correlation, Error!');
end

end