# ======= Modellysing fyrir bjorliki =========
set afengi;

param kostn{afengi}; 
param vol{afengi};
param minhlutfall{afengi}, default 0;
param maxhlutfall{afengi}, default 1;

var x{i in afengi}, >= 0; 

s.t. hlutfall: sum{i in afengi} x[i] = 1;

s.t. lagmark{i in afengi}: x[i] >= minhlutfall[i];
s.t. hamark{i in afengi}: x[i] <= maxhlutfall[i];

s.t. sterkt: sum{i in afengi : vol[i] >= 0.4} x[i] <=0.10;
s.t. styrkur: sum{i in afengi} vol[i]*x[i] = 0.04;

minimize z: sum{i in afengi} kostn[i]*x[i];

solve;
display x;
