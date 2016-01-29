function [power,time]=getPower(size,data,fs,overlap)
p=0;
l=length(data);
time=[];
power=[];
while p+size<l
    time=[time (p+(size+1)/2)/fs];
    pow=0;
    for i=p+1:p+size
        pow=pow+data(i)*data(i);
    end
    power=[power pow];
    p=p+ceil(size*(1-overlap));
end
end