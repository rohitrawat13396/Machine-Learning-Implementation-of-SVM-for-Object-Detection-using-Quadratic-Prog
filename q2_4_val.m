C= 0.1000;
disp("When C = 0.1: ");
[w1,b1,obj_value1,No_of_SVs1]= q2_3_primal(C,trD,trLb);
valpred1 = w1'*valD +b1;
q2_prediction_and_disp(valLb,valpred1,obj_value1,No_of_SVs1);
