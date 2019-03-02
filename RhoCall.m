%This will output a graph of deviations thats it

clear;
weights(1:50,1:20) = 0; % this does not work yet i will work on it 
deviations = [1:20]; % initialises a 1*99 vecotr
%ns = linspace(25,1000,40); % makes vector of all values of T i will test
rp = linspace(0,1,21);

for ii = 1:20
    [weights(:,ii), deviations(ii)] = RhoMPTFunc(rp(ii)); % calls function for each value of t
end

ws = sort(log10(weights));
r = [1:50];
k = [1:50];
figure
for jj = 1:20
    k(1:50) = jj;
    plot3(r,k,ws(:,jj))
    hold on
end
hold off

title('Distribution of asset weights')
xlabel('Assets')
ylabel('Rho*20')
zlabel('Log (w)')



% each deviation from the function call is stored in the 'deviations'
% vector and is plotted below


%% To do: Call same T multiple times and take avergae since the grapgh is not smooth, Also do same for size of assets.
    