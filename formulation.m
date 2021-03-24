gen_pairings;
assignCosts;

clear A;
A = all_pairings;

[n,m]=size(A);
c=cost_matrix;
f=ones(m,1);
b=ones(n,1);

ineq = ones(1,m);
ineq_rhs = ones(1,1)

% objective function coefficients,intcon, linear inequality constraint
% linear inequality RHS, linear equality constraint, linear inequality RHS
% lb, ub
x=intlinprog(c,[1:m],[],[],A,b,0*f,0*f+1);
% no feasible solution: x=intlinprog(c,[1:m],ineq,ineq_rhs,A,b,0*f,0*f+1);


i=find(x==1);
optimal_solution= A(:,i)