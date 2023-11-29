clear variables;
close all;
clc

outputs = readtable ("output.txt" );
L = numel(outputs) / 3;                     %Height of table = total number of elements / 3

AsicNN  = table2array(outputs(4:L,1));      %discard the first 3 entries that correspond to rubbish in the pipeline
OrigNN  = table2array(outputs(1:L-3,2));    %discard the last 3 outputs
GrTruth = table2array(outputs(1:L-3,3));    %discard the last 3 outputs

wrtOrigNN = 0;
wrtGroundTruth = 0;

for jj=1:(L-3)
    if (AsicNN(jj) == OrigNN(jj))
        wrtOrigNN = wrtOrigNN +1;
    end
       
    if (AsicNN(jj) == GrTruth(jj))
        wrtGroundTruth = wrtGroundTruth +1;
    end
end

Accuracy_with_Respect_to_the_Original_NN = (100 * wrtOrigNN) / (L-3)
Accuracy_with_Respect_to_the_Ground_Truth = (100 * wrtGroundTruth) / (L-3)

