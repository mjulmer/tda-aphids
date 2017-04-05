types = {'ang', 'abs', 'polar'};
for expnum = 1:9
    %dataNaive = importdata(strcat('ExperimentalAndNon100h0exp', num2str(expnum), 'differences.csv'));
    %dataModel = importdata(strcat('ModelAndExperimental100h0exp', num2str(expnum), 'differences.csv'));
    for i = 1:3
        file1 = (strcat(types{i}, 'PlotNaiveExp', num2str(expnum), '.csv'))
        file2 = strcat(types{i}, 'PlotModelExp', num2str(expnum), '.csv')
        dataNaive = load(file1);
        dataModel = load(file2);

        data = zeros(200, 2);
        data(2:101, 1) = transpose(dataNaive);
        data(2:101, 2) = 1;
        data(102:201, 1) = transpose(dataModel);
        data(102:201, 2) = 2;

        csvwrite(strcat(types{i}, 'Exp', num2str(expnum), 'forTtest', '.csv'), data);
        %csvwrite(strcat('exp', num2str(expnum), 'forTtest', '.csv'), data);
    end
end