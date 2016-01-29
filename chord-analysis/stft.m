function [t,f,a]=stft(size,data,fs,maxFreq)
p=0;
l=length(data);
t=[];
f=[];
a=[];
while (p+size<=l)
    [freq,amp]=toFreq(data(p+1:p+size),fs,maxFreq);
    times=zeros(1,length(freq));
    times(:)=((p+(size+1)/2)/fs);
    t=[t;times];
    f=[f;freq];
    a=[a;amp];
    p=p+size;
end
%divide data
%do FFT on every small piece of data
end