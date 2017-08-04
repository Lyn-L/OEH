clear all;close all;warning off;clc;
addpath(genpath('./hashing/Unsupervised/'));
addpath(genpath('./hashing/Our Method/'));
addpath('./tool');
nbits = 64;
data = construct_dataset_cifar();
fprintf('data construct over!\n');

Xparam.nbits = nbits;
Xparam.maxIter = 300;
Xparam.L = 300;
Xparam.k = 10;
Xparam.lamda = 0.001; Xparam.beta = 1.5; Xparam.alph = 0.1;
Xparam.dimD = nbits;

groundtruth = data.groundtruth;
traindata = data.train_data';
dbdata = data.db_data';
tstdata = data.test_data';

traindata = normalize(traindata);
dbdata = normalize(dbdata);
tstdata = normalize(tstdata);

m = 300;
n_anchors = m;
Ntrain = size(traindata,1);
rand('seed',1);
anchor = traindata(randsample(Ntrain, n_anchors),:);

Dis = EuDist2(traindata,anchor,0);
sigma = mean(min(Dis,[],2).^0.5);
clear Dis

traindata = exp(-EuDist2(traindata,anchor,0)/(2*sigma*sigma));
dbdata = exp(-EuDist2(dbdata,anchor,0)/(2*sigma*sigma));
tstdata = exp(-EuDist2(tstdata,anchor,0)/(2*sigma*sigma));

sampleM = mean(traindata,1);
tstdata = bsxfun(@minus, tstdata, sampleM);
traindata = bsxfun(@minus, traindata, sampleM);
dbdata = bsxfun(@minus, dbdata, sampleM);

[ R, eigVec, sample_mean] = trainOEH(traindata, Xparam);
B_db = compressOEH(dbdata, R, eigVec, sample_mean);
B_tst = compressOEH(tstdata, R, eigVec, sample_mean);

D_dist =  hammingDist(B_tst,B_db);
[r,p]= recall_precision(groundtruth, D_dist);
[mAP] = area_RP(r, p);
