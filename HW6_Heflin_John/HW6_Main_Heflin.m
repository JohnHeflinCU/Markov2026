clc
clear
close all
%% Problem 1

P=[0, 1, 0, 0; 0, 0, 1, 0; 0, 0, 0, 1; 1./2, 1./2, 0, 0] %All states Aperiodic
n=9;

P_n=P^n
P_10=P^10
P_11=P^11


P=[0, 1, 0, 0; 0, 0, 1, 0; 0, 0, 0, 1; 1./2, 0, 1./2, 0] %All states Aperiodic

m=3:12;
M=zeros(length(m),1);
power=zeros(length(m),1);
lambda_2=zeros(length(m),1);
lambda_2_mag=zeros(length(m),1);
for k=1:length(m)
power(k)=(m(k)-1).^2+1
P=zeros(m(k),m(k));
P(m(k),1)=1./2;
P(m(k),2)=1./2;
for i=1:(m(k)-1)
     P(i,i+1)=1;
end
lambda=eig(P)
lambda_2(k)=lambda(2);
lambda_2_mag(k)=norm(lambda_2(k));
j=1;
check=0;
while check==0
    if all(P>0,'all');
        P=P;
        check=1;
    else
        P=P*P;
        j=j+1;
        check=0;
    end
    M(k)=j;
    if j>100
        break
    end

end
end
M
power
lambda_2

T=table(M,power,lambda_2,lambda_2_mag)
writetable(T, 'M_power_lambda_comparision.csv')

%% Problem 2
% Read File
T=readtable("big12.csv");
season=T(:,1);
week=T(:,2);
date=T(:,3);
home=T(:,4);
home_pts=T(:,5);
away=T(:,6);
away_pts=T(:,7);
neutral=T(:,8);
comleted=T(:,9);

T_2025=T(T.season==2025,:);
T_2026=T(T.season==2026,:);

teams = {'Oklahoma State','Texas Tech','Kansas State','Houston', ...
         'Arizona','Utah','Kansas','Baylor','Arizona State', ...
         'Iowa State','Colorado','BYU','Cincinnati','UCF', ...
         'TCU','West Virginia'};
%{
for i=1:length(teams)
     T_temp=T_2025(T_2025.home==teams(i) || T_2025.away==teams(i),:);
end
%}

P=[0,1,0,0;0,0,1,0;0,0,0,1;1/2,0,1/2,0];
e=eig(P)
P=[0,1,0,0,0,0;0,0,1,0,0,0;0,0,0,1,0,0;0,0,0,0,1,0;0,0,0,0,0,1;1/2,0,1/2,0,0,0];
e=eig(P)



%% Problem 3

%c
N=[100; 1000];
K_c=N./10;
R_0_c=linspace(.5,3,10);


for k=1:length(R_0_c)
rho(1)=1;
for i=1:(K_c(1)-1)
    rho(i+1)=rho(i).*N(1)./(R_0_c(k).*(N(1)-(i)));
end
rho_100(k)=sum(rho);

rho_1(1)=1;
for i=1:(K_c(2)-1)
    rho_1(i+1)=rho_1(i).*N(2)./(R_0_c(k).*(N(2)-(i)));
end
rho_1000(k)=sum(rho_1);
end
h_1_100=1./rho_100;
h_1_1000=1./rho_1000;
figure
hold on
plot(R_0_c,h_1_100,'LineWidth',1.2)
plot(R_0_c,h_1_1000,'LineWidth',1.2)
plot(R_0_c,1-1./R_0_c,'--')
legend('N=100','N=1000','1-1/R_0','Location','best')
xlabel('R_0')
ylabel('h_1')
title('R_0 versus h_1')
hold off

%% d

N=100;
K=10;
gamma=1;
t=.005;
r_0=[.5;.8;1.5;3];
beta=r_0.*gamma./N;

P=zeros(N,N);
P(1,1)=1-beta(1).*(N-1).*t;
P(1,2)=beta(1).*(N-1).*t;
P(N,N)=1-gamma*t;
P(N,N-1)=gamma^t;
e(1)=1+P(1,2);
for i=2:(N-2)
p=beta(1).*i.*(N-i).*t;
q=gamma.*i.*t;

P(i,i+1)=p;
P(i,i-1)=q;
P(i,i)=1-p-q;
e(i)=1-q+p;
end
e(N)=1-P(N,N-1);
E=table(e)
writetable(E, 'Expectation_simulation.csv')
