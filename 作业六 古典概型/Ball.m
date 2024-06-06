%% Ball.m 三人摸球实验
function [Awin, Bwin, Cwin, pA, pB, pC] = Ball(white, black, n)
    Awin = 0;
    Bwin = 0;
    Cwin = 0;

    for i = 1:n
        m = 1:white;                    % 白球：1~W
        m = [m, white+1:white+black];   % 黑球：W+1~W+B
        number = white + black;

        while number > 0
            a_cnt = randi([1, length(m)], 1, 1);  % 随机摸球
            if m(a_cnt) <= white     
                Awin = Awin + 1;
                break
            else
                m(a_cnt) = [];
            end

            b_cnt = randi([1, length(m)], 1, 1);
            if m(b_cnt) <= white
                Bwin = Bwin + 1;
                break
            else
                m(b_cnt) = [];
            end

            c_cnt = randi([1, length(m)], 1, 1);
            if m(c_cnt) <= white 
                Cwin = Cwin + 1;
                break
            else
                m(c_cnt) = [];
            end 
        end
    end

    pA = Awin / n;
    pB = Bwin / n;
    pC = Cwin / n;
end