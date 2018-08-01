function FMatrix=friday
% Record your voice for 3 seconds.
recObj = audiorecorder;
disp('Start speaking.')
recordblocking(recObj, 4);
disp('End of Recording.');

% Play back the recording.
play(recObj);

s = getaudiodata(recObj);
fs=44100;
bfil=fft(s); %fft of input signal
wn=[8000 16000]/(fs/2);   %bandpass
[b,a]=butter(6,wn);
%fvtool(b,a);
f=filter(b,a,s);
figure(1)
plot(real(f));
afil=fft(f);

% afil=afil.*exp(-1i*2*pi*fs*(length(afil)+0.5));
figure(2)
subplot(2,1,1);plot(real(bfil));
title('frequency respones of input signal');
xlabel('frequency');ylabel('magnitude');
subplot(2,1,2);plot(real(afil));
title('frequency respones of filtered signal');
xlabel('frequency');ylabel('magnitude');
% FM=melcepst(s);
% figure,plot(FM);

Fs=16000;
num=13;
n=512;              
Tf=0.025;           
N=Fs*Tf;
fn=24;              
l=length(s);        
Ts=0.01;            
FrameStep=Fs*Ts;    
a=1;
b=[1, -0.97];       

noFrames=floor(l/FrameStep);    
FMatrix=zeros(noFrames-2, num); 
lifter=1:num;                   
lifter=1+floor((num)/2)*(sin(lifter*pi/num));

if mean(abs(s)) > 0.01
    s=s/max(s);                     
end

for i=1:noFrames-2
    frame=s((i-1)*FrameStep+1:(i-1)*FrameStep+N);  
    Ce1=sum(frame.^2);          
    Ce2=max(Ce1,2e-22);         
    Ce=log(Ce2);
    framef=filter(b,a,frame);   
    F=framef.*hamming(N);      
    FFTo=fft(F,N);              
    melf=melbankm(fn,n,Fs);     
    halfn=1+floor(n/2);    
    spectr1=log10(melf*abs(FFTo(1:halfn)).^2);
    spectr=max(spectr1(:),1e-22);
    c=dct(spectr);              
    c(1)=Ce;                    
    coeffs=c(1:num);            
    ncoeffs=coeffs.*lifter';    
    FMatrix(i, :)=ncoeffs'; 
end
figure,plot(FMatrix);
end