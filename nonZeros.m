clear;
weights = zeros(50,20);
nz = zeros(20,20);
nonZero = ones(1,10);

for jj = 1:20 
    for ii = 1:20
        [weights(:,ii), ~] = RhoMPTFunc(jj/20);
        nz(jj,ii) = sum(weights(:,ii)>0.001);
    end
    nonZero(jj) = mean(nz(jj,:),2);
    %nonZero(ii) = sum(ws>0.001);
end

x = [1:20]./20;
figure
plot(x,nonZero)
title('Non Zero Weights')
xlabel('Rho')
ylabel('Number of non-zero Weights')
