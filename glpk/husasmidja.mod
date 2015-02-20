/* Husasmidjudaemi */

# =========== Módellýsing ==============
param n; # fjöldi lengda sem eru til 
param m; # fjöldi mögulegra samsetninga skurða

set lengdir := {1..n}; 
set skurdir := {1..m};

param samsetning{i in lengdir, j in skurdir}; # fjöldi spýta að lengd i gerð með skurði j
param eftirspurn{i in lengdir}; # eftirspurn eftir fjöldi spýta að lengd i

var x{i in skurdir}, integer >= 0; # ákvarða skal fjölda af skurðum

minimize Z: sum{i in skurdir} x[i];

subject to sogun{i in lengdir} : sum{j in skurdir} samsetning[i,j]*x[j] >= eftirspurn[i];

solve;
# =========== Data skrá ==============
data;

param n := 4;
param m := 6;

param samsetning:   1 2 3 4 5 6 :=
                  1 0 0 1 0 1 3
                  2 0 1 0 2 1 0
                  3 0 1 1 0 0 0
                  4 1 0 0 0 0 0;

param eftirspurn :=
        1 104
        2 12
        3 63
        4 86;
end;

