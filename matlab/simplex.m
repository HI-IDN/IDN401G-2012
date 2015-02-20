function [x_opt,f_opt,T]=simplex(c,A,b)
% [x_opt,f_opt,T]=simplex(c,A,b) attempts to solve the linear programming problem:
%              min c'*x    subject to:   A*x <= b
%               x
% and returns the value of the objective function at x_opt: f_opt = c'*x_opt.
% and T is the final simplex table.

prenta=1;


[m,n]=size(A);

grunnur = n+1:n+m;

T=[1 -c zeros(1,m) 0; zeros(m,1) A eye(m) b];

if prenta, string='';
  for i=1:m+n+2
    string=[string ' %0.2f '];
  end
end

itrun = 0;
while itrun < 1000
  itrun = itrun+1;
  if prenta, fprintf([string '\n'],T'), end
  Z=T(1,:);
  if Z>=0, fprintf('Bestun lokið í %d ítrunum\n',itrun), break, end
  [dummy,vendidalkur]=min(Z);
  
  vendilina = minratio(T,vendidalkur);
  T=pivot(T,vendilina,vendidalkur);
  if prenta, fprintf('Ítrun #%d: pivot(%d,%d)\n',itrun,vendilina,vendidalkur); end
  
  fer_ut = find(grunnur==vendilina);
  grunnur(fer_ut)=vendidalkur;

end

x_opt=zeros(m+n);
x_opt(grunnur)=T(2:end,end);
x_opt=x_opt(1:n);
f_opt=T(1,end);

end

% HJÁLPARFALL - PIVOT
function T = pivot(T,i,j),
[m, n] = size(T);
T(i,:) = T(i,:) / T(i,j);
for k = [1:i-1,i+1:m]
  T(k,:) = T(k,:) - T(k,j) * T(i,:);
end
end

% HJÁLPARFALL - MINRATIO
function vendilina = minratio(T,vendidalkur)
hlutfoll = T(2:end,end)./T(2:end,vendidalkur);
[ascHlutfoll,index]=sort(hlutfoll,'ascend');
vendilina = index(find(ascHlutfoll>0,1,'first'))+1; % þurfum að bæta við línunni fyrir z
end
