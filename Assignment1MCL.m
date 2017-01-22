MCL={0.01 , 0.05, 0.1 , 0.2, 0.3, 0.4};

outputPath = pwd;

i=100;
j=0.99;
k=100000;




[A,t,x,y] = makePlanarSparse(100);


  spy(A);
  print( gcf, '-dpng', fullfile( outputPath,sprintf('Figure MCL spy - %d.png',100) ) );
  pause(5);


  gplot(A,[x,y]);
  print( gcf, '-dpng', fullfile( outputPath,sprintf('Figure MCL gplot - %d.png',100) ) );
  pause(5);


 
for z=1:columns(MCL)
      [cut, soln] = graphPartitioningMCL(A, 1, 0,0.99,100000,MCL{z});
      t1 = load("-ascii", "time.txt");
      q1 = load("-ascii", "besteval.txt");
      [cut, soln] = graphPartitioningMCL(A, 1, 0,0.99,100000,MCL{z});
      t2 = load("-ascii", "time.txt");
      q2 = load("-ascii", "besteval.txt");
      [cut, soln] = graphPartitioningMCL(A, 1, 0,0.99,100000,MCL{z});
      t3 = load("-ascii", "time.txt");
      q3 = load("-ascii", "besteval.txt");

      q = (q1+q2+q3)/3;
      t = (t1+t2+t3)/3;

      plot(q);
      print( gcf, '-dpng', fullfile( outputPath,sprintf('Figure MCL Quality %d %d %d - %d - %d %d.png\n',i,j,k,100,0.99,100000) ) );
      pause(5);


      plot(t);
      print( gcf, '-dpng', fullfile( outputPath,sprintf('Figure MCL Time %d %d %d - %d - %d %d.png\n',i,j,k,100,0.99,100000) ) );
      pause(5);


      plot(t, q);
      print( gcf, '-dpng', fullfile( outputPath,sprintf('Figure MCL Time Quality %d %d %d - %d - %d %d.png\n',i,j,k,100,0.99,100000) ) );
      pause(5);
      
  
  
  
endfor


