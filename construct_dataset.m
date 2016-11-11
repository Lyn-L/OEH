function exp_data = construct_dataset(topNum)
%data constrcution

load 'LabelMe';
db_data = X; clear X;

%%
[ndata, D] = size(db_data);
R = randperm(ndata);
num_test = 500;
test_data = db_data(R(1:num_test), :);
% test_ID = R(1:num_test);
R(1: num_test) = [];
train_data = db_data(R, :);
% train_ID = R;
num_training = size(train_data, 1);
%%
if topNum == 0
    topNum = 0.02 * size(train_data,1);
end
% topNum = 500;
DtrueTestTraining = distMat(test_data, train_data);

[~,ind] = sort(DtrueTestTraining,2);
ind = ind(:,1:topNum);
WtrueTestTraining = zeros(num_test,num_training);

for i=1:num_test
     WtrueTestTraining(i,ind(i,:)) = 1;
end
clear DtrueTestTraining;
%%
% generate training ans test split and the data matrix
XX = [train_data; test_data];

% % center the data, VERY IMPORTANT
% sampleMean = mean(XX,1);
% XX = (double(XX)-repmat(sampleMean,size(XX,1),1));
% 
% normalize the data
% XX = normalize1(XX);


exp_data.db_data = XX(1:num_training, :)';
exp_data.test_data = XX(num_training+1:end, :)';
clear XX;
train_num = 10000;
rp = randperm(num_training);
exp_data.train_data = train_data(rp(1:train_num),:)';

exp_data.dim = size(test_data,1);
exp_data.ndim = 1;
exp_data.train_num = train_num;
exp_data.groundtruth = WtrueTestTraining;
  
  