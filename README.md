

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



>需要注意的是   
1.K-means最小化的是重构误差E，直到收敛，所以收敛后得到的E的误差并不一定是全局最优的，解决的办法就是多次初始化起点，得到多个结果，从中找出最优的。    
2.K-means理论上有可能在俩个集合中来回震荡，但是在实际的情况中却从未发生过，所以不必担心是否收敛的问题。

> k均值的局限性  
> 1.假定所有样本发生的概率相等（解决办法 GMM）  
> 2.将数据点硬分配给集群可能会导致数据点的微小干扰将其转移到另一个集群（解决办法 GMM）   
> 3.对于K值不固定的聚类不能适用（解决办法Hierarchical clustering层次聚类）
> 4.对离群点敏感（解决办法：选择一个更加鲁棒的损失函数）
> 5.在非凸集合中效果不太好（解决办法：Spectral clustering谱聚类）


- ### K-medoids（k均值聚类一样）
> 计算距离采用汉密尔顿距离

- ### Gaussian Mixture Model（高斯混合模型）
> 思想：假设样本的分布服由多个高斯分布按一定的比例组合而成（也就是混合高斯分布），目标就是寻找k个高斯分布，以及k个高斯分布对应所占的k个权重（权重和为1），使得整体的概率分布函数最大。  
[公式推导](http://blog.csdn.net/u011177305/article/details/51251153)

> 难点：  
> 1.如何选择初始化的值（k，mu，sigmas）k值的初始化较难，mu均值可以用kmean算得的结果，sigmas可以用kmeans分得的结果求得的方差作为初始化。   
> 2.Kmeans是GMM退化后的结果，GMM中的响应度变成{0,1}，协方差矩阵变成 样本方差 / 样本格式，均值为响应度为1的样本的均值。

- ### Hierarchical  Clustering分层聚类
> 俩种方式：1.聚类法2.拆分法  

> 思想：以聚类法为例：  
> 找到两组相似度最高的样本合并为1组，依次聚合到所需的组数  

> 衡量俩组样本之间的相似度的函数  
> 1. 最小距离  
> 2. 最大距离
> 3. 平均距离 
![相似度函数](http://ot9oq7g6m.bkt.clouddn.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20180312220817.png)   

[分层聚类的应用](http://www.cs.umd.edu/hcil/hce/examples/application_examples.html)

- ### 基于密度的聚类算法 - DBSCAN
> 思想：基于“所有聚合的中心密度大，边缘密度小。密度在大于某一个阈值则归为一个集群，密度小于某一集群则归为噪声”的假设

> 概念和算法如下
![DBSCAN](http://ot9oq7g6m.bkt.clouddn.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20180313110058.png)
![DBSCAN](http://ot9oq7g6m.bkt.clouddn.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20180313110111.png)
![DBSCAN](http://ot9oq7g6m.bkt.clouddn.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20180313110124.png)

> 优点：  
> 1.不用自己设定聚类的个数  
> 2.离群点的影响小  
> 3.可以是任意聚类形状（不像kmeans是凸的）  
> 缺点：  
> 1.阈值的设定困难  
> 2.对于密度变化巨大的数据集效果差  

- ### 基于密度的聚类算法 - mean shift
> 思想：随机初始化一个点作为中心，选择一个半径求周围所有点的质心，并将中心朝着质心的方向飘移动（也就是朝着密度最大的方向移动也就是mean shift的含义），直到最后中心的位置在一个阈值很小的范围内固定，迭代停止。如果俩个中心的距离小于一定的范围则归为一类。，分类的依据是每选择移动过程中遍历最多的那一类。  

[参考链接](http://blog.csdn.net/yanwande/article/details/50387735)
![示意图](http://img.blog.csdn.net/20151223162336127)