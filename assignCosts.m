% getting the A matrix of potential pairings to assign costs (currently
% just team 1 feasible pairings
A = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
     1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
     0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
     1 1 1 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
     1 1 1 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
     0 0 0 0 0 0 1 1 1 1 0 0 0 0 0 0 0 0 1 1 1 1 1 1;
     0 0 0 1 1 1 0 0 0 1 0 0 0 0 1 1 1 1 0 0 0 0 1 1;
     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
     0 1 1 0 0 1 0 0 1 0 0 0 1 1 0 0 1 1 0 0 1 1 0 0;
     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
     1 0 1 0 1 0 0 1 0 0 0 1 0 1 0 1 0 1 0 1 0 1 0 0];
     
% splitting into individual A matrices for each team
numCols = width(A)/4; %change to width(pairs)/4
A = mat2cell(A, [24], [numCols numCols numCols numCols]);

% splitting each teams A matrix into individual vectors
t1Pairs = num2cell(A{1},1);
t2Pairs = num2cell(A{2},1);
t3Pairs = num2cell(A{3},1);
t4Pairs = num2cell(A{4},1);

t1Cost = [];
t2Cost = [];
t3Cost = [];
t4Cost = [];

for i = 1:numCols
    % splitting into individual vectors for each team based on table 2
    t1move = t1Pairs{i}([1 5 8 9 13 16 17 21 24]);
    t2move = t2Pairs{i}([2 5 8 10 14 15 18 22 23]);
    t3move = t3Pairs{i}([3 6 7 11 13 16 19 22 23]);
    t4move = t4Pairs{i}([4 6 7 12 14 15 20 21 24]);

    t1moveCost = movingCosts(t1move);
    t2moveCost = movingCosts(t2move);
    t3moveCost = movingCosts(t3move);
    t4moveCost = movingCosts(t4move);

    % splitting into individual vectors for each team based on games in table 2
    t1game = t1Pairs{i}([5 13 21]);
    t2game = t2Pairs{i}([5 15 23]);
    t3game = t3Pairs{i}([7 13 23]);
    t4game = t4Pairs{i}([7 15 21]);

    t1gameCost = broadcastCosts(t1game);
    t2gameCost = broadcastCosts(t2game);
    t3gameCost = broadcastCosts(t3game);
    t4gameCost = broadcastCosts(t4game);

    t1Cost = [t1Cost; t1moveCost + t1gameCost];
    t2Cost = [t2Cost; t2moveCost + t2gameCost];
    t3Cost = [t3Cost; t3moveCost + t3gameCost];
    t4Cost = [t4Cost; t4moveCost + t4gameCost];
end
    
function y = movingCosts(x)
    % penalty cost of moving to a different facility
    movingPen = 20;

    % tallying the number of time the team has moved
    moves = 9-sum(x);
   
    y = moves*movingPen;
end

function y = broadcastCosts(x)
    % assigning penalty costs of having a game during a noptimal time slot
    broadcastPen = 10;
    
    % tallying the number of times the team plays during a noptimal time
    tally = sum(x);
    
    y = tally * broadcastPen;
end
