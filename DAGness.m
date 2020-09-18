function [h] = DAGness(W)
    % Zheng X, Aragam B, Ravikumar P, et al. 2018,31
    h = trace(expm(W.*W)) - size(W,1);
end

