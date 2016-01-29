function [freq,amp]=toFreq(data,fs,maxFreq)
N=length(data);%the length of the data
n=0:N-1;%create an array 0, 1, 2, 3 ... length-1
y=data;%the sound points
Y=(fft(y,N))';%the built in method to perform FFT, return complex numbers including information on the phase
value=abs(Y)*2/N;%get the absolute value(amplitude) of frequencies
f=n*fs/N;%get the frequencies value represents
i=1;
if (f(ceil(N/2))>maxFreq)
    while f(i)<maxFreq
      i=i+1;
    end
else
    i=ceil(N/2);
end
%only left half of the data can be used
freq=f(1:i);
amp=value(1:i);
%return freq and amp
end