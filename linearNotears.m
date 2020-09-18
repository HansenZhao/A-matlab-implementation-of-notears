function [estW] = linearNotears(X,lambda,options)
    if ~exist('options','var')
        options = struct();
        options.maxiter = 200;
        options.rhoMax = 1e16;
        options.h_tol = 1e-8;
        options.w_theshold = 0.2;
    end
    
    if ~isfield(options,'maxiter')
        options.maxiter = 200;
    end
    if ~isfield(options,'rhoMax')
        options.rhoMax = 1e16;
    end
    if ~isfield(options,'h_tol')
        options.h_tol = 1e-8;
    end
    if ~isfield(options,'w_theshold')
        options.w_theshold = 0.2;
    end
    
    [~,nfactor] = size(X);
    estW = zeros(nfactor);
    rho = 1;
    alpha = 0;
    h = inf;
    X = X - mean(X);
    
    for m = 1:options.maxiter
        while rho<options.rhoMax
            res = fminsearch(@(w)lossFunc(X,rho,alpha,lambda,w),estW(:), optimset('Display','none'));
            newW = reshape(res,[nfactor,nfactor]);
            newH = DAGness(newW);
            
            if newH > h/4
                rho = rho * 10;
            else
                break;
            end
        end
        estW= newW;
        h = newH;
        if h < options.h_tol || rho > options.rhoMax
            break;
        end
    end
    
    estW(abs(estW)<options.w_theshold) = 0;
end

function L = lossFunc(X,rho,alpha,lambda,w)
    [n,d] = size(X);
    w = reshape(w,[d,d]);
    h = DAGness(w);
    
    L1 = (X - X*w).^2;
    L1 = sum(L1(:))/(2*n); % ||X-XW||^2 / 2n
    
    L2 = rho*h*h/2;
    
    L3 = alpha * h;
    
    L4 = lambda*sum(w(:));
    
    L = L1 + L2 + L3 + L4;
end

