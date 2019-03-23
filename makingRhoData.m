for ii = 1:20
    trueCov(1:50,1:50) = ii/20; % Covariance matrix is just 50*50 identity matrix
    v = ones(1,50);
    trueCov = trueCov - diag(diag(trueCov)) + diag(v);
    means = zeros(1,50); 
    Data = mvnrnd(means,trueCov,1265); % Generating random data from multivariate normal with means 0 and 
    Data = Data';
    allData = [allData;Data];
end