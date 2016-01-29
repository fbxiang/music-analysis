function out = chordEstimation(weighedNameLoudness)
%weighedAmpLoudness=getDefaultWeighedAmpSqr(noteAmp);
%weighedNameLoudness=getWeighedNameSqr(weighedAmpLoudness);
allChordLoudness=findAllChordLoudness(weighedNameLoudness);
[root,property]=findBestFit(allChordLoudness);
propertyTable={'maj','min','dim','aug'};
noteTable={'C ', 'Db ', 'D ', 'Eb ', 'E ', 'F ', 'Gb ', 'G ', 'Ab ', 'A ', 'Bb ', 'B '};
[root7th,property7th]=findBest7th(root,property,weighedNameLoudness,allChordLoudness);
property7thTable={'M7','m7','7','dim7','halfdim7','Mm7'};
if property7th==0
    out=strcat(noteTable(root),propertyTable(property));
else
    out=strcat(noteTable(root7th),property7thTable(property7th));
end
end

function [root7th,property7th]=findBest7th(root,property,weighedNameLoudness,allChordLoudness)
weighedNameLoudness=[weighedNameLoudness weighedNameLoudness];
threshold=allChordLoudness(property,root)/8;
property7th=0;
root7th=root;
if property==1
    if weighedNameLoudness(root+9)>threshold
        root7th=mod((root+9)-1,12)+1;
        property7th=2;
    end
    if weighedNameLoudness(root+11)>threshold && weighedNameLoudness(root+11)>weighedNameLoudness(root+9);
        root7th=root;
        property7th=1;
    end
    if weighedNameLoudness(root+10)>threshold && weighedNameLoudness(root+10)>max(weighedNameLoudness(root+11),weighedNameLoudness(root+9))
        root7th=root;
        property7th=3;
    end
end
if property==2
   if weighedNameLoudness(root+8)>threshold
       root7th=mod((root+8)-1,12)+1;
       property7th=1;
   end
   if weighedNameLoudness(root+10)>threshold && weighedNameLoudness(root+10)> weighedNameLoudness(root+8)
       root7th=root;
       property7th=2;
   end
   %if weighedNameLoudness(root+9)>threshold && weighedNameLoudness(root+9)> max(weighedNameLoudness(root+8),weighedNameLoudness(root+10))
   %    root7th=mod((root+9)-1,12)+1;
   %    property7th=5;
   %end
   if weighedNameLoudness(root+11)>threshold && weighedNameLoudness(root+11)> max([weighedNameLoudness(root+8),weighedNameLoudness(root+10),weighedNameLoudness(root+9)])
       root7th=root;
       property7th=6;
   end
end
if property==3
    if weighedNameLoudness(root+8)>threshold
        root7th=mod((root+8)-1,12)+1;
        property7th=3;
    end
    if weighedNameLoudness(root+9)>threshold && weighedNameLoudness(root+9)>weighedNameLoudness(root+8)
        root7th=root;
        property7th=4;
    end
    %if weighedNameLoudness(root+10)>threshold && weighedNameLoudness(root+10)> max(weighedNameLoudness(root+8),weighedNameLoudness(root+9));
    %    root7th=root;
    %    property7th=5;
    %end
end
if property==4
    %if weighedNameLoudness(root+9)>threshold
    %    root7th=mod((root+9)-1,12)+1;
    %    property7th=6;
    %end
end
end



function [root,property]=findBestFit(allChordSqr)
[property,root]=find(allChordSqr==max(max(allChordSqr)));
property=property(1);
root=root(1);
end

function allChordLoudness=findAllChordLoudness(weighedNameLoudness)
allChordLoudness=zeros(4,12);
for i=1:4
    for j=1:12
       allChordLoudness(i,j)=findChordLoudness(j,i,weighedNameLoudness);
    end
end
end

function chordLoudness=findChordLoudness(root,property,weighedNameLoudness)
weighedNameLoudness=[weighedNameLoudness weighedNameLoudness];
if property==1
    chordLoudness=weighedNameLoudness(root)+weighedNameLoudness(root+4)+weighedNameLoudness(root+7);
elseif property==2
    chordLoudness=weighedNameLoudness(root)+weighedNameLoudness(root+3)+weighedNameLoudness(root+7);
elseif property==3
    chordLoudness=weighedNameLoudness(root)+weighedNameLoudness(root+3)+weighedNameLoudness(root+6);
elseif property==4
    chordLoudness=weighedNameLoudness(root)+weighedNameLoudness(root+4)+weighedNameLoudness(root+8);
end
end
