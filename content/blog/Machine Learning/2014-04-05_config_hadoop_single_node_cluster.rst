Ubuntu Hadoop2.3.0 (Single-node) 单节点配置流程
#################################################

:tags: hadoop, mapreduce, big data
:summary: Hadoop课程的第一个小作业就是配置Hadoop并记录过程，刚好我有写博客的习惯，干脆写成博客。本文主要参考：《 `Setting hadoop 2.2.0 on ubuntu 12 lts <http://javatute.com/javatute/faces/post/hadoop/2014/setting-hadoop-2.2.0-on-ubuntu-12-lts.xhtml>`_ 》设置Hadoop单节点，做学习实验用。我有追求新东西的癖好，虽然要求配置1.x版本的Hadoop，但还是忍不住要配置最新的2.3.0。

	环境：VMWare10.0.0, Ubuntu 12.04, Hadoop 2.3.0.

.. contents:: 目录

准备工作
===========
Windows中下载软件
--------------------
下载并安装好虚拟机VMWare10.0.0。

下载 Ubuntu for ROS 开发版本，找到 `ubuntu12.04-ros-exbot-h2-140330 <http://blog.exbot.net/archives/702>`_ 并下载。这个是针对ROS的Ubuntu 12.04的定制版本，下载完后10分钟就能在虚拟机中安装好，并且里面已经附带了JDK8，对于没有安装Ubuntu的人还说是很方便的，官网有虚拟机安装教程。

下载 Hadoop 2.3.0 `Hadoop官方下载 <http://www.apache.org/dyn/closer.cgi/hadoop/core>`_ （我是从Hust镜像站点下的，很快搞定 `hadoop-2.3.0.tar.gz <http://mirrors.hust.edu.cn/apache/hadoop/core/hadoop-2.3.0/hadoop-2.3.0.tar.gz>`_ ）。

后面的步骤在虚拟机Ubuntu中进行。

