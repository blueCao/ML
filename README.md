

# Dimension Reduction（降维）
- ### KL(PCA)主成分分析降维
> 将所有数据的最终的值看成是由一组互相正交的向量集以及向量对应的系数相乘求和而来。所以主成分分析的目的就是找到一组这样的正交向量，求得对应的系数。降维的目的就是找到前k组重要程度最高的基向量，使得与降维前的平方损失最小。而变换矩阵的求解由数学证明可知，是原始数据协方差矩阵的前k大特征值对应的特征向量。    

[数学证明参考链接](https://github.com/blueCao/ML/tree/master/KL-PCA)

- KPCA（核函数主成分分析）
> 

- ### MDS（multiple dimension scaling）多维尺度分析
> 利用欧式距离矩阵 求解 所需矩阵 B=X'X，与KL（PCA）的(X-E(X))'(X-E(X))不同。
后续步骤和KL变换同理，进行特征值和特征向量的求解，再利用前k大的特征值对应的特征向量求解将维后的向量.

[公式推导参考链接](http://blog.csdn.net/Dark_Scope/article/details/53229427)  


- ### Isomap（流形学习-等距特征映射）
> 试图在多维度数据中的找到一种流行结构来降维。与MDS中的思想一致，不同的是,距离采用的是测地距离，而不是MDS中的欧氏距离。其中测地距离的求解过程通过构造邻接图G、再通过G计算任意两点之间的距离，得到距离矩阵D，在用MDS算法降维。

[参考链接](http://blog.csdn.net/zdy0_2004/article/details/51367517)  
[matlab代码](http://web.mit.edu/cocosci/isomap/code/Isomap.m)  
[绘图示例](http://www.numerical-tours.com/matlab/shapes_7_isomap/)

- ### LLE(local linear embeddings)局部线性嵌入
> 算法与Isomap的思想类似，但是Isomap在数据量巨大维度高时，求解最短路径时需要大量计算时间，而LLE算法在求解时，采用局部线性的假设，在最小化均方误差的总体目标下，计算系数矩阵W，再通过计算特征值、特征向量得到前k大的特征向量，进而降维  

[示例代码](https://cs.nyu.edu/~roweis/lle/)  
[原理、公式推导](https://www.cnblogs.com/pinard/p/6266408.html?utm_source=itdadao&utm_medium=referral)  


# Unsupervised Learning--Clustering（非监督学习--聚类模型）
- ### K-means（K均值聚类）
> 需要优化距离和损失使得最小，与通用的ER算法类似。  
E step：求得期望（这一轮已经分好类的样本的重心作为新的重心）  
M step：最小化（使得对应当前的重心，需要做新一轮分类使得损失再降低。  

