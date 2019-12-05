function q2_prediction_and_disp(y,valpred,obj_value,No_of_SVs)
    X_val_size= size(valpred);
    valLb_pred = zeros(X_val_size(2),1);

    for i = 1:X_val_size(2)
        if (valpred(i)<0)
            valLb_pred(i)= -1;
        else
            valLb_pred(i)= +1;
        end
    end

    correctpred=find(valLb_pred==y) ;
    No_of_corr_pred = size(correctpred);
    accuracy = (No_of_corr_pred(1)/X_val_size(2))*100;
    fprintf('\nAccuracy = %f\n', accuracy);
    fprintf('\nObjective Value of SVM = %f\n', obj_value);
    fprintf('\nNumber of SVs = %f\n', No_of_SVs(1));
    C_matrix = confusionmat(y,valLb_pred);
    fprintf('\nConfusion Matrix =\n');
    disp(C_matrix);
    confusionchart(C_matrix);
end