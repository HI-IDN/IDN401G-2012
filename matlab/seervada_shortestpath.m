n = 7;
M = 100
c = M*ones(n,n);

O=1;A=2;B=3;C=4;D=5;E=6;T=7;
c(O,A) = 2; c(A,O) = 2; 
c(O,B) = 5; c(B,O) = 5; 
c(O,C) = 4; c(C,O) = 4; 
c(A,B) = 2; c(B,A) = 2; 
c(A,D) = 7; c(D,A) = 7; 
c(B,C) = 1; c(C,B) = 1; 
c(B,D) = 4; c(D,B) = 4; 
c(B,E) = 3; c(E,B) = 3; 
c(C,E) = 4; c(E,C) = 4; 
c(D,E) = 1; c(E,D) = 1; 
c(D,T) = 5; c(T,D) = 5; 
c(E,T) = 7; c(T,E) = 7; 
Amat = zeros(n,n*n);
for i=1:n, 
  Amat(i,(1+(i-1)*n):i*n) = ones(1,n); 
  Amat(i,i:n:n*n) = Amat(i,i:n:n*n) - ones(1,n);
end
spy(Amat) % skoda A fylkid sem mynd
b = zeros(n,1); b(1) = 1; b(n) = -1;
c = c(:);
[x,fmin] = linprog(c,[],[],Amat,b,zeros(1,n*n));
reshape(x,n,n)
