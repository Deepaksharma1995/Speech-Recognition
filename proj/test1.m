%recording audio
Fs=44100;       %sampling freq
n=16;           %bits per sample
chan=1;         %2=stereo;1=mono
rec_time=2;

obj=audiorecorder(Fs,n,chan);

disp('start speaking');
recordblocking(obj,rec_time);   %records for 2s.
disp('end recording');

t=[0:1/Fs:rec_time-(1/Fs)];
%%
%playing audio
play(obj);
%%
%plotting sampled audio and its dft.
y=getaudiodata(obj);
figure(1),plot(t,y');
title('speech input');

ydft=fft(y);
ydft=ydft(1:length(ydft)/2+1);
freq=[0:Fs/length(y):Fs/2];
figure(2),plot(freq,abs(ydft)');
title('dft of speech i/p');

%%
%filtering audio
bpfilt= designfilt('bandpassiir','FilterOrder',20,'HalfPowerFrequency1',100,'HalfPowerFrequency2',10000,'SampleRate',Fs);
filter_sound=filter(bpfilt,y);
figure(3),plot(t,filter_sound');
title('speech after noise filtering');

zdft=fft(filter_sound);
zdft=zdft(1:length(zdft)/2+1);
figure(4),plot(freq,abs(zdft));
title('dft after noise filtering');
%%
%saving sound
unfiltered='one.mp4';
audiowrite(unfiltered,y,Fs);

filtered='two.mp4';
audiowrite(filtered,filter_sound,Fs);
