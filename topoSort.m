function [res] = topoSort(A)
    assert(DAGness(A)<0.001);
    L = size(A,1);
    res = zeros(L,1);
    count = 0;
    while(count < L)
        I = find(sum(A) == 0);
        nIndex = length(I);
        if nIndex>0
            for m = 1:nIndex
                if ~ismember(I(m),res)
                    res(count+1) = I(m);            
                    A(I(m),:) = 0;
                    count = count + 1;
                end
            end
        else
            error('unexpected stop');
        end
    end
end

