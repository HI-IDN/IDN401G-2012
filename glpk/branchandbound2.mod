set J := 1..4; # fjoldai akv.br.
set I := 1..4; # fjoldi skorda

var x{J},  >=0; # LP relaxation

param c{J};
param A{I,J}, default 0;
param b{I};

s.t. U0{i in I}: sum{j in J} A[i,j]*x[j] <= b[i];

# ---- BRANCH AND BOUND *START* ----
s.t. U1: x[1]<=1;
# s.t. U2: x[1]>=2;

s.t. U3: x[2]<=1;
#s.t. U4: x[2]>=2;

#s.t. U5: x[1]<=0;
s.t. U6: x[1]>=1;

# ---- BRANCH AND BOUND *FINISH* ----

# Hamarka framlegd
maximize z: sum{j in J} c[j]*x[j];

solve;

# Prenta ut akv.breytur
display x;
# Prenta ut besta markfallsgildi
display (sum{j in J} c[j]*x[j]);

data;
param c :=  
 1	4
 2	-2
 3	7
 4	-1;
param A :   1  2  3  4 :=  
	1   1  .  5  .
	2   1  1 -1  .
	3   6 -5  .  .
        4  -1  .  2 -2;
param b :=
	1	10
	2	1
	3	0
	4	3;

end;
