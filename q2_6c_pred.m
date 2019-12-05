y_train_val=[y_train;y_val];
y_train_size = size(y_train_val);
class_labels_2 = str2double(y_train_val);

%y_train_size = size(y_train);
%class_labels_2 = str2double(y_train);

y_class_labelA = zeros(y_train_size(1),1);

for i = 1:y_train_size(1)
    if (class_labels_2(i,2)~=1)
        y_class_labelA(i) = -1;
    else
        y_class_labelA(i)= 1;
    end
end
y_class_labelB = zeros(y_train_size(1),1);

for i = 1:y_train_size(1)
    if (class_labels_2(i,2)~=2)
        y_class_labelB(i) = -1;
    else
        y_class_labelB(i)= 1;
    end
end
y_class_labelC = zeros(y_train_size(1),1);

for i = 1:y_train_size(1)
    if (class_labels_2(i,2)~=3)
        y_class_labelC(i) = -1;
    else
        y_class_labelC(i)= 1;
    end
end

y_class_labelD = zeros(y_train_size(1),1);

for i = 1:y_train_size(1)
    if (class_labels_2(i,2)~=4)
        y_class_labelD(i) = -1;
    else
        y_class_labelD(i)= 1;
    end
end
dX_train= str2double(X_train);
dX_train_size = size(dX_train);
dX_train = dX_train(:,2:dX_train_size(2));


