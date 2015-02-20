set product;
set steps;

param profit{j in product};
param resource{i in steps};
param A{i in steps, j in product};

var x{product} >= 0;

maximize Z: sum{j in product} profit[j]*x[j];

subject to
   hours{i in steps} : sum{j in product} x[j] * A[i,j] <= resource[i];

solve;

data;

set product := Santa Viking Puffin;
set steps := 1 2 3;

param profit :=
	Santa	6
	Viking	4
	Puffin	10;

param resource := 
   1	430
   2	460
   3	420;

param A: 	Santa Viking Puffin :=
 	1	1	2	1
	2	3	0	2
	3	1	4	0;

end;


