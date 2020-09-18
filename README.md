## A MATLAB implementation of linear notears DAG estimation algorithm

### Reference
```
Zheng X, Aragam B, Ravikumar P, et al. Dags with no tears: Continuous optimization for structure learning.
```

### Test
```MATLAB
W = [0,1,0,0;0,0,2,0.5;0,0,0,0;0,0,0,0]
X = simuLinearSEM(W,1000,1);
linearNotears(X,0.1)
```