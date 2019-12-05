%disp('\n');
C= 10;
disp("When C = 10: ");
[w2,b2,obj_value2,No_of_SVs2]= q2_3_primal(C,trD,trLb);
valpred2 = w2'*valD +b2;
q2_prediction_and_disp(valLb,valpred2,obj_value2,No_of_SVs2);
