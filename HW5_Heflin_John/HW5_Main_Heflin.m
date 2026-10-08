clc
clear
close all
%% Problem 1
%b)
clc
clear
a=.3;
b=.1;
delta_0=[1,0,0,0,0];
p_1=zeros(5,5);
p_1(1,1)=1-a;
p_1(1,2)=a;
for i=2:4

    p_1(i,i+1)=a.*(4-i)./i;
    p_1(i,i-1)=b.*i./4;
    p_1(i,i)=1-p_1(i,i+1)-p_1(i,i-1);

end
p_1
q_50=delta_0*(p_1^50)
q_51=delta_0*(p_1^51)
n=1:60;
for i=1:60
   
q=delta_0*(p_1^i);
q_2(i)=q(2);
q_3(i)=q(3);
q_ave_2(i)=mean(q_2);
end
[V,lambda]=eig(p_1)
figure
hold on
plot(n,q_2)
plot(n,q_3)
plot(n,q_ave_2)
legend('q_2','q_3','running average')
xlabel('n')
ylabel('q value')
hold off
for i=0:4
pi(i+1)=((.25).^(4-i)).*((3./4).^i).*factorial(4)./(factorial(i).*factorial(4-i))
end

%% Problem 3
% a)

p_a=mat_p(1); %Checking
p_test=mat_p(.6); %Testing
q_0=[1,1,1,1,1,1,1,1]./8;
q_100=q_0*(p_a^100)
q_101=q_0*(p_a^101)
%does not converge
%{
q_100_test=q_0*(p_test^100)
q_101_test=q_0*(p_test^101) 
%converges
%}

%b
d=.85

p=mat_p(d)
diff=1;
n=1;
q_n1=q_0;
while diff>10e-6
q_n=q_n1;
q_n1=q_n*p;
diff=mean(abs(q_n1-q_n))
n=n+1;
if n>1000
    break
end


end
q_n
q_n1
n



% c)



%{
function [y,t]=discrete(U,t,p,i)
V=rand(1);
t=t+1;
steps(1)=p(i,1);
for j=1:8
steps(j+1)=steps(j)+p(i,j);
end
if U<=steps(1)
    [y,t]=discrete(V,t,p,i);
elseif U<=steps(2)
    [y,t]=discrete(V,t,p,i);
elseif U<=steps(3)
    [y,t]=discrete(V,t,p,i);
elseif U<=steps(4)
    [y,t]=discrete(V,t,p,i);
elseif U<=steps(5)
    [y,t]=discrete(V,t,p,i);
elseif U<=steps(6)
    [y,t]=discrete(V,t,p,i);
elseif U<=steps(7)
    [y,t]=discrete(V,t,p,i);
else
    [y,t]=discrete(V,t,p,i);
end

end



%}

function p=mat_p(d)
p=[0,d./2,d./2,0,0,0,0,0;0,0,0,d,0,0,0,0;d./2,0,0,0,d./2,0,0,0;d./3,0,d./3,0,d./3,0,0,0;0,d./3,0,0,0,d./3,d./3,0;0,0,0,0,0,d,0,0;0,0,0,0,0,0,0,d;0,0,0,0,0,0,d,0];
p=p+(1-d)./8;
end
%{
function steps=discete(P,t)
[m,n]=size(P);
steps=zeros(n,1);
for k=1:t
for i=1:m
    s=zeros(n,1);
    V=rand(1);
    j=1;
    while j<n+1
        
        if V>s(j,1)
        s(j,1)=P(i,j)+s(j,1);
        j=j+1;
        else
        steps(j,1)=steps(j,1)+1;
        break
        end
    end
end
end
end

%}
        



function x=inverse_transform(P,X)

end