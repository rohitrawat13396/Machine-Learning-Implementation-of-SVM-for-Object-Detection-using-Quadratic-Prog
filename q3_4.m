outFile = '112963417.mat';
dataset='test';
HW4_Utils.genRsltFile(w2, b2, dataset,outFile);
%[ap, prec, rec] = HW4_Utils.cmpAP(outFile,dataset);