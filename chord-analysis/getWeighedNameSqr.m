
function weighedNameLoudness=getWeighedNameSqr(weighedLoudness)
columnwizeLoudness=reshape(weighedLoudness,12,9);
weighedNameLoudness=sum(columnwizeLoudness,2);
weighedNameLoudness=weighedNameLoudness';
end