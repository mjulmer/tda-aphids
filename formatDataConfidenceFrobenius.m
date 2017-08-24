
for expnum = 1:9
    dataModel = load(strcat('ModelAndExpFrobenius', 'h0exp', num2str(expnum), '.csv'));
    dataNaive = load(strcat('ExpAndNonFrobenius', 'h0exp', num2str(expnum), '.csv'));
    
    data = zeros(100, 2);
    data(1:100, 1) = transpose(dataNaive);
    data(1:100, 2) = transpose(dataModel);
    
    csvwrite(strcat('frobeniusExp', num2str(expnum), 'forConfidence', '.csv'), data);
end