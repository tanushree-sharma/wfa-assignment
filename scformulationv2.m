assignCostsv2;
gen_pairingsv2;

A = Pfinal;

[n,m]=size(A);
f=cost;
b=ones(n,1);

%x=bintprog(f,[],[],A,b);
x=intlinprog(f,[1:m],[],[],A,b,0*f,0*f+1);


i=find(x==1);
optimal_solution= A(:,i)