N={100,1000,10000};
P = {2,10,50};
cr={0.0 , 0.2 , 0.4 , 0.5 , 0.6};
mu={0.0 , 0.1};
outputPath = pwd;

for i=1:columns(N)

[A,t,x,y] = makePlanarSparse(N{i});


  spy(A);
  print( gcf, '-dpng', fullfile( outputPath,sprintf('Figure GA spy - %d.png',N{i}) ) );
  pause(5);


  gplot(A,[x,y]);
  print( gcf, '-dpng', fullfile( outputPath,sprintf('Figure GA gplot - %d.png',N{i}) ) );
  pause(5);

for j=1:columns(P)

  for k=1:columns(cr)
    for z=1:columns(mu) 
      
      [cut, soln] = graphPartitioningGA1(A, P{j}, 1,cr{k},mu{z});
      t1 = load("-ascii", "time.txt");
      q1 = load("-ascii", "besteval.txt");
      [cut, soln] = graphPartitioningGA1(A, P{j}, 1,cr{k},mu{z});
      t2 = load("-ascii", "time.txt");
      q2 = load("-ascii", "besteval.txt");
      [cut, soln] = graphPartitioningGA1(A, P{j}, 1,cr{k},mu{z});
      t3 = load("-ascii", "time.txt");
      q3 = load("-ascii", "besteval.txt");

      q = (q1+q2+q3)/3;
      t = (t1+t2+t3)/3;

      plot(q);
      print( gcf, '-dpng', fullfile( outputPath,sprintf('Figure GA Quality N %d P %d  cr %d mu %d.png',N{i},P{j},cr{k},mu{z}) ) );
      pause(5);


      plot(t);
      print( gcf, '-dpng', fullfile( outputPath,sprintf('Figure GA Time N %d P %d  cr %d mu %d.png',N{i},P{j},cr{k},mu{z}) ) );
      pause(5);


      plot(t, q);
      print( gcf, '-dpng', fullfile( outputPath,sprintf('Figure GA Time Quality N %d P %d  cr %d mu %d.png',N{i},P{j},cr{k},mu{z}) ) );
      pause(5);
      
 
    endfor
  endfor
  endfor
  endfor


