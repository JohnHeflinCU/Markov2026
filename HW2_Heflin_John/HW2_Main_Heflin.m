clc
clear
close all

%% Problem 1
Z=[1;2;3];
P_z=[.05;.15;.8]
for i=1:1000
    x(i)=inverse_transform(P_z,Z);
end
for i=1:length(Z)
    count(i)=numel(x(x==Z(i)))
end
figure
bar(Z,count)
%% Problem 3
N=10e4;
lambda=[1./2;0.2];

x=0:.001:50;

f_x_3=x.*exp(-x);

for i=1:N
check=1;
U=rand(1);
f=f_x_3(1);

j=1;
while check==1
    if U<f
        keep(i)=x(j);
        check=0;
    else
        j=j+1;
        f=f_x_3(j)+f;
    end 
end
end

figure
hold on
%plot(x,f_x_3)
histogram(keep, 'Normalization', 'pdf')

xlabel('Values')
ylabel('Probability Density')
title('Histogram of Sampled Values from Inverse Transform')
hold off




%% Problem 4

t=0:.001:1
a=.9;
lambda_f=1000;
lambda_s=10;
f_t=a.*lambda_f.*exp(-lambda_f.*t)+(1-a).*lambda_s.*exp(-lambda_s.*t)
count=0;
for i=1:10e5
U=rand(1);
V=rand(1);
if U<=a
    F_inv(i)=-log(1-V)./lambda_f;
else
    F_inv(i)=-log(1-V)./lambda_s;
end
if F_inv(i)>=.05
    count=count+1;
else
    count=count;
end
end
M=mean(F_inv)
P_50=count./(10e5)
P_50_A=a.*exp(-lambda_f.*.05)+(1-a).*exp(-lambda_s.*.05)
figure
hold on
plot(t,f_t,'-b','LineWidth',3)
histogram(F_inv,'Normalization','pdf')
set(gca,'YScale', 'log')
xline(M,'-r','LineWidth',3)
xlabel('Seconds')
ylabel('Number of Occurences')
title('Ion Channel Dwell Times and Mixture Sampling')
legend('Probability Density Function','Ion Channel Dwell Times','Mean=0.0109')
hold off

%% Problem 5
z_1=0:.01:1;
f_z=2.*(1-z_1);
for i=1:10e5
z=rand(1);
F_inv_z(i)=1-sqrt(1-z);
end
M_z=mean(F_inv_z)
C=ones(10e3,1);
for n=1:10e4
P=C./n;
R=rand(10e3,1);
if R<=P
C=C+1;
else
C=C;
end
end
figure
hold on
histogram(F_inv_z,'Normalization','pdf')
plot(z_1,f_z,'-b','LineWidth',3)
xline(M_z,'-r','LineWidth',3)
title('h(z)')
xlabel('Number of Cores')
ylabel('Number of Occurences')
legend('Histogram','Mean','pdf h(z)')
hold off
figure
hold on
histogram(C,'Normalization','pdf')
title('Number of Cores')
xlabel('Number of Cores')
ylabel('Number of Occurences')
hold off
