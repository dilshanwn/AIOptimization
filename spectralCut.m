function [e,p]=spectralCut(A)
% This function calculates a partitioning and associated cut of a 
% graph A, using the spectral method.  You can compare the answer that
% the method gives with the ouput of the SA and GA code

eps = 10^-10;
N = size(A,1);
% Form the Laplacian matrix

D = sparse(1:N, 1:N, sum(A,2));
L = D - A;

% Get the eigenvector corresponding to the second smallest e-value of L
% Note that the smallest eigenvalue of L is 0

[V,E] = eigs(L,2,'sm');
if (abs(E(1,1))<eps)
    V = V(:,2);
else
    V = V(:,1);
end

% pick the indices of the N/2 smallest values of V as the nodes for one
% of the partitions.

[v,indx]=sort(V);

p = zeros(N,1);
p(indx(1:N/2))=1;

% Calculate and return the resulting edge cut

e = edgeCut(A,p);