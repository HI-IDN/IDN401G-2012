/* MINCOSTFLOW, Maximum Flow Problem */

param n, integer, >= 2;
/* number of nodes */

set V, default {1..n};
/* set of nodes */

set E, within V cross V;
/* set of arcs */

param a{(i,j) in E}, > 0;
/* a[i,j] is capacity of arc (i,j) */

param s, symbolic, in V, default 1;
/* source node */

param t, symbolic, in V, != s, default n;
/* sink node */

param c{(i,j) in E}, >= 0;
/* c[i,j] is the cost through arc (i,j) */

param b{i in V};
/* net flow in node i */

var x{(i,j) in E}, >= 0, <= a[i,j];
/* x[i,j] is elementary flow through arc (i,j) to be found */

s.t. node{i in V}:
/* node[i] is conservation constraint for node i */
   sum{(i,j) in E} x[i,j] -sum{(j,i) in E} x[j,i] = b[i] ;
   
minimize obj: sum{(i,j) in E} c[i,j] * x[i,j];
/* objective is to maximize the total flow through the network */

solve;

printf{1..56} "="; printf "\n";
printf "Total cost %f\n\n", sum{(i,j) in E} c[i,j] * x[i,j];
printf "Starting node   Ending node   Arc capacity   Flow in arc\n";
printf "-------------   -----------   ------------   -----------\n";
printf{(i,j) in E: x[i,j] != 0}: "%13s   %11s   %12g   %11g\n", i, j,
   a[i,j], x[i,j];
printf{1..56} "="; printf "\n";

data;

/* Seervada Park (mynd 9.6 bls. 389 H&L). */

param n := 5;

/* see figure 9.12, using 1E9 for +Inf */
param :  E :  a  c :=
       1 2     10 2    /* AB */
       1 4    1E9 9    /* AD */
       1 3    1E9 4    /* AC */
       2 3    1E9 3    /* BC */
       3 5     80 1    /* CE */
       5 4    1E9 2    /* ED */
       4 5    1E9 3;   /* DE */


param : V:   b :=
        1   50
        2   40
        3    0
        4  -30
        5  -60;

end;
