clear all;clc;

nbits = 64;

data = construct_dataset(1000);

Xparam.nbits = nbits;
Xparam.maxIter = 300;
Xparam.L = 300;
Xparam.beta = 1;
Xparam.lamda = 0.01;
Xparam.alph = 0.1;
Xparam.k = 10;
Xparam.dimD = 64;
   
groundtruth = data.groundtruth;
traindata = data.train_data';
dbdata = data.db_data';
tstdata = data.test_data';

[ R, eigVec, sample_mean] = trainOEH(traindata, Xparam);

B_db = compressOEH(dbdata, R, eigVec, sample_mean);

B_tst = compressOEH(tstdata, R, eigVec, sample_mean);


D_dist =  hammingDist(B_tst,B_db);
[r,p]= recall_precision(groundtruth, D_dist);
[mAP] = area_RP(r, p);
