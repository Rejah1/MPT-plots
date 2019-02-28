%%%%%%%% Import/Generate Data %%%%%%%%
clear;
trueCov(1:50,1:50) = 0.5; % Covariance matrix is just 50*50 identity matrix
v = ones(1,50);
trueCov = trueCov - diag(diag(trueCov)) + diag(v);
means = zeros(1,50); 
Data = mvnrnd(means,trueCov,1265); % Generating random data from multivariate normal with means 0 and 
Data = Data';

%%%%%%%% Calulating estimated Cov %%%%%%%%

avgData = Data - repmat(mean(Data), size(Data,1), 1); % xtilda (subtracting avg of each row from all elemtns in row)
estimatedCov = (avgData*avgData')/1265; % calculating the covariance based on the random data
avgReturns = mean(Data')'; % average return of each asset 

%%%%%%%% Set up for optomozation %%%%%%%%

expectedReturn = 0.04; % we want this return from our portfolio
eta = 0.1;
func = @(w) w'*estimatedCov*w + sum(abs(w))*eta;
w0 = randfixedsum(50,1,1,0,1);
A = []; % A*w <= b
b = [];
Aeq = [ones(1,50); avgReturns'];
beq = [1; expectedReturn]; %A*w = b
lb = zeros(1,50);
ub = [];

% Optimise

[weights, risk] = fmincon(func,w0,A,b,Aeq,beq,lb,ub);

% Plot grapgh

figure
plot(sort(log10(weights)), '-x')
title('Distribution of asset weights')
xlabel('Assets')
ylabel('Log (w)')

% Deviation from true risk

deviation = (weights'*trueCov*weights- weights'*estimatedCov*weights)/(weights'*trueCov*weights)