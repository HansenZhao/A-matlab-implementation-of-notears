function [X] = simuLinearSEM(W,nsample, noiseScale)
    thres = 0.001;
    
    nfactor = size(W,1);
    if ~exist('noiseScale','var')
        noiseScale = ones(1,nfactor);
    elseif isnumeric(noiseScale)
        noiseScale = noiseScale * ones(1,nfactor);
    end
    noiseScale = noiseScale(:)';
    assert(length(noiseScale) == nfactor);
    assert(DAGness(W)<thres);
    
    A = abs(W) > thres;
    sortedV = topoSort(A);
    X = zeros(nsample,nfactor);
    for m = 1:nfactor
        curPos = sortedV(m);
        parents = find(A(:,curPos));
        X(:,curPos) = X(:,parents) * W(parents,curPos) + noiseScale(curPos) * randn(nsample,1);
    end  
end

