numTrials = 100; %number of runs for each experiment, to compare

%vector which stores the pairwise differences between the expermental plot
%and each simulated plot
diffExpModel = zeros(1, numTrials); %experimental and model
diffExpNaive = zeros(1, numTrials); % experimental and non-interactive
dimension = 0; %h dimension of plots you want

for expnum = 1:1
   
    expData = load(strcat('experimental', 'h', num2str(dimension), 'exp', num2str(expnum), '.csv'));
    dimensions = size(expData);
    numElements = dimensions(1)*dimensions(2); %for normalization
    
    for runnum = 1:numTrials
        modelData = load(strcat('modelFullh0exp', num2str(expnum), 'run', num2str(runnum), '.csv')); %funny naming scheme for the first few
        %modelData = load(strcat('model100', 'h', num2str(dimension), 'exp', num2str(expnum), 'run', num2str(runnum), '.csv'));
        naiveData = load(strcat('noInteraction100', 'h', num2str(dimension), 'exp', num2str(expnum), 'run', num2str(runnum), '.csv'));
        
        %take the frobenius norm of the distance between the matrices
        diffExpModel(1, runnum) = norm(expData - modelData, 'fro');
        diffExpNaive(1, runnum) = norm(expData - naiveData, 'fro');
        
        runnum
    end
    
    %normalize by number of entries in the matrix
    %diffExpModel = diffExpModel ./ numElements;
    %diffExpNaive = diffExpNaive ./ numElements;
    
    csvwrite(strcat('noNormModelAndExpFrobeniusNoNorm', 'h', num2str(dimension), 'exp', num2str(expnum), '.csv'), diffExpModel)
    csvwrite(strcat('noNormExpAndNonFrobeniusNoNorm', 'h', num2str(dimension), 'exp', num2str(expnum), '.csv'), diffExpNaive)
    
    expnum
end
