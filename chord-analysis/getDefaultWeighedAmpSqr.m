function weighedLoudness=getDefaultWeighedAmpSqr(noteAmp)
noteWeight=getDefaultNoteWeight();
weighedLoudness=getWeighedAmpSqr(noteAmp,noteWeight);
end