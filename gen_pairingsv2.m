% feasible sets for each game
g1 = eye(4);
g2 = eye(4);
g3 = eye(4);
g4 = eye(4);
g5 = eye(4);
g6 = eye(4);

P = [];
temp = [];
% combining feasible sets for each game into feasible sets for all games
% P = [g1@f1;g1@f2;...;g6@f4;g2@f1;g2@f2;...;g2@f4;...;g6@f1;g6@f2;...;g6@f4]

for o = 1:4
    f1 = g1(:,o);
    for t = 1:4
        f2 = [f1; g2(:,t)];
        for th = 1:4
            f3 = [f2; g3(:,th)];
            for f = 1:4
                f4 = [f3; g4(:,f)];
                for fi = 1:4
                    f5 = [f4;g5(:,fi)];
                    for s = 1:4
                        f6 = [f5;g6(:,s)];
                        P = [P,f6];
                    end
                end
            end
        end
    end
end

% get rid of the pairings where there's back to back games in the same
% facilty
[n,m]=size(P);

for i = 1:m
    group1 = P([1:8],i);
    group2 = P([9:16],i);
    group3 = P([17:24],i);

    % if facility 1 is used for both games || fac 2  || f3 || f4, get rid of it
    if ((group1([1]) == 1 && group1([5]) == 1) || (group1([2]) == 1 && group1([6]) == 1) || (group1([3]) == 1 && group1([7]) == 1) || (group1([4]) == 1 && group1([8]) == 1))
        P(:,i) = NaN;
    end
    if ((group2([1]) == 1 && group2([5]) == 1) || (group2([2]) == 1 && group2([6]) == 1) || (group2([3]) == 1 && group2([7]) == 1) || (group2([4]) == 1 && group2([8]) == 1))
        P(:,i) = NaN;
    end
    if ((group3([1]) == 1 && group3([5]) == 1) || (group3([2]) == 1 && group3([6]) == 1) || (group3([3]) == 1 && group3([7]) == 1) || (group3([4]) == 1 && group3([8]) == 1))
        P(:,i) = NaN;
    end
end

% delete all nan columns
Pfinal = P(:,all(~isnan(P)));










