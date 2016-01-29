function noteWeight=getNoteWeight(octaveWeight)
noteWeight=[];
for i=1:12
    noteWeight=[noteWeight;octaveWeight];
end
noteWeight=reshape(noteWeight,1,108);
end