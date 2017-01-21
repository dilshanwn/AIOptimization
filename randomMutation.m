function [a,b]=randomMutation(person)

%a function to find random indices to mutate in person

%find out how many genes a person has
N=length(person);

%generate the two indices
a=ceil(N*rand);
b=ceil(N*rand);

%we want the mutated indices to be different otherwise the mutation is
%pointless
while b==a
    b=ceil(N*rand);
end


return;

%done
