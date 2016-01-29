function [chord]=test(data,fs)
[t,f,a]=stft(16384,data,fs,8000);
[time,noteAmp]=getNoteTimeAmp(t,f,a,0.2);
chord=cell(1,size(noteAmp,1));
for i=1:size(noteAmp,1)
    chord{i}=chordEstimation(noteAmp(i,:));
end
end