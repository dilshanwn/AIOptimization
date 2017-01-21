function pop=makeRandomPopulation(N,size)

   pop=zeros(N,size); 
   %allow twice the actual population size so that there will be room to add new individuals
   %later when performing crossover
   
   
   
   
   for s=1:size
       
       % for each member of the population, select N/2 random positions in
       % the length N vector pop(:,s) and set the value at those positions
       % to 1.  Hence pop(:,s) represents a partitioning of the graph into
       % 2 paritions.
       
       indices=1:N;
   
       M=N;
       
   
       for i=1:N/2

           k = ceil(rand()*M);

           index = indices(k);
           indices(k)=indices(M);
           M=M-1;

           pop(index,s)=1;
       end
   end
       

