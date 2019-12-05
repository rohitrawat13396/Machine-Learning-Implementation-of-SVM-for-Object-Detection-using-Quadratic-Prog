
disp(obj);
x_size1 = size(obj);
x = 1:x_size1(2);
%disp(ap_val);
draw = 1;
if draw
     
    plot(x,obj,'-', 'LineWidth', 3);
    grid;
    xlabel 'Iterations'
    ylabel 'Object Values'
    %title('Precision-recall curve');
    axis([0 1 0 1])
end