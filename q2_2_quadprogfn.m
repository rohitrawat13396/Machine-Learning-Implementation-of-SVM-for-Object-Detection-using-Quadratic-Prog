
function [alpha,obj_value]=q2_2_quadprogfn(X,y,C)
    X_size = size(X);
    H= (y*y').*(X'*X);
    %M = X'*X;
    f=-ones(1,X_size(2));
    A= [];
    b=[];
    Aeq= y';
    beq= 0;
    lb = zeros(1,X_size(2));
    %C=10;
    ub = ones(1,X_size(2))*C;

    alpha=quadprog(H,f,A,b,Aeq,beq,lb,ub);
    obj_value= 0.5000*((alpha')*H)*alpha + (f*alpha);
end




