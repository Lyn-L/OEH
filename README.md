# Ordinal Embedding Hashing (OEH)

Paper : Towards Optimal Binary Code Learning via Ordinal Embedding  <br />
Author : Hong Liu, Rongrong Ji, Yongjian Wu, Wei Liu  <br />
Published in AAAI 2016  <br />
Contact : lynnliu.xmu@gmail.com  <br />

Unfortunately, the original code cannot be shared, due to the Tencent Youtu Lab's IP policy.  <br /> 
Instead, another MATLAB implementation of OEH has been released, which details are similar to the original version, but it would be still useful and gives similar results.

This package contains cleaned up codes for the AAAI paper, including:  <br />
test_OEH.m: the demo test codes on LabelMe dataset <br />
test_OEH_cifar.m: the demo test codes on CIFAR10 (dataset can be download from https://pan.baidu.com/s/1o877VXC) <br />
trainOEH.m: function to train the OEH model  <br />
constructure_data.m/constructure_data_cifar.m: function to construct the data set  <br />
compressOEH.m: function to generate the hash code  <br />
LabelMe.mat: a random subset of the original LabelMe dataset
