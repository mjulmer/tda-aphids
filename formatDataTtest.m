for expnum = 2:9
    dataNaive = importdata(strcat('ExperimentalAndNon100h0exp', num2str(expnum), 'differences.csv'));
    dataModel = importdata(strcat('ModelAndExperimental100h0exp', num2str(expnum), 'differences.csv'));
    
    data = zeros(200, 2);
    data(2:101, 1) = transpose(dataNaive);
    data(2:101, 2) = 1;
    data(102:201, 1) = transpose(dataModel);
    data(102:201, 2) = 2;
    
    csvwrite(strcat('exp', num2str(expnum), 'forTtest', '.csv'), data);
end