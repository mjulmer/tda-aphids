
for expnum = 1:9
    dataNaive = load(strcat('ModelAndExpFrobenius', 'h', num2str(dimension), 'exp', num2str(expnum), '.csv'));
    dataModel = load(strcat('ExpAndNonFrobenius', 'h', num2str(dimension), 'exp', num2str(expnum), '.csv'));
    
    data = zeros(200, 2);
    data(2:101, 1) = transpose(dataNaive);
    data(2:101, 2) = 1;
    data(102:201, 1) = transpose(dataModel);
    data(102:201, 2) = 2;
    
    csvwrite(strcat('frobeniusExp', num2str(expnum), 'forTtest', '.csv'), data);
end