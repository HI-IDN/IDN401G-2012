function [path, fmin] = shortestpath(C, s, d),
% Dijkstra's ``shortest-path'' reiknirit
% notkun : [path, fmin] = shortestpath(cost, s, d)

% fjoldi punkta
n = length(C);
% allir punktar eru oleystir
visited = zeros(1,n);
% fjarlaegd i alla punkta er inf
distance = inf*ones(1,n);
% foreldri (parent node)
parent = zeros(1,n);
% fjarlaegd fra upphafspunkti er 0
distance(s) = 0; 
% athugum alla punkta (i raun bara tha sem eru tengdir)
for i = 1:(n-1),
  tempdist = []; % halda utan um fjarlaegd
  for h = 1:n,
    if (visited(h) == 0) % oleystur punktur
      tempdist = [tempdist distance(h)];
    else
      tempdist = [tempdist inf]; % leystur punktur (sleppa)
    end
  end
  [dummy, u] = min(tempdist);  % oleystur punktur med minnstu fjarlaegd
  visited(u) = 1;              % nuna er sa punktur leystur
  for v = 1:n,                 % fyrir alla nagranna vid u
  % "triange inequality "gildir adeins fyrir stystu leid:
    if ( (C(u, v) + distance(u)) < distance(v) ),
      distance(v) = distance(u) + C(u, v); % uppfaera stystu fjarlaegd
      parent(v) = u; % betri punktur fundinn!
    end
  end
end

% stysta leid finnst med thvi ad vinna afturabak
i = d; path = d;
while (parent(i) ~= parent(s))
  path = [parent(i) path];
  i = parent(i);
end
% minnsta fjarlaegd er i distance(d)
fmin = distance(d);
