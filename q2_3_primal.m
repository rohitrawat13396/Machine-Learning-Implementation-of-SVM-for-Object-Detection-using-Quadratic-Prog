
function [w,b,obj_value,No_of_SVs] = q2_3_primal(C,X,y)

[alpha,obj_value]=q2_2_quadprogfn(X,y,C);
M = X'*X;
w = X*(alpha.*y);
t= find((alpha<C-0.000001)&(alpha>0.000001)) ;
svs= find(alpha>0.000001);
No_of_SVs = size(svs);
index=min(t);
b = y(index) - w'*X(:,index);
end


