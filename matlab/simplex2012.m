clc, clear all 

b=[60 72 54]';  % c=ceil(10*rand(3,1))
c=[6 3 2]; % b=ceil(10*rand(3,1))
% A=magic(3);
A=[  5    2     6;     3     4     6;      4     3     5];
Aleq=A(1,:); bleq=b(1);
Ageq=A(2,:); bgeq=b(2);
Aeq=A(3,:);  beq=b(3);
T=simplex_bigM(c,Aleq,bleq,Aeq,beq,Ageq,bgeq)
T=simplex_bigM(-c,Aleq,bleq,Aeq,beq,Ageq,bgeq)

[m,n]=size(A);

T=[-c 0 100 100 0; A eye(m) b];
T=[T(:,1:6) [0 0 0 -1]' T(:,end)]

% eiginlegt form 
T=pivot(T,3,5);
T=pivot(T,4,6);

T

% bestun #1
  [maxmin,dalkur]=min(T(1,1:end-1));
  if maxmin>=0, 
    fprintf('bestun lokið í ítrun \n'); 
  end
  hlutfall=T(2:end,end)./T(2:end,dalkur)   
  skorda=3
  T=pivot(T,skorda+1,dalkur)
  
end
