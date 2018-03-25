function [ bestIndTheta,bestIndSample,bestK] = modularityEvaluation( A,allComN, sampleT)
thetaNum = length(allComN);
moOBCD = zeros(thetaNum,sampleT);
K = zeros(thetaNum,sampleT);

for i=1:thetaNum
    comN = allComN{i};
    for t=1:sampleT
         comK = comNtoComK(comN{t});
         K(i,t) = length(comK);
         moOBCD(i,t) = myModularity(A,comN{t},comK );
    end
end
[~,ind] = max(moOBCD(:));
[bestIndTheta,bestIndSample] = ind2sub(size(moOBCD),ind);

bestK = K(bestIndTheta,bestIndSample);


end

