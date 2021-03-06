scformulationv2;

% convert results from scformulationv2
% translate optimal solution to game facility numbers
g = [];

[n,m]=size(optimal_solution); 

for i=1:n
    if optimal_solution(i,1) == 1
        if mod(i, 4) == 1
            game_facility = 1;
            g = [g, game_facility];
        elseif  mod(i, 4) == 2
            game_facility = 2;
            g = [g, game_facility];
        elseif mod(i, 4) == 3
            game_facility = 3;
            g = [g, game_facility];
        else
            game_facility = 4; 
            g = [g, game_facility];
        end
        
    end
end

g = g.';

% set home facilities to game facilities
home_fx = g(1,1);
home_fy= g(2,1);

% ensures that rand1 and rand2 are not the same
while home_fx == home_fy
    home_fy = randi([1 4]);
    
end

% randomly assign each team a home facility
fx_a = randi([1 4]);
fx_b = randi([1 4]);

% ensures that fx_a and fx_b are not the same
while fx_a == fx_b
    fx_b = randi([1 4]);
    
end

fx = [fx_a fx_b];

% assign remaining teams to fy
fy = [];
if ismember(1, fx) == 0
    fy = [fy, 1];
end
if ismember(2, fx) == 0
    fy = [fy, 2];
end
if ismember(3, fx) == 0
    fy = [fy, 3];
end
if ismember(4, fx) == 0
    fy = [fy, 4];
end

% home facility - team allocation matrix
h = [home_fx fx; home_fy fy]

% distance - cost matrix
c = [0 40 33 5; 40 0 16 27; 33 16 0 26; 5 27 26 0]


f = [assign_costs2(1, 2, 1, g, h, c); assign_costs2(1, 2, 2, g, h,c); assign_costs2(1, 2, 3, g, h,c); assign_costs2(1, 2, 4, g, h,c); assign_costs2(1, 2, 5, g, h,c); assign_costs2(1, 2, 6, g, h,c);
    assign_costs2(1, 3, 1, g, h, c); assign_costs2(1, 3, 2, g, h,c); assign_costs2(1, 3, 3, g, h,c); assign_costs2(1, 3, 4, g, h,c); assign_costs2(1, 3, 5, g, h,c); assign_costs2(1, 3, 6, g, h,c);
    assign_costs2(1, 4, 1, g, h, c); assign_costs2(1, 4, 2, g, h,c); assign_costs2(1, 4, 3, g, h, c); assign_costs2(1, 4, 4, g, h,c); assign_costs2(1, 4, 5, g, h,c); assign_costs2(1, 4, 6, g, h,c);
    assign_costs2(2, 3, 1, g, h,c); assign_costs2(2, 3, 2, g, h,c); assign_costs2(2, 3, 3, g, h,c); assign_costs2(2, 3, 4, g, h,c); assign_costs2(2, 3, 5, g, h,c); assign_costs2(2, 3, 6, g, h,c);
    assign_costs2(2, 4, 1, g, h,c); assign_costs2(2, 4, 2, g, h,c); assign_costs2(2, 4, 3, g, h,c); assign_costs2(2, 4, 4, g, h,c); assign_costs2(2, 4, 5, g, h,c); assign_costs2(2, 4, 6, g, h,c);
    assign_costs2(3, 4, 1, g, h,c); assign_costs2(3, 4, 2, g, h,c); assign_costs2(3, 4, 3, g, h,c); assign_costs2(3, 4, 4, g, h,c); assign_costs2(3, 4, 5, g, h,c); assign_costs2(3, 4, 6, g, h,c)]

A=zeros(12,36);
A(1:6,1:36)=[eye(6),eye(6),eye(6),eye(6),eye(6),eye(6)]

for k=1:6
A(6+k,1+6*(k-1):6*k)=[1,1,1,1,1,1]
end

[n,m]=size(A);
b = ones(n,1);

lb = zeros(m,1);
ub = ones(m,1);

final_sol = intlinprog(f,[1:m],[],[],A,b,lb,ub);

function cost2 = assign_costs2(t1, t2, game_num, g, h,c)
    h_teams=h;
    h_teams(:, 1) = [];
    % find the home facility for each team
    [row1, column1] = find(h_teams == t1);
    t1_home = h(row1, 1);
    [row2, column2] = find(h_teams == t2);
    t2_home = h(row2, 1);
    % find the facility for the game_num specified
    game_facility = g(game_num, 1);

    % teams do not have to move if game is played at home fields
    if isequal(t1_home, t2_home, game_facility) == 1
        cost2 = 0;
    % if one team has to move
    elseif (isequal(t1_home,game_facility) == 1) | (isequal(t2_home,game_facility) == 1)
        if isequal(t1_home,game_facility) == 1 % t2 moves to game facility
            cost2 = c(t2_home, game_facility);
        else
            cost2 = c(t1_home, game_facility);
        end
    % if both teams have to move
    else 
        cost2 = c(t2_home, game_facility) + c(t1_home, game_facility);
    end 
end
