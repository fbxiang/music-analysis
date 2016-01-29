function peaks=peakDetection(data,halfWidth,heightRate)
allMax=findAllMax(data);
peaks=determinePeak(data,allMax,halfWidth,heightRate);
end

function allMax=findAllMax(data)
allMax=[];
for i=2:length(data)-1
   if data(i)>data(i-1) && data(i)>data(i+1);
       allMax = [allMax i];
   end
end
end

function peaks=determinePeak(data,allMax,halfWidth,heightRate)
peaks=[];
for i=1:length(allMax)
    index=allMax(i);
    h=data(index)*(1-heightRate);
    startP=0;
    if isempty(peaks)
        startP=max(1,index-halfWidth);
    else
        startP=max(peaks(length(peaks)),index-halfWidth);
    end
    for p=startP:index
        if (data(p)<h && data(p)>0)
            peaks=[peaks allMax(i)];
            break;
        end
    end
end
end