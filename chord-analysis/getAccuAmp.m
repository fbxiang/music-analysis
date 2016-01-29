function accuAmp=getAccuAmp(timeIn,freq,amp,error)
[~,amp]= getNoteTimeAmp(timeIn,freq,amp,error);
accuAmpSqr=zeros(1,size(amp,2));
for i=1:size(amp,2);
    for j=1:size(amp,1)
        accuAmpSqr(i)=accuAmpSqr(i)+amp(j,i).^2;
    end
end
accuAmp=sqrt(accuAmpSqr);
%subplot(212);
%plot(accuAmpSqr);
%set(gca,'xtick',1:108);
%set(gca,'XTickLabel',{'C',' ','D',' ','E','F',' ','G',' ','A',' ','B'});
end