trainD_Name = 'Train_Features.csv';
trainLb = 'Train_Labels.csv';
ValD_Name = 'Val_Features.csv';
ValLb = 'Val_Labels.csv';
TestD_Name = 'Test_Features.csv';

X_train_pre = file_to_matrix(trainD_Name);
X_val_pre = file_to_matrix(ValD_Name);
X_test_pre = file_to_matrix(TestD_Name);

function [X]=file_to_matrix(Name)
    fid = fopen(Name,'r');
    X =[];
        while ~feof(fid)
            tline = fgetl(fid);
            tline= strsplit(tline);
            %use strplit to split the line, first cell contains the id, rest 512 cells contain the 512-d feature
            %disp(tline);
            X= [X;tline];
        end
    fclose(fid);
end
