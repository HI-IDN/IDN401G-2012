# wyndor.mod ---  Wyndor GLPK example
#    max Z=(c1)x1 + 5x2
#    s.t.  x1       <= 4
#                x2 <= 12
#         3x1 + 2x2 <= 18
#          x1 >=0, x2 >=0
# where c1 is to be varied

param c1 := 3; # Modify this value!

set product;
set factory;

param profit{j in product};
param resource{i in factory};
param A{i in factory, j in product};

var x{product} >= 0;

maximize Z: sum{j in product: j != "window"} profit[j]*x[j] + c1*x["window"];

subject to hours{i in factory} : sum{j in product} x[j] * A[i,j] <= resource[i];

solve;

# write results to file WYNDOR_RESULTS.TXT
printf : "c1=%.3f ", c1 >> "wyndor_results.txt";
printf{j in product} : "x[%s]=%.3f, ", j, x[j] >> "wyndor_results.txt"; # append to file
printf : "Z=%.3f\n", sum{j in product} profit[j]*x[j] >> "wyndor_results.txt"; # append to file
