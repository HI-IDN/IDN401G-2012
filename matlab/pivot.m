function T = pivot(T,i,j),
% usage: T = pivot(T,i,j);
  [m, n] = size(T);
  T(i,:) = T(i,:) / T(i,j);
  for k = 1:i-1, T(k,:) = T(k,:) - T(k,j) * T(i,:); end
  for k = i+1:m, T(k,:) = T(k,:) - T(k,j) * T(i,:); end