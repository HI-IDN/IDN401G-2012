set days;

param demand{j in days};
var x{days} >= 0;

maximize Z: sum{j in days} x[j];

s.t. shift{j in days} : x[j]  >= demand[j];


solve;


data;

set days := mon tue wed thu fri sat sun;

param demand :=
	mon 14
	tue 13
	wed 15
	thu 16
	fri 19
	sat 18
	sun 11;

end;


