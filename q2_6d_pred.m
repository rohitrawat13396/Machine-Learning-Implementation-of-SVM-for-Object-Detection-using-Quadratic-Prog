C_2=10;
dX_val= str2double(X_val);
dX_val_size = size(dX_val);
dX_val = dX_val(:,2:dX_val_size(2));

dX_train_Val = [dX_train;dX_val];

[w_A,b_A,objA,No_of_SVs] = q2_3_primal(C_2,dX_train_Val',y_class_labelA);
%scoreA = w_A'*dX_train_Val' +b_A;
[w_B,b_B,objB,No_of_SVs] = q2_3_primal(C_2,dX_train_Val',y_class_labelB);
%scoreB = w_B'*dX_train_Val' +b_B;
[w_C,b_C,objC,No_of_SVs] = q2_3_primal(C_2,dX_train_Val',y_class_labelC);
%scoreC = w_C'*dX_train_Val' +b_C;
[w_D,b_D,objD,No_of_SVs] = q2_3_primal(C_2,dX_train_Val',y_class_labelD);
%scoreD = w_D'*dX_train_Val' +b_D;

%[alphaA,objA]= q2_2_quadprogfn(dX_train',y_class_labelA,C_2);
%[w_A,b_A,objA,No_of_SVs] = q2_3_primal(C_2,dX_train',y_class_labelA);
%scoreA = w_A'*dX_train' +b_A;
%[w_B,b_B,objB,No_of_SVs] = q2_3_primal(C_2,dX_train',y_class_labelB);
%scoreB = w_B'*dX_train' +b_B;
%[w_C,b_C,objC,No_of_SVs] = q2_3_primal(C_2,dX_train',y_class_labelC);
%scoreC = w_C'*dX_train' +b_C;
%[w_D,b_D,objD,No_of_SVs] = q2_3_primal(C_2,dX_train',y_class_labelD);
%scoreD = w_D'*dX_train' +b_D;

dX_test= str2double(X_test);
dX_test_size = size(dX_test);
dX_test = dX_test(:,2:dX_train_size(2));

scoreA = w_A'*dX_test' +b_A;
scoreB = w_B'*dX_test' +b_B;
scoreC = w_C'*dX_test' +b_C;
scoreD = w_D'*dX_test' +b_D;

Scores= [scoreA;scoreB;scoreC;scoreD];
Scores= Scores';
labels =repmat(Scores,1);
Max_lb = max(labels,[],2);
lb_size=size(labels);
predlb = zeros(lb_size(1)+1,2);
for i = 1:lb_size(1)
    for j = 1:lb_size(2)
       if(labels(i,j)==Max_lb(i))
           predlb(i+1,1)= i;
           predlb(i+1,2)= j;
       end
    end
end
%final = [];
%final= [X_test{:,1}';predlb(:,2)'];
%(string(predlb));
%writematrix(final,'prediction.csv');
%csvwrite('prediction1.csv',final);
