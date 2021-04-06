assignCostsv2;
gen_pairingsv2;

A = Pfinal;
[n,m]=size(A);
f=cost;
b=ones(n,1);

Aeq = ones(1,m);
beq = 1; % changed to 4 for the sensitivity analysis

%x=bintprog(f,[],[],A,b);
x=intlinprog(f,[1:m],A,b,Aeq,beq,0*f,0*f+1);


i=find(x>0);
optimal_solution= A(:,i);