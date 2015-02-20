/* Shortest Path Problem */

/* Given a directed graph G = (V,E), its edge lengths c(i,j) for all (i,j) in E, and two nodes s, t in V, the Shortest Path Problem (SPP) is to find a directed path from s to t whose length is minimal. */

param n, integer, > 0;
/* number of nodes */

set E, within {i in 1..n, j in 1..n};
/* set of edges */

param c{(i,j) in E};
/* c[i,j] is length of edge (i,j); note that edge lengths are allowed to be of any sign (positive, negative, or zero) */

param s, in {1..n};
/* source node */

param t, in {1..n};
/* target node */

var x{(i,j) in E}, >= 0;
/* 
   x[i,j] = 1 means that edge (i,j) belong to shortest path;
   x[i,j] = 0 means that edge (i,j) does not belong to shortest path;
   note that variables x[i,j] are binary, however, there is no need to declare them so due to the totally unimodular constraint matrix 
   A unimodular matrix is a real square matrix with determinant plus/minus 1
*/

s.t. r{i in 1..n}: sum{(j,i) in E} x[j,i] + (if i = s then 1) =
                   sum{(i,j) in E} x[i,j] + (if i = t then 1);
/* conservation conditions for unity flow from s to t; every feasible solution is a path from s to t */

minimize Z: sum{(i,j) in E} c[i,j] * x[i,j];
/* objective function is the path length to be minimized */

solve;


/* Finally print optimal solution into the terminal */
printf{1..56} "="; printf "\n";
printf: "Optimal solution z*: %f\n", sum{(i,j) in E} c[i,j] * x[i,j];
printf "Edges in basis:\n";
printf{(i,j) in E: x[i,j] != 0}: "%d-%d\n", i, j;
printf{1..56} "="; printf "\n";

