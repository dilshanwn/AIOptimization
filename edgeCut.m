function e=edgeCut(A,x)
    % note both terms are the same if A is symmetric
    e= not(x)'*A*x + x'*A*not(x);
    e = e/2;