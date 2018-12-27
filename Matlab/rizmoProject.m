opened_file = fopen('faces/train.txt');
path_matrix = textscan(opened_file,'%s %d','HeaderLines',0,'CollectOutput',1);
path_matrix = path_matrix{:};
opened_file = fclose(opened_file);
path_matrix(:,1);

for i=1:540
    X(i, 1:2500) = reshape(imread(path_matrix{i}), 1, 2500);
end

% % show one of pictures
%  imgDouble = X(2,:);
%  imgUint8 = uint8(imgDouble);
%  img = reshape(imgUint8 , 50 , 50);
%  imshow(img);


X = double(X);

for i=1:2500
    sum = 0;
    for j=1:540
        sum = sum + X(j,i);
    end
    X_Avg(i) = sum/540;
end
% % show avgPic
% X_AvgUint8 = uint8(X_Avg);
% avgPic = reshape(X_AvgUint8 , 50 , 50);
% imshow(avgPic);


for i=1:2500
    for j=1:540
        X_Sub(j , i) = X(j,i) - X_Avg(i);
    end
end

% % show one of pictures
% imgDouble = X_Sub(2,:);
% imgUint8 = uint8(imgDouble);
% img = reshape(imgUint8 , 50 , 50);
% imshow(img);

% tabdile matrise x_sub be u,s,vt
[u , s , v] = svd(X);
vt = transpose(v);

% % show 10 tasvir vizhe aval
% vtRowUint8 = uint8(vt(10,:));
% vtRow = reshape(vtRowUint8 , 50 , 50);
% imshow(vtRow);


% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

opened_file_test = fopen('faces/test.txt');
path_matrix_test = textscan(opened_file_test,'%s %d','HeaderLines',0,'CollectOutput',1);
path_matrix_test = path_matrix_test{:};
opened_file_test = fclose(opened_file_test);
path_matrix_test(:,1);

for i=1:100
    X_test(i, 1:2500) = reshape(imread(path_matrix_test{i}), 1, 2500);
end

% % show one of pictures
%  imgDouble = X_test(2,:);
%  imgUint8 = uint8(imgDouble);
%  img = reshape(imgUint8 , 50 , 50);
%  imshow(img);

X_test = double(X_test);

for i=1:2500
    sum_test = 0;
    for j=1:100
        sum_test = sum_test + X_test(j,i);
    end
    X_test_Avg(i) = sum_test/100;
end

% % show avgPic
% X_AvgUint8 = uint8(X_test_Avg);
% avgPic = reshape(X_AvgUint8 , 50 , 50);
% imshow(avgPic);

for i=1:2500
    for j=1:100
        X_test_Sub(j , i) = X_test(j,i) - X_test_Avg(i);
    end
end

% % show one of pictures
% imgDouble = X_test_Sub(2,:);
% imgUint8 = uint8(imgDouble);
% img = reshape(imgUint8 , 50 , 50);
% imshow(img);

[u_test , s_test , v_test] = svd(X_test);
vt_test = transpose(v_test);

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

for r=1:200
    % compute ur from u
    ur( 1:540 , 1:r) = u( 1:540 , 1:r);

    % compute sr from s
    sr(1:r , 1:r) = s(1:r , 1:r);

    % compute vr from v
    vtr(1:r , 1:2500) = vt(1:r , 1:2500);
    
    Xr = ur * sr * vtr;
    
    distance(r) = norm(double(X - Xr));
end;
plot(distance);

f = myFunc(X , vt , 10);
f_test = myFunc(X_test , vt_test , 10);

% show one of pictures
% imgDouble = Xr(2,:);
% imgUint8 = uint8(imgDouble);
% img = reshape(imgUint8 , 50 , 50);
% imshow(img);

