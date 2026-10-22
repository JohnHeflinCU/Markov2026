clc
clear
close all

D=[-1.77, 2.47, 1.34, 2.18, 13.05, 1.60, 1.50, -1.97, 0.79, 1.50, 2.00, 2.63, 1.19, -2.31, 0.87];

s=[0.02; 0.5; 5];

T=5e4;
acc=zeros(3,1);
for j=1:length(s)
    z=zeros(T+1,2);
    
for i=1:T
    y=zeros(2,1);
    y(1)=z(i,1)+s(j).*randn;
    y(2)=z(i,2)+s(j).*randn;
    g_y=g_x(y(1),y(2),length(D),D);
    g_z=g_x(z(i,1),z(i,2),length(D),D);
    a=min(1,g_y./g_z);
    if rand < a
        z(i+1,1)=y(1); 
        z(i+1,2)=y(2);
        acc(j)=acc(j)+1;
    else
        z(i+1,:)=z(i,:);
    end


end
figure
hold on
histogram(z(1:400,1),'Normalization','pdf')
title('First 400 Alpha Values')
ylabel('Probabilty')
xlabel('Alpha Value')
hold off

end

s_opt=.5;
z=zeros(T+1,2);
acc=0;
for i=1:T
    y=zeros(2,1);
    y(1)=z(i,1)+s_opt.*randn;
    y(2)=z(i,2)+s_opt.*randn;
    g_y=g_x(y(1),y(2),length(D),D);
    g_z=g_x(z(i,1),z(i,2),length(D),D);
    a=min(1,g_y./g_z);
    if rand < a
        z(i+1,1)=y(1); 
        z(i+1,2)=y(2);
        acc=acc+1;
    else
        z(i+1,:)=z(i,:);
    end
end
burn=5000;
z=z(burn:end,:);


figure
hold on
scatter(z(:,1),z(:,2))

grid on
hold off
function g=g_x(a,b,n,x)
    pro=prod(1./(exp(2.*b)+(x-a).^2));
    g=exp(b.*n).*pro;
end



lambda=4;

T=2e5;
y=zeros(T,1);
for i=1:T
    U=rand(1);
    y(i)=-log(1-U)/lambda;
end
figure
histogram(y,'Normalization','pdf')
xlabel('Time (hrs)')
ylabel('Probability density')
title('Histogram of wait time for a meteor')

for i=1:T
    U=rand(1);

    n = 0;
    cumulativeProbability = 0;
    while cumulativeProbability < U
        cumulativeProbability = cumulativeProbability + poisson(lambda,n);
        n = n + 1;
    end
    meteorCounts(i) = n - 1;
end
    
figure
histogram(meteorCounts,'Normalization','pdf')
xline(mean(meteorCounts),'-r')
xline(mean(meteorCounts)+std(meteorCounts),'--k')
xline(mean(meteorCounts)-std(meteorCounts),'--k')
xlabel('Number of meteors')
ylabel('Probability density')
title('Histogram of meteor counts for 1 hr')
legend('Histogram of Meteorcounts','Mean of Meteor Counts','1 standard deviation','1 standard deviation')

function p=poisson(lambda,n);
    p = exp(-lambda) .* lambda.^n ./ factorial(n);
end