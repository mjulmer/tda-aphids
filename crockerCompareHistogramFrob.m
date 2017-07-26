%the frob stands for frobenius.
dimension = 0;

% expModel = [];
% expNon = [];

for expnum = 1:9
    
    expModel = [];
    expNon = [];
    
    data1 = load(strcat('ModelAndExpFrobenius', 'h', num2str(dimension), 'exp', num2str(expnum), '.csv'));
    data2 = load(strcat('ExpAndNonFrobenius', 'h', num2str(dimension), 'exp', num2str(expnum), '.csv'));
    
    expModel = [expModel, data1(:)];
    expNon = [expNon, data2(:)];

    han = figure;
    % expModel = expModel.*1000;
    % expModel = floor(expModel);
    % expModel

    hist([expModel(:), expNon(:)]);
        axis([0, .0035, 0, 50]);
    % hold on
    % hist(expNon(:));
    
    saveas(han, strcat('frobHist100modelNonExp', num2str(expnum), '.png'));
    
end