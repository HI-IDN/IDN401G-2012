function T=simplex_bigM(c,Aleq,bleq,Aeq,beq,Ageq,bgeq)
% [x_opt,f_opt,T]=simplex(c,A,b) attempts to solve the linear programming problem:
%              min c'*x    subject to:   A*x <= b
%               x
% and returns the value of the objective function at x_opt: f_opt = c'*x_opt.
% and T is the final simplex table.



A = [Aleq;Aeq;Ageq];
b = [bleq;beq;bgeq];
m1=length(bleq); m2=length(beq); m3=length(bgeq);
slakar = m1+m2+2*m3;

[m,n]=size(A);

M=1000;

c_slakar = zeros(1,slakar);
S=zeros(m,slakar);

% minna en skorður -- bæta við slaka
S(1:m1,1:m1)=eye(m1);
% jafnt og skorður -- bæta við gervibreytu
S(m1+1:m1+m2,m1+1:m1+m2)=eye(m2);
c_slakar(m1+1:m1+m2)=M*ones(1,m2);
% stærri en skorður -- draga frá umframbreytu og bæta við gervibreytu 
S(m1+m2+1:m,m1+m2+1:m)=-eye(m3);
S(m1+m2+1:m,m+1:slakar)=eye(m3);
c_slakar(m+1:slakar)=M*ones(1,m3);

% Bý til T fylki
disp('Upphafleg Simplex tafla')
T=[1 -c c_slakar 0; zeros(m,1) A S b]

% Kem því á eiginlegt form
for i=1:m2
  T=pivot(T,1+m1+i,1+n+m1+i);
end
for i=1:m3
  T=pivot(T,1+m1+m2+i,1+n+m+i);
end
disp('Simplex tafla á eiginlegu formi')
T

% Bestun hefst
disp('Bestun hefst')

itrun = 0;
while itrun < 1000
  Z=T(1,1:end-1);
  if Z>=0, fprintf('Bestun lokið í %d ítrunum\n',itrun), break, end
  
  itrun = itrun+1;
  [~,vendidalkur]=min(Z);
  vendilina = minratio(T,vendidalkur);
  fprintf('Ítrun #%d: vendilína %d og vendidálkur %d\n',itrun,vendilina,vendidalkur);
  T=pivot(T,vendilina,vendidalkur)
    
end

end
