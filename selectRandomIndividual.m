function [k]=selectRandomIndividual(psize)

%the second member of the population is obsolete in SA so we can only have
%person 1 mutate
if psize==1
    k=1;
    return;
end

%not so in the case of the Genetic Algorithm
%randomly mutate any of the people that are in the population--mutation is
%not dependent on your breeding status

%standard random selection
k=ceil(2*psize*rand);

