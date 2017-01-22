N={100,200,300,1000,10000};
ALPHA={0.7,0.8,0.9};
MAXGEN={50000,100000,500000};


[A,t,x,y] = makePlanarSparse(N{1});
spy(A);
gplot(A,[x,y]);

[cut, soln] = graphPartitioning(A, 1, 0,0.8,100000);
t1 = load("-ascii", "time.txt");
q1 = load("-ascii", "besteval.txt");
[cut, soln] = graphPartitioning(A, 1, 0,0.8,100000);
t2 = load("-ascii", "time.txt");
q2 = load("-ascii", "besteval.txt");
[cut, soln] = graphPartitioning(A, 1, 0,0.8,100000);
t3 = load("-ascii", "time.txt");
q3 = load("-ascii", "besteval.txt");


q = (q1+q2+q3)/3;
t = (t1+t2+t3)/3;



hold on;
      plot(q);
      print( gcf, '-dpng', fullfile( outputPath,sprintf('Figure %d %d %d - %d - %d %d.png',i,j,k,N{i},ALPHA{j},MAXGEN{k}) ) );
hold off;

hold on;
      plot(t);
      print( gcf, '-dpng', fullfile( outputPath,sprintf('Figure %d %d %d - %d - %d %d.png',i,j,k,N{i},ALPHA{j},MAXGEN{k}) ) );
hold off;

hold on;
      plot(t, q);
      print( gcf, '-dpng', fullfile( outputPath,sprintf('Figure %d %d %d - %d - %d %d.png',i,j,k,N{i},ALPHA{j},MAXGEN{k}) ) );
hold off;




