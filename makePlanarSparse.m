function [A,tri,x,y]=makePlanarSparse(N)


alpha=1.0;

M1=floor(alpha*N);
M2=N-M1;


x=zeros(N,1);
y=zeros(N,1);

x(1:M1)=1.0*rand(M1,1);
y(1:M1)=1.0*rand(M1,1);


x(M1+1:N)=0.5+0.5*rand(M2,1);
y(M1+1:N)=0.5+0.5*rand(M2,1);





tri=delaunay(x,y);
A=sparse(zeros(N,N));


for i=1:size(tri,1),
  A(tri(i,1),tri(i,2))=1;
  A(tri(i,1),tri(i,3))=1;
  A(tri(i,3),tri(i,2))=1;
end

A=A+A';

A = 1.0*(A>0);









    