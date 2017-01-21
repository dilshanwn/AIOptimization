function [pop,rank,eval]=applyMutation(pop,rank,eval,k,a,b,dE)

%function that applies the mutation and reevaluates

%create a temporary variable
tmp=pop(a,k);

%write over a with b
pop(a,k)=pop(b,k);
%use tmp to write over b with a
pop(b,k)=tmp;

%the new evaluation is the old evaluation + dE
eval(k)=eval(k)+dE;

%reevaluate the rank matrix
[tmp,rank]=sort(eval);


return;

