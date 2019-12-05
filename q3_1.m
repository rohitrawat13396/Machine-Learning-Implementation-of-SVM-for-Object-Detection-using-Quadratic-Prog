[trD, trLb, valD, valLb, trRegs, valRegs]= HW4_Utils.getPosAndRandomNeg();
C=10;
[w,b,obj_value1,No_of_SVs1]= q2_3_primal(C,trD,trLb);
%valpred1 = w'*valD +b;
outFile = 'output.mat';
valdpath='val';
HW4_Utils.genRsltFile(w, b, valdpath,outFile);
[ap, prec, rec] = HW4_Utils.cmpAP(outFile,valdpath);
fprintf('AP = %f',ap);