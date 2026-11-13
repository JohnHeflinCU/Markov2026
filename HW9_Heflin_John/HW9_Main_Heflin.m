clc
close all
clear
t(1)=0;
f_2(1)=0;
a = 3;
b = 1;
i=1;
%% 2
while abs(f_2-a./(a+b))>.01
    f_2(i+1)=a.*(1-exp(-(a+b).*t(i)))./(a+b);
    
    i=i+1;
    t(i) = t(i-1) + 0.01;
end
figure
plot(t, f_2, 'o')
xlabel('Time')
ylabel('f_2')
grid on

%% 3

Q=[-2,2,0,0;1,-3,2,0;0,2,-4,2;0,0,3,-3];

lambda=eig(Q)
sum_lambda=sum(lambda)
figure
plot(real(lambda), imag(lambda), 'x')
xlabel('Real part')
ylabel('Imaginary part')
grid on
t=0:.1:5;
x_0=[1,0,0,0];
pi_stationary=[3;6;6;4]./19;

x_t=zeros(length(t), length(x_0));
for i=1:length(t)
    x_t(i, :) =x_0*expm(Q*t(i));
end

TV_0=x_t(:,1)-pi_stationary(1);
TV_1=x_t(:,2)-pi_stationary(2);
TV_2=x_t(:,3)-pi_stationary(3);
TV_3=x_t(:,4)-pi_stationary(4);


Total_Variation=.5.*(abs(TV_0)+abs(TV_1)+abs(TV_2)+abs(TV_3));
lambda_2_line=1-1.5108.*t
figure
semilogy(t, Total_Variation)
hold on
yline(0.1,'--r','LineWidth',2)
semilogy(t, abs(lambda_2_line), '--k', 'LineWidth', 1.5)
legend('Total Variation', 'Threshold', 'Lambda_2 Line')
hold off
xlabel('Time (hours)')
ylabel('Total Variation')
title('Log Scaled Total Variation Distance versus Time')
grid on


figure
hold on
plot(t, TV_0, t, TV_1, t, TV_2, t, TV_3)
legend('0 Positions','1 Positions','2 Positions','3 Positions')
xlabel('Time (hours)')
ylabel('Total Variation Distance')
title('Total Variation Distance versus Time')
hold off

figure
hold on
plot(t, x_t)
yline(pi_stationary,'--r','LineWidth',2)
xlabel('Time (hours)')
ylabel('State probabilities')
legend('0 Positions','1 Positions','2 Positions','3 Positions')
title('Market Positions Available Likelihood Versus Time')
grid on
hold off
%log scaled
