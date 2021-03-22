clc
clear all

%generate all possibilities for
N= 24;
A = dec2bin(0:(2.^N)-1)-'0';
A=A';

t1_sessions = [1;0;0;0;1;0;0;1;1;0;0;0;1;0;0;1;1;0;0;0;1;0;0;1];
t1_feasibles = removeInfeasibleCols(t1_sessions, A);

t2_sessions = [0;1;0;0;1;0;0;1;0;1;0;0;0;1;1;0;0;1;0;0;0;1;1;0];
t2_feasibles = removeInfeasibleCols(t2_sessions, A);

t3_sessions = [0;0;1;0;0;1;1;0;0;0;1;0;1;0;0;1;0;0;1;0;0;1;1;0];
t3_feasibles = removeInfeasibleCols(t3_sessions, A);

t4_sessions = [0;0;0;1;0;1;1;0;0;0;0;1;0;1;1;0;0;0;0;1;1;0;1;0];
t4_feasibles = removeInfeasibleCols(t4_sessions, A);

%ALL_PAIRINGS TO BE INPUT FOR COST ASSIGNMENT
all_pairings = [t1_feasibles, t2_feasibles, t3_feasibles, t4_feasibles];

function trim = removeInfeasibleCols(sessions, X)
%since we know each team can max 6 sessions (3 practice 3 games)
%keep only those that have less than 6 1s
j=find((sum(X))<=6);
X=X(:,j);

[x,y]=size(sessions);
[n,m]=size(X);
    % if teamX does not have a session i scheduled, Aij cannot be 1
% set those columns to null
for i =1:x %iterate down t1_sessions
    for j = 1:m %iterate across A
    if sessions(i,1)==0 && X(i,j) == 1
      X(:,j) = nan(1,24);     
    end
    end
    
end

% delete all nan columns
trim = X(:,all(~isnan(X)));
end

%pause
%[n,m]=size(A);
%f=ones(m,1);
%b=ones(n,1);

%x=bintprog(f,[],[],A,b);
%x=intlinprog(f,[1:m],[],[],A,b,0*f,0*f+1);

%i=find(x==1);
%optimal_solution= A(:,i)