gen_pairings;
assignCosts;

clear A;
Aeq = all_pairings;
[n,m]=size(Aeq);
beq = ones(n,1);
f=cost_matrix;
% A = ones(6,m);
% b = ones(6,1);

lb = zeros(m,1);
ub = ones(m,1);

x = intlinprog(f,[1:m],[],[],Aeq,beq,lb,ub);





% objective function coefficients,intcon, linear inequality constraint
% linear inequality RHS, linear equality constraint, linear inequality RHS
% lb, ub
% x=intlinprog(c,[1:m],[],[],A,b,0*f,0*f+1);
% no feasible solution: x=intlinprog(c,[1:m],ineq,ineq_rhs,A,b,0*f,0*f+1);

% 
i=find(x==1);
optimal_solution= Aeq(:,i)