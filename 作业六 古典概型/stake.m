%% stake.m
function [Awin, Bwin, pA, pB, p_rats, p] = stake(n)
    Awin = 0;
    Bwin = 0;
    rng('shuffle');
    for i = 1:n
        sum = randi([1, 6]) + randi([1, 6]);  % 点数和
        if sum == 7
            Awin = Awin + 1;
        elseif sum == 10
            Bwin = Bwin + 1;
        else 
            % 平分赌注
            Awin = Awin + 0.5;
            Bwin = Bwin + 0.5;
        end
    end
    tot = Awin + Bwin;
    pA = Awin / tot;
    pB = Bwin / tot;
    p_rats = rats(Awin / Bwin); % 有理输出
    p = Awin / Bwin;
end