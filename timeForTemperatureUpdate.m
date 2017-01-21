function [res] = timeForTemperatureUpdate(itersWithoutImprovement,markovChainLength,maxChainLength)

%the function assesses if it is time to update the temperature based on the
%number of iterations carried out with no improvement,the length of the
%markov chain formed and the maximum possible markovChainLength

%if the maximum markov chain length is reached we must update T
if markovChainLength>=maxChainLength
    
    res=true;
    return;
    
elseif markovChainLength==itersWithoutImprovement && itersWithoutImprovement >=20
    
    %if we experience 20 iterations without improvement we must update T
    res=true;
    return;

elseif itersWithoutImprovement > 500
    
    %if we have an unusually large number of iterations without improvement
    res=true;
    return;
else

    %otherwise we don't update yet
    res=false;
    return;

end

%**
%may still need some work