clc
clear
close all



N=round(logspace(1,7,30));
%log scaled variable
for i=1:length(N)
    %for loop to rotate though each logscaled number of iterations N
    count=0;
    for j=1:N(i)
        %for loop rotates though number of iterations N
        X=rand;
        Y=rand;
        Z=rand;
        
        %uniform random variables X, Y, and Z
        if X.^2+Y.^2<Z && Z.^2>X.*Y
            count=count+1;
            %if its within bound increases counter by one
        else
            count=count;
            %if not count remains the same
        end
    end
    P(i)=count./N(i);
    %finds probability via dividing number of iterations within bounds and
    %total number of iterations
end


figure
semilogx(N,P)
xlabel('Number of Monte Carlo Simulations (log scale)')
ylabel('Probability')
title('Probability versus Number of Monte Carlo Simulations')

%Creates log scaled plot of number of iterations versus probability

%Converges to about P=0.376

