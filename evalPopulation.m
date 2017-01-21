function [eval,rank]=evalPopulation(A,pop)

    psize = size(pop,2);

    N = size(pop,1);
   
    
    
    eval=zeros(psize,1);
    
    for i=1:psize
        
        x = pop(:,i);
        
        eval(i) =  edgeCut(A,x);
        
    end
    
    
   [y, rank]=sort(eval);