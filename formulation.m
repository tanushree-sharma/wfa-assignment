gen_pairings;
assignCosts;

clear A;
A = all_pairings;

[n,m]=size(A);
f=cost_matrix;
b=ones(n,1);

x=intlinprog(f,[1:m],A,b, [], [],0*f,0*f+1);

i=find(x==1);
optimal_solution= A(:,i)