gen_pairingsv2;

Pfinal; % all possible pairings of game and facility
[n,m]=size(Pfinal);
penalty = 30;
cost = [];

% splitting P into individual sets
a = num2cell(Pfinal,1);

for i = 1:m
    f1used = 0;
    f2used = 0;
    f3used = 0;
    f4used = 0;

    f1 = a{i}([1 5 9 13]);
    f2 = a{i}([2 6 10 14]);
    f3 = a{i}([3 7 11 15]);
    f4 = a{i}([4 8 12 16]);

    if (sum(f1) > 0)
        f1used = 1;
    end
    if (sum(f2) > 0)
        f2used = 1;
    end
    if (sum(f3) > 0)
        f3used = 1;
    end
    if (sum(f4) > 0)
        f4used = 1;
    end
    
    a{i};
    cost = [cost;(f1used + f2used + f3used + f4used) * penalty];
end

