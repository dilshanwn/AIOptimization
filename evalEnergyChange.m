function dE=evalEnergyChange(pop,A,k,a,b)

% function to calculate the change in eval based on the the a => b mutation
% of individual k

% by right, this function should only calculate an update to the 
% edge cut caused by the flipping of a and b

c1 = pop(:,k);

c2 = c1;
c2(a) = pop(b,k);
c2(b) = pop(a,k);

dE = edgeCut(A,c2) - edgeCut(A,c1);



return;