安装JDK
---------
Ubuntu for ROS已经集成了JDK8，不需要自己安装，通过下面命令可以看到JDK路径(Thanks http://my.oschina.net/zarger/blog/120048)：

.. code-block:: ubuntu

	 update-alternatives --config java

显示结果类似：

	exbot@ubuntu:~$ update-alternatives --config java
	There is only one alternative in link group java: /usr/lib/jvm/java-8-oracle/jre/bin/java
	Nothing to configure.

结果中的 **/usr/lib/jvm/java-8-oracle** 就是需要记住的路径，后面配置JDK需要用到。

如果是其他版本的Ubuntu，需要自己安装JDK，下面是安装JDK8的命令：

.. code-block:: ubuntu

	sudo add-apt-repository ppa:webupd8team/java
	sudo apt-get update
	sudo apt-get install oracle-java8-installer

安装openssh-server
--------------------
执行下面命令即可：

.. code-block:: ubuntu

	sudo apt-get install openssh-server

添加新的组和用户名hduser:hadoop
------------------------------------
我直接用原组和用户名exbot:exbot，为了跟大多数人（网上）保持一致，还是新建一个组和用户名吧。

.. code-block:: ubuntu

	sudo addgroup hadoop
	sudo adduser --ingroup hadoop hduser
	sudo adduser hduser sudo

第1条命令用于创建一个名为hadoop的组；第2条命令用于向hadoop组添加一个名为hduser的用户，此时需要输入用户信息，记住密码即可，其他的随意。第3条看效果是将hduser加入sudo组。

现在登陆hduser用户，点击Ubuntu右上角的用户下拉菜单，选择hduser登陆。

.. note:: 直接用 ``su - hduser`` 可以在terminal内将环境切换用户到 *hduser*，但重开terminal还是会恢复原来的用户环境，还是重新登陆为hduser比较安逸。

配置SSH
---------
执行下面的命令：

.. code-block:: ubuntu

	ssh-keygen -t rsa
	cat $HOME/.ssh/id_rsa.pub >> $HOME/.ssh/authorized_keys

第1条命令用于生成一对RSA密钥，全部回车即可，生成的一对名为 *id_rsa* 的密钥存放在 *~/.ssh/* 下面。第2条命令用于将RSA密钥对的公钥写进本地SSH授权文件。

现在尝试SSH本机：

.. code-block:: ubuntu

	ssh localhost

会出现下面提示：

	The authenticity of host 'localhost (127.0.0.1)' can't be established.
	ECDSA key fingerprint is 8f:c9:65:4b:96:a0:6a:7f:73:4f:a6:bb:e8:53:c4:c5.
	Are you sure you want to continue connecting (yes/no)? 

输入 ``yes`` 回车即可。提示如下则正常：

	Welcome to Ubuntu 12.04.4 LTS (GNU/Linux 3.8.0-37-generic i686)
	  * Documentation:  https://help.ubuntu.com/

安装配置Hadoop
===============
解压hadoop
---------------------
把先前下载的 *hadoop-2.3.0.tar.gz* 拷贝到虚拟机Ubuntu的hduser用户home目录下，如果没有下载，直接在Ubuntu中打开firefox下载也行，中国用户就别依照老外的教程从外网用wget下载了，直接找国内镜像站点下载，瞬间搞定的事情。

打开terminal，用 ``ls`` 命令看看hadoop压缩包在不在，不在就是没拷过来：

.. code-block:: ubuntu

	hduser@ubuntu:~$ ls
	Desktop    Downloads         hadoop-2.3.0.tar.gz  Pictures  Templates
	Documents  examples.desktop  Music                Public    Videos

然后执行下面的命令：

.. code-block:: ubuntu

	sudo tar vxzf hadoop-2.3.0.tar.gz -C /usr/local
	cd /usr/local
	sudo mv hadoop-2.3.0 hadoop
	sudo chown -R hduser:hadoop hadoop

第1条命令将hadoop压缩包解压到 */usr/local* 路径下；第2条命令切换当前路径到 */usr/local* 路径；第3条命令将 *hadoop-2.3.0* 文件名重命名为 *hadoop*；第4条命令将 *hadoop* 文件的所有权设置为 hadoop 组的 hduser 用户。

.. note:: 第4条 *chown* 的条命令很重要，不更改所有权后面会遇到一系列权限问题！

设置Hadoop相关环境变量
--------------------------
gedit打开并编辑 *~/.bashrc* :

.. code-block:: ubuntu

	gedit ~/.bashrc

在弹出来的 *.bashrc* 文件的末尾添加下面的内容：

.. code-block:: perl

	#Hadoop variables
	export JAVA_HOME=/usr/lib/jvm/java-8-oracle
	export HADOOP_INSTALL=/usr/local/hadoop
	export PATH=$PATH:$HADOOP_INSTALL/bin
	export PATH=$PATH:$HADOOP_INSTALL/sbin
	export HADOOP_MAPRED_HOME=$HADOOP_INSTALL
	export HADOOP_COMMON_HOME=$HADOOP_INSTALL
	export HADOOP_HDFS_HOME=$HADOOP_INSTALL
	export YARN_HOME=$HADOOP_INSTALL

其中 *JAVA_HOME* 就是你之前查到的系统中JDK的路径。

.. tip:: *~/.bashrc* 文件在你每次打开terminal的时候都会自动执行，这里就是在打开terminal后，设置Hadoop相关变量，让terminal知道执行hadoop命令的时候应该从哪些路径查找。如果不设置，就会像大多数教程一样自己敲一大串路径去指明hadoop命令的位置。

.. note:: 修改 *.bashrc* 后，需要重新打开terminal，或者 ``source ~/.bashrc`` 才会生效。

修改Hadoop配置文件
-------------------
主要修改下面几个文件：

* hadoop-env.sh
* core-site.xml
* yarn-site.xml
* mapred-site.xml
* hdfs-site.xml

它们被放置在 */usr/local/hadoop/etc/hadoop* 路径下。打开terminal，执行命令 ``cd /usr/local/hadoop/etc/hadoop`` 来到对应路径。

hadoop-env.sh
++++++++++++++++
用 ``gedit hadoop-env.sh`` 命令修改环境脚本文件，找到 *export JAVA_HOME=${JAVA_HOME}* 一行，将 **${JAVA_HOME}** 改为自己的JDK的路径，这里是 */usr/lib/jvm/java-8-oracle*。

.. note:: 一定要改，虽然之前 *.bashrc* 设置了 *JAVA_HOME* 变量，但是当远程执行脚本的时候， *.bashrc* 并不会生效。

下面测试一下，不管在哪个路径下，用 ``hadoop version`` 命令测试hadoop环境，都应该能测试成功。如果测试成功，则会显示下面的内容：

.. code-block:: ubuntu

	hduser@ubuntu:/usr/local/hadoop/etc/hadoop$ hadoop version
	Hadoop 2.3.0
	Subversion http://svn.apache.org/repos/asf/hadoop/common -r 1567123
	Compiled by jenkins on 2014-02-11T13:40Z
	Compiled with protoc 2.5.0
	From source with checksum dfe46336fbc6a044bc124392ec06b85
	This command was run using /usr/local/hadoop/share/hadoop/common/hadoop-common-2.3.0.jar

core-site.xml 
+++++++++++++++++++++++
用 ``gedit core-site.xml`` 命令打开文件，在 *<configuration>* 标签中间添加：

.. code-block:: xml

	<property>
	   <name>fs.default.name</name>
	   <value>hdfs://localhost:9000</value>
	</property>


hadoop environment variables

yarn-site.xml
++++++++++++++++
用 ``gedit yarn-site.xml`` 命令打开文件，在 *<configuration>* 标签中间添加：

.. code-block:: xml

	<property>
	   <name>yarn.nodemanager.aux-services</name>
	   <value>mapreduce_shuffle</value>
	</property>
	<property>
	   <name>yarn.nodemanager.aux-services.mapreduce.shuffle.class</name>
	   <value>org.apache.hadoop.mapred.ShuffleHandler</value>
	</property>

mapred-site.xml
++++++++++++++++
用 ``cp mapred-site.xml.template mapred-site.xml`` 命令将 *mapred-site.xml* 模板文件拷贝为 *mapred-site.xml* 文件；然后再用 ``gedit mapred-site.xml`` 命令打开文件，在 *<configuration>* 标签中间添加：

.. code-block:: xml

	<property>
	   <name>mapreduce.framework.name</name>
	   <value>yarn</value>
	</property>

hdfs-site.xml
++++++++++++++++
用 ``gedit hdfs-site.xml`` 命令打开文件，在 *<configuration>* 标签中间添加：

.. code-block:: xml

	<property>
	   <name>dfs.replication</name>
	   <value>1</value>
	 </property>
	 <property>
	   <name>dfs.namenode.name.dir</name>
	   <value>file:/home/hduser/mydata/hdfs/namenode</value>
	 </property>
	 <property>
	   <name>dfs.datanode.data.dir</name>
	   <value>file:/home/hduser/mydata/hdfs/datanode</value>
	 </property>

文件中设置了两个文件夹路径，这里需要执行下面的命令创建这两个文件夹：

.. code-block:: ubuntu

	mkdir -p mydata/hdfs/namenode
	mkdir -p mydata/hdfs/datanode

清理
++++++
``ls`` 命令能看到刚才gedit编辑的文件都有个带 *~* 的副本，强迫症表示需要用 ``rm -rf *~`` 清理一下看着舒服。

试运行
----------
Format namenode
++++++++++++++++
在测试前使用下面的命令Format namenode，只需要执行一次。

.. code-block:: ubuntu

	hdfs namenode -format

如果正常，结尾显示类似：

.. code-block:: ubuntu

	14/04/06 22:11:07 INFO util.ExitUtil: Exiting with status 0
	14/04/06 22:11:07 INFO namenode.NameNode: SHUTDOWN_MSG: 
	/************************************************************
	SHUTDOWN_MSG: Shutting down NameNode at ubuntu/127.0.1.1
	************************************************************/

启动服务
+++++++++++
用下面的命令启动hadoop服务：

.. code-block:: ubuntu

	start-dfs.sh
	start-yarn.sh

每条命令都会启动一些后台进程，需要稍许等待。启动完成后，输入命令 ``jps`` 查看是否正常启动，如果正常，显示如下：

.. code-block:: ubuntu

	hduser@ubuntu:/usr/local/hadoop/etc/hadoop$ jps
	5321 NodeManager
	4474 NameNode
	5387 Jps
	5117 ResourceManager
	4957 SecondaryNameNode
	4671 DataNode

.. note:: 虽然用 ``start-all.sh`` 也能代替上面两个脚本，但是官方里面写了推荐不要用 ``start-all.sh`` 来启动。

测试
=======
测试前先确保Hadoop服务已经启动。

Sample example
----------------
不管在哪个路径下，执行下面的命令进行测试：

.. code-block:: ubuntu

	hadoop jar /usr/local/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.3.0.jar pi 2 5

正常启动，显示如下：

.. code-block:: ubuntu

	hduser@ubuntu:~$ hadoop jar /usr/local/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.3.0.jar pi 2 5
	Number of Maps  = 2
	Samples per Map = 5
	Wrote input for Map #0
	Wrote input for Map #1
	Starting Job
	14/04/06 22:25:56 INFO client.RMProxy: Connecting to ResourceManager at /0.0.0.0:8032
	14/04/06 22:25:56 INFO input.FileInputFormat: Total input paths to process : 2
	14/04/06 22:25:56 INFO mapreduce.JobSubmitter: number of splits:2
	14/04/06 22:25:57 INFO mapreduce.JobSubmitter: Submitting tokens for job: job_1396794116236_0001
	......

WordCount example
-------------------
WordCount的测试过程主要参考《 `Running Hadoop on Ubuntu Linux (Single-Node Cluster) <http://www.michael-noll.com/tutorials/running-hadoop-on-ubuntu-linux-single-node-cluster/>`_ 》，虽然命令和过程不一样，但原理都一样。

.. note:: 一些老版本的用户命令如 ``hadoop fs ...`` 之类已经不推荐使用，由新的命令 ``hdfs dfs ...`` 代替。具体用户指令可以参考官方文档 `Hadoop Commands Reference <http://hadoop.apache.org/docs/r2.3.0/hadoop-project-dist/hadoop-common/CommandsManual.html>`_ 和 `File System Shell <http://hadoop.apache.org/docs/r2.3.0/hadoop-project-dist/hadoop-common/FileSystemShell.html>`_ 。

用 ``mkdir -p ~/tmp/wordtest`` 命令在用户的home路径下新建 *~/tmp/wordtest* 文件夹，下载UTF-8格式的测试用数据文件放到这个文件夹下（我用的是朋友给的全英文数据文件P00-1001.txt, P00-1002.txt, P00-1003.txt）。

用下面的命令，将本地文件拷贝到hadoop HDFS下：

.. code-block:: ubuntu

	hdfs dfs -copyFromLocal /home/hduser/tmp/wordtest/ /user/hduser/input

用命令 ``hdfs dfs -ls input`` 可以看到拷贝的内容：

.. code-block:: ubuntu

	hduser@ubuntu:~$ hdfs dfs -ls input
	Found 4 items
	-rw-r--r--   1 hduser supergroup      35071 2014-04-06 23:21 input/P00-1001.txt
	-rw-r--r--   1 hduser supergroup      28735 2014-04-06 23:21 input/P00-1002.txt
	-rw-r--r--   1 hduser supergroup       1400 2014-04-06 23:21 input/P00-1003.txt
	drwxr-xr-x   - hduser supergroup          0 2014-04-07 21:17 input/wordtest

下面执行WordCount example任务：

.. code-block:: ubuntu

	hadoop jar /usr/local/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.3.0.jar wordcount /user/hduser/input /user/hduser/output

该命令就是让hadoop执行指定路径的jar包，即官方的 *hadoop-mapreduce-examples-2.3.0.jar* 运行里面的wordcount程序；数据源为之前拷贝到HDFS的 */user/hduser/input* 下的那些文件，输出结果到 */user/hduser/output* 。

运行完后，用命令 ``hdfs dfs -ls /user/hduser/output`` 看看输出的结果：

.. code-block:: ubuntu

	hduser@ubuntu:~$ hdfs dfs -ls /user/hduser/output
	Found 2 items
	-rw-r--r--   1 hduser supergroup          0 2014-04-06 23:24 /user/hduser/output/_SUCCESS
	-rw-r--r--   1 hduser supergroup      35210 2014-04-06 23:24 /user/hduser/output/part-r-00000

使用命令 ``hdfs dfs -cat /user/hduser/output/part-r-00000`` 可以查看文件里面的内容：

.. code-block:: ubuntu

	......
	witnessed	1
	word	8
	word,	5
	word.	2
	words	10
	words)	1
	words,	3
	work	5
	work,	2
	work-	1
	working	2
	works	1
	world	1
	world's	1
	worth	1
	would	8
	......

web interface
--------------------
通过Hadoop的默认Web界面地址可以获得一些内部信息，打开fierfox，输入 ``http://localhost:50070/`` 即可。
