function weighedLoudness=getWeighedAmpSqr(noteAmp, noteWeight)
weighedLoudness=(noteAmp.^2).*noteWeight;
end