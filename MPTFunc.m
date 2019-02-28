function [w,d,f] = MPTFunc(t)

if (t~=round(t))||(t<1)
 error('t must be a whole number.')
end
    

%%%%%%%% Import/Generate Data %%%%%%%%
trueCov = eye(50); % Covariance matrix is just 50*50 identity matrix
means = zeros(t,50); 
Data = mvnrnd(means,trueCov); % Generating random data from multivariate normal with means 0 and 
Data = Data';


%%%%%%%% Calulating estimated Cov %%%%%%%%
%avgData = Data - repmat(mean(Data), size(Data,1), 1); % xtilda (subtracting avg of each row from all elemtns in row)
%estimatedCov = (avgData*avgData')/(t); % calculating the covariance based on the random data
estimatedCov = cov(Data');
avgReturns = mean(Data')'; % average return of each asset 
%%%%%%%% Set up for optomozation %%%%%%%%

expectedReturn = 0.0; % we want this return from our portfolio
eta = 0.01;
func = @(w) w'*estimatedCov*w + sum(abs(w))*eta ;
w0 = randfixedsum(50,1,1,0,1);
A = []; % A*w <= b
b = [];
Aeq = [ones(1,50); avgReturns'];
beq = [1; expectedReturn]; %A*w = b
lb = zeros(1,50);
ub = [];

options = struct('MaxFunctionEvaluations', 5000);
%options = optimoptions(@fmincon,'MaxFunctionEvaluations',5000);
[weights, ~] = fmincon(func,w0,A,b,Aeq,beq,[],ub,[], options);

% if (flag == 0)
%     w = NaN;
%     d = NaN;
% else 
    
w = weights';
%d = (weights'*trueCov*weights- weights'*estimatedCov*weights)/(weights'*trueCov*weights);
d = (weights'*trueCov*weights);
