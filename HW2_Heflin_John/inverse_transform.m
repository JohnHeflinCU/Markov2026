function x=inverse_transform(P,X)
S=P(1);
i=1;
check=1;
U=rand(1);
while check==1
    if U<S
        x=i;
        check=0;
    else
        i=i+1;
        S=S+P(i);
    end 
end

end