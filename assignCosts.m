% getting the matrix of potential pairings to assign costs
pairings = [1 1;1 0;1 1;1 1;1 1;0 0;1 1;0 0;1 0;1 0;0 1;0 1;1 1;1 0;1 1;1 1;0 0;1 1;0 0;1 1;0 1;0 1;1 0;1 0;1 1;1 1;1 1;1 1;1 1;1 1;0 0;0 0;1 1;1 1;0 0;0 0];

% splitting into individual vectors
pairs = num2cell(pairings,1);

for i = 1:2
    % splitting into individual vectors for each team based on table 2
    t1move = pairs{i}([1 5 9 12 13 17 21 24 25 29 33 36]);
    t2move = pairs{i}([2 6 9 12 14 18 22 23 26 30 34 35]);
    t3move = pairs{i}([3 7 10 11 15 19 21 24 27 31 34 35]);
    t4move = pairs{i}([4 8 10 11 16 20 22 23 28 32 33 36]);

    t1moveCost = movingCosts(t1move);
    t2moveCost = movingCosts(t2move);
    t3moveCost = movingCosts(t3move);
    t4moveCost = movingCosts(t4move);

    % splitting into individual vectors for each team based on games in table 2
    t1game = pairs{i}([9 21 33]);
    t2game = pairs{i}([9 22 34]);
    t3game = pairs{i}([10 21 34]);
    t4game = pairs{i}([10 22 33]);

    t1gameCost = broadcastCosts(t1game);
    t2gameCost = broadcastCosts(t2game);
    t3gameCost = broadcastCosts(t3game);
    t4gameCost = broadcastCosts(t4game);

    pairCost = t1moveCost + t1gameCost + t2moveCost + t2gameCost + t3moveCost + t3gameCost + t4moveCost + t4gameCost
end
    
function y = movingCosts(x)
    % penalty cost of moving to a different facility
    movingPen = 20;

    % tallying the number of time the team has moved
    moves = 12-sum(x);
   
    y = moves*movingPen;
end

function y = broadcastCosts(x)
    % assigning penalty costs of having a game during a noptimal time slot
    broadcastPen = 10;
    
    % tallying the number of times the team plays during a noptimal time
    tally = sum(x);
    
    y = tally * broadcastPen;
end
