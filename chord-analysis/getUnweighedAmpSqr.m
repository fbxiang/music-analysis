function weighedLoudness=getUnweighedAmpSqr(noteAmp)
weighedLoudness=getWeighedAmpSqr(noteAmp, getNoteWeight([1,1,1,1,1,1,1,1,1]));
end