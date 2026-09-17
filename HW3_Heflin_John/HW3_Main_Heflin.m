clc
clear
close all


%% Problem 1

P=[.9,.1,0;0,.75,.25;.5,0,.5];
n=50;
P_n=P^n

%% Problem 2

P=[.5,.5,0,0,0,0;1./3,0,1./3,0,1./3,0;0,0,1./4,3./4,0,0;0,0,1,0,0,0;0,0,0,0,0,1;0,0,0,0,1,0];

P_20=P^20

P_21=P^21



%% Problem 4
%part b
d_0=10;

R=2e4;
T=1e4;


pos_lamb=zeros(R,1);
pos_lion=10;
steps=zeros(R,1);
for i=1:R

count=0;
while pos_lamb(i)~=pos_lion
    U=rand(1);
    V=rand(1);
    if U<.5
        pos_lamb(i)=pos_lamb(i)+1;
    else
        pos_lamb(i)=pos_lamb(i)-1;
    end
    if V<.5
        pos_lion=pos_lion+1;
    else
        pos_lion=pos_lion-1;
    end
    count=count+1;
    if count>1e4
        break;
    end

end
steps(i)=count;
pos_lion=10;
end

lambs_caught=steps(steps~=10001);
mean_1=mean(lambs_caught);

[N_1,edges_1]=histcounts(lambs_caught, 'Normalization','pdf');
edges_1=edges_1(2:end);
p_1=polyfit(log(edges_1),log(N_1),1);

b_1=-p_1(1);
a_1=exp(p_1(2));
xFit = logspace(log10(1e2),log10(1e4),length(N_1));
yFit = a_1.*xFit.^(-b_1);
S_1_erf=erf(d_0./(2.*sqrt(xFit)));
figure
hold on
histogram(lambs_caught, 'Normalization', 'pdf')
plot(xFit,yFit,'-b','LineWidth',4)
plot(xFit,S_1_erf,'-g','LineWidth',4)
set(gca, 'YScale', 'log')
set(gca,'XScale','log')
xlabel('Steps to Catch Lamb')
ylabel('Probability Density')
title('Number of Steps Taken With One Lion')
legend('Histogram of Steps Taken','Power Law Curve Fit (Beta_2=1.667)','Error Function Curve')
hold off
%% Break
%Part c
pos_lamb=zeros(R,1);

steps=zeros(R,1);
for i=1:R
    pos_lion=[10;10];
    count=0;
    while pos_lamb(i)~=pos_lion(1) && pos_lamb(i)~=pos_lion(2)
        U=rand(1);
        V=rand(2,1);
        if U<.5
            pos_lamb(i)=pos_lamb(i)+1;
        else
            pos_lamb(i)=pos_lamb(i)-1;
        end
        if V(1)<.5
            pos_lion(1)=pos_lion(1)+1;
        else
            pos_lion(1)=pos_lion(1)-1;
        end
        if V(2)<.5
            pos_lion(2)=pos_lion(2)+1;
        else
            pos_lion(2)=pos_lion(2)-1;
        end
        count=count+1;
        if count>1e4
            break;
        end

    end
    steps(i)=count;
    
end

lambs_caught_2=steps(steps~=10001);
mean_2=mean(lambs_caught_2);
[N_2,edges_2]=histcounts(lambs_caught_2(lambs_caught_2<7000), 'Normalization','pdf');
edges_2=edges_2(2:end);
p_2=polyfit(log(edges_2), log(N_2),1);
b_2=-p_2(1);
a_2=exp(p_2(2));
xFit_2=logspace(log10(1e2),log10(1e4),length(N_2));
yFit_2=a_2.*xFit_2.^(-b_2);
figure
hold on
histogram(lambs_caught_2,'Normalization','pdf')
plot(xFit_2,yFit_2,'-r','LineWidth',4)
plot(xFit,yFit.^2,'-b','LineWidth',4)
set(gca,'YScale','log')
set(gca,'XScale','log')
ylabel('Probability Density')
xlabel('Number of Steps')
title('Number of Steps Taken With Two Lions')
legend('Number of Steps Taken Histogram','Power Law Curve Fit (Beta_2=1.8589)','One Lion Power Law Squared')
hold off




