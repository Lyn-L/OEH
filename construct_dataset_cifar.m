function exp_data = construct_dataset_cifar()
%data constrcution
addpath('./tool/');

addpath('./data/cifar');
load 'Cifar10-Gist512.mat';
X_class = X_class';
rp = randperm(size(X,1));
rp = rp(1:1000);
test_data = X(rp,:);
test_label = X_class(rp,:);
X(rp,:) = []; X_class(rp,:) = [];
train_data =  X(:,:);
train_label = X_class(:,:);
clear X, X_class;
multiLabel = 0;


train_num = size(train_data,1); %number of traning data

train_data = double(train_data');
test_data = double(test_data');

if multiLabel == 0
    groundtruth = bsxfun(@eq, train_label, test_label');
    groundtruth = groundtruth';
else
    groundtruth = getGnd1(train_label,test_label);
end

exp_data.dim = size(test_data,1);
exp_data.ndim = 1; %number of nneighbors per class
exp_data.train_num = train_num;%length(trn_coarse_labels);


N_train = 10000;
% N_train = train_num;
rp = randperm(train_num);
rp = rp(1:N_train);

exp_data.train_data = train_data(:,rp);
exp_data.traingnd = train_label;
if multiLabel == 0
    train_label = train_label(rp,:);
    L = train_label;
    Y = [0:9];
    Y = repmat(Y,size(train_label,1),1);
    train_label = double(repmat(train_label,1,size(Y,2)));
    Y = Y - train_label;
    Y(Y==0) = 1e6;
    Y(Y<11) = 0;
    Y(Y~=0) = 1;
    exp_data.Lv = Y;
    exp_data.L = L;
else
    exp_data.L = train_label(rp,:);
    exp_data.Lv = train_label(rp,:);
end

exp_data.db_data = train_data;
exp_data.test_data = test_data;%single label test
exp_data.groundtruth = groundtruth;
exp_data.testgnd = test_label;

  
  
