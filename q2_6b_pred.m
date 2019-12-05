fprintf('Classifier A: Class A vs All:\n')

%y_train=labelfile_to_matrix(trainLb);
%y_val = labelfile_to_matrix(ValLb);
%X_train= sort_the_matrix(X_train_pre,y_train);
%X_val= sort_the_matrix(X_val_pre,y_val);

%ind = readtable('index_test.csv');
%ind = table2cell(ind);
%ind_size=size(ind);
%id_test_sorted = zeros(ind_size(1),2);
%id_test_sorted=double2cell(id_test_sorted);
%id_test_sorted{:,1} = natsortfiles(ind);

%X_test= sort_the_matrix(X_test_pre,id_test_sorted);
X_test= repmat(X_test_pre,1);
function [X_new]=sort_the_matrix(X,y)
    X_train_size = size(X);
    %X_new = repmat(X,1);
    X_new = zeros(X_train_size);
    for i = 1: X_train_size(1)
        for j= 1: X_train_size(1)
            if (strcmp(y(i,1),X(j,1))==1)
                X_new(i,:)= X(j,:);
                break;
            end
        end
    end
end


function [X]=labelfile_to_matrix(Name)
    fid = fopen(Name,'r');
    X =[];
    l=1;
        while ~feof(fid)
            tline = fgetl(fid);
            tline= strsplit(tline,",");
            %use strplit to split the line, first cell contains the id, rest 512 cells contain the 512-d feature
            if l >1
                %disp(tline);
                X= [X;tline];
            end
            l=2;
        end
    fclose(fid);
end
%listNames=table2cell(y_train(:,1));

%fprintf('ele= %f',y_train(1,2));
%trainA(:,1)= disp(y_train(1:y_train_size(1),1:1));
%trainA(1,:)= y_train.Category;
%for i = 1:y_train_size(1)
%    if y_train(i,2)==1
%        trainA(i,1) = 1;
%    else
%        trainA(i,1)= -1;
%    end
%end

