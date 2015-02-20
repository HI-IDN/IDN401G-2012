set I := 1..2; # LA eda SF

var xl{I}, >=0, <=1; # LP relaxation
var xv{I}, >=0, <=1; # LP relaxation

# Nuvirtur hagnadur
param c_l{I};
param c_v{I};

# Fjarmagnsthorf
param A_l{I};
param A_v{I};

# Mesta lagi einn lager byggdur
s.t. max1lager: sum{i in I} xl[i] <= 1;

# Einungis lager thar sem er verksmidja
s.t. lager_ef_verksm{i in I}: xl[i] <= xv[i];

# Fjarmagn til umrada
s.t. pen: sum{i in I} A_v[i]*xv[i] + sum{i in I}A_l[i]*xl[i]  <= 10;

# ---- BRANCH AND BOUND *START* ----
# Kommenta fyrst allt i B-N-B blokkinni, og vinnid ykkur nidur

# s.t. Undirv1: xv[1]=0; 
# LP =>  x=(0,1,0,1) z=9 ==> heiltolur, setjum z*=9, EYDA!

s.t. Undirv2: xv[1]=1; # Kommenta ut 1
# LP => x=(1,.8,1,.8) z=16.2 ==> Getum ekki eytt

	# s.t. Undirv2_1: xv[2]=0; 
	# LP => x=(1,0,0.8,0) z=13.8 ==> Getum ekki eytt

	s.t. Undirv2_2: xv[2]=1; # Kommenta ut  2.1
	# LP => x=(1,1,0,.5) z=16 ==> Getum ekki eytt

	# Gatum hvorki hent 2.1 ne 2.2 --> byrjum med 2.2 (vaenlegra)

		s.t. Undirv2_2_1: xl[1]=0; 
		# LP => fengum x=(1,1,0,.5) z=16 ==> Getum ekki eytt

		# s.t. Undirv2_2_2: xl[1]=1; 
		# LP => PROBLEM HAS NO PRIMAL FEASIBLE SOLUTION ==> EYDA!

	# Gatum eytt 2.2.2 (kommenta ut), kvislum 2.2.1 (afkommenta)

			# s.t. Undirv2_2_1_1: xl[2]=0; 
			# LP => x=(1,1,0,0) z=14 ==> Heiltolulausn, setjum z*=14, EYDA!

			s.t. Undirv2_2_1_2: xl[2]=1; 
			# LP => PROBLEM HAS NO PRIMAL FEASIBLE SOLUTION ==> EYDA!

	# Getum nu snuid okkur aftur 2.1

	# Rifjum upp: efri mork 13 ==> Getum NUNA eytt (z*=14>13)

# BESTA LAUSN ER FUNDIN, x*=(1,1,0,0) z*=14

# ---- BRANCH AND BOUND *FINISH* ----

# Hamarka framlegd
maximize z: sum{i in I} c_v[i]*xv[i] + sum{i in I} c_l[i]*xl[i];

solve;

# Prenta ut akv.breytur og besta markfallsgildi
display xv, xl, (sum{i in I} c_v[i]*xv[i] + sum{i in I} c_l[i]*xl[i]);

data;
param c_v :=  
 1	9
 2	5;
param c_l :=   
 1	6
 2	4;
param A_v :=  
 1	6
 2	3;
param A_l :=   
 1	5
 2	2;
end;
