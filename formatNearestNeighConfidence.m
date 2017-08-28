for expnum = 1:9
    if expnum == 4 %because there are NaN's in exp 4 data that screw things up
        exp_naive = zeros(100, 1);
        exp_model = zeros(100, 1);
    else
        exp_naive = load(strcat('expNearNeighborNaiveExp', num2str(expnum), '.csv'));
        exp_model = load(strcat('expNearNeighborModelExp', num2str(expnum), '.csv'));
    end
    %---and now use that data to put into the combined file for t-test---

    data = zeros(100, 2);
    data(1:100, 1) = transpose(exp_naive);
    data(1:100, 2) = transpose(exp_model);

    csvwrite(strcat('nearNeighbor', 'Exp', num2str(expnum), 'forConfidence', '.csv'), data);

end