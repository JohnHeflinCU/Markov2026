
clear
clc
close all

%% Problem 4
%{
Discrete Steps: 
U: 1/2
I: 1/4, 1/2, 1/4 --> 1/4, 3/4
M: 1/4, 3/4 --> 1/4
N: 3/4, 1/4 --> 1/4
N': 1/2
A: 1
%}
n=10e4;
y_u=0;
t_u=zeros(n,1);
t_u_A=[];
t_u_F=[];
for i=1:n

    U=rand(1);
    [x,t_u(i)]=discrete_U(U,t_u(i));
    y_u=y_u+x; %counts number of folded
    
    if x==1
        t_u_F(end+1,1)=t_u(i); %takes values for x=1, folded
    else
        t_u_A(end+1,1)=t_u(i); %takes values for x=0, aggregate
    end
end
p_u=y_u./n
tau_U_F=mean(t_u_F);
tau_U_A=mean(t_u_A);
tau_U=mean(t_u);


t_i_F=[];
t_i_A=[];
y_i=0;
t_i=zeros(n,1);
for i=1:n

    U=rand(1);
    
    [x,t_i(i)]=discrete_I(U,t_i(i));
    y_i=y_i+x;
    if x==1
        t_i_F(end+1,1)=t_i(i);
    else
        t_i_A(end+1,1)=t_i(i);
    end

end
p_i=y_i./n
tau_i_F=mean(t_i_F);
tau_i_A=mean(t_i_A);
tau_i=mean(t_i);
figure
hold on
histogram(t_i_F, 'Normalization', 'pdf')
xline(tau_i_F)
xlabel('Number of steps folded')
ylabel('Probability')
legend('Histogram','Tau_x')
title('Distribution of Steps Starting at I Folded')
hold off
figure
histogram(t_i_A, 'Normalization', 'pdf')
xline(tau_i_A)
xlabel('Number of steps aggregate')
ylabel('Probability')
legend('Histogram','Tau_x')
title('Distribution of Steps Starting at I Aggregate')
y_m=0;
t_m=zeros(n,1);
t_m_F=[];
t_m_A=[];
for i=1:n

    U=rand(1);
    [x,t_m(i)]=discrete_M(U,t_m(i));
    y_m=y_m+x;

    if x==1
        t_m_F(end+1,1)=t_m(i);
    else
        t_m_A(end+1,1)=t_m(i);
    end
end
p_m=y_m./n
tau_M_F=mean(t_m_F);
tau_M_A=mean(t_m_A);
tau_m=mean(t_m);
%Functions to retrieve aggregate or folded value using discrete inverse
%transform
function [y,t]=discrete_U(U,t)
V=rand(1);
t=t+1;
if U<=.5
    [y,t]=discrete_I(V,t);
else
    [y,t]=discrete_M(V,t);
end
end
function [y,t]=discrete_M(U,t)
V=rand(1);
t=t+1;
if U<=.25
    y=0;
else
    [y,t]=discrete_U(V,t);
end
end
function [y,t]=discrete_I(U,t)
V=rand(1);
t=t+1;
if U<=.5
    y=1;
elseif U<=.75
    y=0;
else
    [y,t]=discrete_U(V,t);
end
end

%Creating table
tau_empirical=[tau_U; tau_i; tau_m];
tau_empirical_A=[tau_U_A; tau_i_A; tau_M_A];
tau_empirical_F=[tau_U_F; tau_i_F; tau_M_F];
tau_analytical=[4; 2; 4];

h_empirical=[p_u; p_i; p_m];
h_analytical=[0.5; 0.625; 0.375];
Starting_State=['U'; 'I'; 'M'];
var_name=['State', 'Tau_x', 'Tau_x^F', 'Tau_x^A', 'g_x', 'h_x empirical', 'h_x analytical'];

table(Starting_State, tau_empirical,tau_empirical_F,tau_empirical_A , tau_analytical, h_empirical, h_analytical, 'VariableNames', {'State', 'Tau_x', 'Tau_x^F', 'Tau_x^A', 'g_x', 'h_x empirical', 'h_x analytical'})