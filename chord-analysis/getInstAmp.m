function InstAmp=getInstAmp(amp)
InstAmp=zeros(1,size(amp,2));
for i=1:size(amp,2);
InstAmp(i)=max(amp(:,i));
end
%plot(InstAmp);
%set(gca,'xtick',1:108);
%set(gca,'XTickLabel',{'C',' ','D',' ','E','F',' ','G',' ','A',' ','B'});
end