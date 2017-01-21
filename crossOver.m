function [pop,rank,eval]=crossOver(pop,rank,eval,A,numCrossOvers)

    % one point crossover
    
    
    % should firstly create an intermediate population and apply crossover
    % to the intermediate pop.  Here I'll just select from the original
    % population according to their fitness  and apply crossover directly
    
    
    
    N=size(pop,1);
    psize=ceil(size(pop,2)/2);
    
    maxCut=sum(A*ones(N,1));
    
    sortedEval=eval(rank);
    
    fitness = maxCut - sortedEval(1:psize);
    
    fitness = fitness/mean(fitness);
    
    totalFitness=sum(fitness);
    
    markers = cumsum(fitness/totalFitness);
    
    
    
    for i=1:numCrossOvers

        for p=1:2

            k = rand();

            j=1;

            while (k>markers(j))
                j=j+1;
            end

            parent(p) = rank(j);

        end
        
        newMember = rank(psize+i);
        % one point crossover
        
        crosspoint = ceil(rand()*N);
        
        pop(:,newMember) = [pop(1:crosspoint,parent(1)); pop(crosspoint+1:N,parent(2))];
        
        
        % but now need to make it a feasible soluion i.e. #zeros = #ones
        s = sum(pop(:,newMember));
        
        while (N/2-s>0)
           pos = ceil(rand()*N);
           if (pop(pos,newMember)==0)
               pop(pos,newMember) =1;
               s = s+1;
           end
        end
        
        while (N/2-s<0)
            
           pos = ceil(rand()*N);
           if (pop(pos,newMember)==1)
               pop(pos,newMember) =0;
               s = s-1;
           end
        end
        
        % finally, evaluate the new child, so it can take correct rank in
        % the population
        
        eval(newMember) = edgeCut(A,pop(:,newMember));
        
        r=1;
        
        while (r<=psize+i && (eval(newMember) > eval(rank(i))))
            r = r+1;
        end
        
        % shift the ranks forward
        
        for j=psize+i:-1:r+1
            rank(j) = rank(j-1);
        end
        rank(i) = newMember;
    end
end
        
            
         
            
        
    
    
   