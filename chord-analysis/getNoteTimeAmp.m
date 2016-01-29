function [time,noteTimeAmp]=getNoteTimeAmp(timeIn,freq,amp,error)
noteTimeAmp=[];
for i=1:size(amp,1)
    noteTimeAmp=[noteTimeAmp;getNoteAmp(amp(i,:),freq(i,:),error)];
end
time=zeros(size(noteTimeAmp));
for i=1:size(time,2)
    time(:,i)=timeIn(:,1);
end
end
function maxAmp=getNoteAmp(amp,freq,error)
noteMap=1:108;
maxAmp=zeros(1,108);
for key=1:length(noteMap)
    lowerLim=key-error;
    upperLim=key+error;
    l=keyToFreq(lowerLim);
    r=keyToFreq(upperLim);
    values=amp(freq>l & freq<r);
    if isempty(values);
        maxAmp(key)=0;
    else
        maxAmp(key)=max(values);
    end
end
end
function result=keyToFreq(key)
    result=440*2.^((key-58)/12);
end