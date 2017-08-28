types = {'ang', 'abs', 'polar'};
for expnum = 1:9
    %dataNaive = importdata(strcat('ExperimentalAndNon100h0exp', num2str(expnum), 'differences.csv'));
    %dataModel = importdata(strcat('ModelAndExperimental100h0exp', num2str(expnum), 'differences.csv'));
    for i = 1:3
        if expnum == 4
            data = zeros(100, 2);
            csvwrite(strcat(types{i}, 'Exp', num2str(expnum), 'forConfidence', '.csv'), data);
        else
            file1 = (strcat(types{i}, 'PlotNaiveExp', num2str(expnum), '.csv'))
            file2 = strcat(types{i}, 'PlotModelExp', num2str(expnum), '.csv')
            dataNaive = load(file1);
            dataModel = load(file2);
            
            data = zeros(100, 2);
            data(1:100, 1) = transpose(dataNaive);
            data(1:100, 2) = transpose(dataModel);
            
            csvwrite(strcat(types{i}, 'Exp', num2str(expnum), 'forConfidence', '.csv'), data);
            %csvwrite(strcat('exp', num2str(expnum), 'forTtest', '.csv'), data);
        end
    end
end