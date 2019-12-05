negD = [];
posD = [];
lbnegD = [];
lbposD = [];
dataset = 'train';
ValoutFile = 'valmat.mat';
valdataset='val';
[trD, trLb, valD, valLb, trRegs, valRegs]= HW4_Utils.getPosAndRandomNeg();
[w2,b2,obj_value_old,No_of_SVs2]= q2_3_primal(10,trD,trLb);
m=1;
n=1;
tol =0;
obj = [];
for i = 1:10
    trd_size= size(trD);
    
    for j = 1:trd_size(2)
        %for k = 1:trd_size(2)
        if (trLb(j)==-1)
            if (1-(trLb(j)*(w2'*trD(:,j)+b2)))>0.00001
                negD(:,m)= trD(:,j);
                lbnegD(m)= trLb(j);
                m=m+1;
            end
        else
            posD(:,n)= trD(:,j);
            lbposD(n)= trLb(j);
            n=n+1;
        end
    end
    trD = [posD';negD']';
    trLb = [lbposD';lbnegD'];
    %break;

    imFiles = ml_getFilesInDir(sprintf('%s/%sIms/', HW4_Utils.dataDir, dataset), 'jpg');
    nIm = length(imFiles);            
    rects_itr = cell(1, nIm);
    startT = tic;
    for v=1:nIm
        ml_progressBar(v, nIm, 'Ub detection', startT);
        im = imread(imFiles{v});
        rects_itr{v} = HW4_Utils.detect(im, w2, b2);
    end
    
    load(sprintf('%s/%sAnno.mat', HW4_Utils.dataDir, dataset), 'ubAnno');
    [posD2, negD2, posRegs2, negRegs2] = deal(cell(1, length(ubAnno)));
    
    for q=1:length(ubAnno)
        ml_progressBar(q, length(ubAnno), 'Processing image');
        im = imread(sprintf('%s/%sIms/%04d.jpg', HW4_Utils.dataDir, dataset, q));
        %rects_itr{q} = HW4_Utils.detect(im, w2, b2);                                
        %im = rgb2gray(im);
        ubs = ubAnno{q}; % annotated upper body
        
        [imH, imW,~] = size(im);
        badIdxs = or(rects_itr{q}(3,:) > imW, rects_itr{q}(4,:) > imH);
        rects_itr{q} = rects_itr{q}(:,~badIdxs);
        
        for j=1:size(ubs,2)
            overlap = HW4_Utils.rectOverlap(rects_itr{q}, ubs(:,j));                    
            rects_itr{q} = rects_itr{q}(:, overlap < 0.3);
            if isempty(rects_itr{q})
                break;
            end;
        end;
        %rects_itr=mat2cell(rects_itr);
        % Now extract features for some few random patches
        nNeg2SamplePerIm = 10;
        [D_i, R_i] = deal(cell(1, nNeg2SamplePerIm));
        
        for j=1:nNeg2SamplePerIm
            imReg = im(round(rects_itr{q}(2,j)):round(rects_itr{q}(4,j)), round(rects_itr{q}(1,j)):round(rects_itr{q}(3,j)),:);
            imReg = imresize(imReg, HW4_Utils.normImSz);
            R_i{j} = imReg;
            D_i{j} = HW4_Utils.cmpFeat(rgb2gray(imReg));                    
        end
        negD2{q} = cat(2, D_i{:});                
        negRegs2{q} = cat(4, R_i{:});
    end    
    %posD = cat(2, posD{:});
    negD2 = cat(2, negD2{:});   
    %D = cat(2, posD, negD);
    lbnegD2 = [-ones(size(negD2,2), 1)];
    imRegs = cat(4,negRegs2{:});            
    
    trD = [trD';negD2']';
    trLb = [trLb;lbnegD2];
    trD= double(trD);
    [w_new,b_new,obj_value_new,No_of_SVs_new]= q2_3_primal(10,trD,trLb);
    fprintf('old obj =%f, new obj = %f\n',obj_value_old,obj_value_new);
    %obj_value_old= obj_value_new;
    %w2= w_new;
    %b2= b_new;
    fprintf('Iteration i= %d',i);
    obj(i)= obj_value_new;
    
    HW4_Utils.genRsltFile(w2, b2, valdataset,ValoutFile);
    [ap_val(i), prec, rec] = HW4_Utils.cmpAP(ValoutFile,valdataset);
    
    if (obj_value_new>=obj_value_old)
        obj_value_old= obj_value_new;
        w2= w_new;
        b2= b_new;
    else
        tol=tol+1;
        obj_value_old= obj_value_new;
        w2= w_new;
        b2= b_new;
       if(tol>2)
            fprintf('SVM cannot further optimised after %f iterations\n',i);
            break;
       end
    end      
end
