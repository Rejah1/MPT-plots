%This will output a graph of deviations thats it

clear;
weights = [1:99]; % this does not work yet i will work on it 
deviations = [1:200]; % initialises a 1*99 vecotr
%ns = linspace(25,1000,40); % makes vector of all values of T i will test
rp = linspace(0.01,2,200);
ns = round(50./rp);

for ii = 1:200
    [~, deviations(ii)] = CorrMPTFunc(ns(ii)); % calls function for each value of t
end

% each deviation from the function call is stored in the 'deviations'
% vector and is plotted below

%x = 1:99; 
%x = 50./ns;
x = rp;
x(100) = NaN;
b = deviations;
b(100) = NaN;

figure
plot(x, abs(b))
Fit = polyfit(rp,abs(deviations),3);
rand = polyval(Fit,x);
hold on
plot(x,rand, '--r')
%title('True risk - Predicted risk / True risk')
title('Corr - True risk')
xlabel('N/T')
ylabel('Ratio')

%% To do: Call same T multiple times and take avergae since the grapgh is not smooth, Also do same for size of assets.
    