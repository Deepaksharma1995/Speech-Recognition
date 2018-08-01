rec_time=2;
n=16;
channel=1;
fs=44100;

[x,fs1]=audioread('lights.mp4');
[y,fs2]=audioread('fan.mp4');

obj1=audiorecorder(fs,n,channel);
disp('speak')
recordblocking(obj1,rec_time);
disp('recording ended');

z=getaudiodata(obj1);

%[x,y,D]=alignsignals(x,y);

%%

bpfilt= designfilt('bandpassiir','FilterOrder',20,'HalfPowerFrequency1',100,'HalfPowerFrequency2',10e3,'SampleRate',fs);
f_speech=filter(bpfilt,z);

%%
corr1= xcorr(x,z);
%corr=corr./abs(max(corr));
m1=max(corr1);
%plot(corr);

corr2=xcorr(y,z);
m2=max(corr2);

if m1>m2                %initiate lights command
    sound(x,fs1);
elseif m1<m2            %initiate fan command
    sound(y,fs2);
end
    