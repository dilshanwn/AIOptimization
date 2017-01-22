function [bestEval,bestSoln] = graphPartitioning(A, psize,ga,al,gen)

% A is the adjacency matrix of the graph to be partitioned
% psize is the size of the population (set psize=1 if using simulated
% annealing)
% ga is set to 1 if a genetic algorithm is to be used and set to 0 if
% simulated annealing is to be used

% This function depends on

% makeRandomPopulation : a function to create a random population of
% potential solutions

% evalPopulation : a function to evaluate each member of the population

% initialiseTemperature : a function to initialise the temperature of the
% annealing process

% crossOver : a function to apply a cross-over operator to the population

% randomMutation : a function to generate a random mutation

% evalEnergyChange : a function to evaluate the change in energy (i.e. the
% change in the evaluation function) induced by the given mutation

% applyMutation : a function to apply a random mutation

fp = fopen('besteval.txt','w');
fp2= fopen('time.txt','w');

    N = size(A,1);
    
    % For the GA, the crossover operator will create new children
    % so we'll make the population array twice the size of the population
    
    if (ga)
        pop=makeRandomPopulation(N,2*psize);
    else
        pop=makeRandomPopulation(N,psize);
    end
    
    % the eval array will store the evaluation of each member of the
    % populaton; the rank array will store the rank order of the members
    % of the population, from best to worst
    % Each generation, we will keep the population members identified by
    % pop(:,rank[1]) to pop(:,rank[psize)).  The remaining population
    % members will be overwritten by the crossover operator.
    
    [eval, rank]=evalPopulation(A,pop);
    
    
    % Some more parameters
    
    % here a fixed number of crossovers is chosen. Alternatively a
    % probability of crossover could be set using roulette wheel approach
    numCrossOvers=floor(psize*0.5);
    numMutations=floor(psize*0.1);
    numMutations = max(numMutations, 1);
    
    
    maxGenerations=gen; 
    maxChainLength=1000;
    alpha=al;
    
    
    itersWithoutImprovement=0;
    markovChainLength=0;
    
    % temperature initialisation can be complicated if you choose to
    % implement kirkpatrick's approach of increasing the temperature until
    % the acceptance probability is sufficiently high.  Alternatively, it
    % can be set by trial and error.  (For a genetic algorithm, set the
    % initial temperature to inf and then all mutations are accepted.) 
    T = initialiseTemperature(A,pop,ga);
    
    
    % For simplicity, we'll just run the algorithm for some fixed number of
    % generations (iterations).  A more complex stopping criterion could be
    % used instead
    tic;
    bestEval = inf;
    for i=1:maxGenerations
        
        
        [pop,rank,eval]=crossOver(pop,rank,eval,A,numCrossOvers);
        
        for j=1:numMutations
            
            k=selectRandomIndividual(psize);
            
            % a and b represent the indices of two positions to swap
            % in the kth member of the population
            
            [a,b]=randomMutation(pop(:,k));
            
            
            % before we apply the mutation, evaluate how much
            % the energy would change if the mutation were applied
            
            dE = evalEnergyChange(pop,A,k,a,b);
            
            % now apply the bolzmann criterion for keeping the solution
            
            if (dE<0 || rand()<exp(-dE/T))
                
                [pop,rank,eval]=applyMutation(pop,rank,eval,k,a,b,dE);
                
            end
        end
        
        % gather some statistics that will be used to update the parameters
        
        markovChainLength = markovChainLength+1;
        
        if (bestEval > eval(rank(1)))
            bestEval=eval(rank(1));
            bestSoln=pop(:,rank(1));
        else
            itersWithoutImprovement=itersWithoutImprovement+1;
        end
        
        if (timeForTemperatureUpdate(itersWithoutImprovement, markovChainLength,maxChainLength))
           T = alpha*T;
           itersWithoutImprovement=0;
           markovChainLength=0;
        end
        
       fprintf(fp2,'%f\n',toc); 
       fprintf(fp,'%d\n',bestEval); 
    end
fclose(fp);
fclose(fp2);        
    
                
                    
            
            
            
            
            
            
        
        