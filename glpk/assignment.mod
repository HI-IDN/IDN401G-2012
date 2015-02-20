# Set definitions
set women;
set men;

# Parameter definitions
param happiness{women,men};

# Variable definitions
var x{women,men} >= 0;

# Objective function
maximize total_happiness:
sum{i in women,j in men} happiness[i,j]*x[i,j];

# Constraints
subject to women_constraint{i in women}:
sum{j in men} x[i,j] = 1;
subject to men_constraint{j in men}:
sum{i in women} x[i,j] = 1;

# Solve and display results
solve;
display x;
