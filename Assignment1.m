N={100,200,300,1000,1500};
ALPHA={0.7,0.8,0.9};
MAXGEN={50000,100000,500000};
outputPath = pwd;




for i=1:columns(N)

[A,t,x,y] = makePlanarSparse(N{i});


  spy(A);
  print( gcf, '-dpng', fullfile( outputPath,sprintf('Figure spy - %d.png',N{i}) ) );
  pause(5);


  gplot(A,[x,y]);
  print( gcf, '-dpng', fullfile( outputPath,sprintf('Figure gplot - %d.png',N{i}) ) );
  pause(5);


  for j=1:columns(ALPHA)
    for k=1:columns(MAXGEN)
      
      [cut, soln] = graphPartitioning(A, 1, 0,ALPHA{j},MAXGEN{k});
      t1 = load("-ascii", "time.txt");
      q1 = load("-ascii", "besteval.txt");
      [cut, soln] = graphPartitioning(A, 1, 0,ALPHA{j},MAXGEN{k});
      t2 = load("-ascii", "time.txt");
      q2 = load("-ascii", "besteval.txt");
      [cut, soln] = graphPartitioning(A, 1, 0,ALPHA{j},MAXGEN{k});
      t3 = load("-ascii", "time.txt");
      q3 = load("-ascii", "besteval.txt");

      q = (q1+q2+q3)/3;
      t = (t1+t2+t3)/3;

      plot(q);
      print( gcf, '-dpng', fullfile( outputPath,sprintf('Figure Quality %d %d %d - %d - %d %d.png\n',i,j,k,N{i},ALPHA{j},MAXGEN{k}) ) );
      pause(5);


      plot(t);
      print( gcf, '-dpng', fullfile( outputPath,sprintf('Figure Time %d %d %d - %d - %d %d.png\n',i,j,k,N{i},ALPHA{j},MAXGEN{k}) ) );
      pause(5);


      plot(t, q);
      print( gcf, '-dpng', fullfile( outputPath,sprintf('Figure Time Quality %d %d %d - %d - %d %d.png\n',i,j,k,N{i},ALPHA{j},MAXGEN{k}) ) );
      pause(5);
      
    endfor
  endfor

  
  
endfor


