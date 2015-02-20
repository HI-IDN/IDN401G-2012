function [a,b] = tighten(a,b)
% usage example: [a,b] = tighten([2 3], 4)

while 1, % infinite loop
% Calculate S = sum of the positive a(j)
  S = sum(a(find(a>0)));
% identify a(j) ~= 0 such that S < b + abs(a(j))
  I = find(a~=0 & S < b + abs(a));
% bail out of while loop if you can!
  if isempty(I), break; end 
% lets just look at the first one
  j = I(1);
% condition a(j) > 0 and (a(j) < 0)
  if (a(j) > 0)
    ahat = S - b;
    b = S - a(j);
    a(j) = ahat;
  else
    a(j) = b - S;
  end
end
