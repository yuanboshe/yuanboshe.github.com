用Kinect玩ExBot XI移动机器人平台
######################################

:tags: exbotxi, ros, kinect
:summary: ExBot XI原生支持ASUS Xtion pro live摄像头，但是用Kinect也能玩，只需要做稍微的参数设置即可。因为驱动方面的问题，Kinect可能会出现卡顿现象，实际效果不如ASUS Xtion pro live摄像头。

	环境：Ubuntu for ROS 开发版 (h2), Kinect摄像头.

.. contents:: 目录

准备工作
=========

Ubuntu for ROS安装与设置
----------------------------
安装好Ubuntu for ROS开发版(h2)，参考 `Ubuntu for ROS集合`_ 的相关说明，后面的例子以虚拟机中安装的Ubuntu for ROS为例介绍，在裸机中安装的Ubuntu for ROS操作一样。

安装好后启动虚拟机，打开一个terminal窗口，输入命令 ``echo "export RGBD_CAMERA=kinect" >> ~/.bashrc`` 并回车，然后关闭窗口，如下图所示：

.. image:: {image}config1.jpg
	:alt: config1

.. note:: 本节的设置工作只需要在新安装的系统中设置一次，不必每次开机后重新设置。exbot_xi开发包默认使用ASUS Xtion pro live摄像头，这一步是为了告诉后面的程序使用何种摄像头驱动，万一这一步设置错了，可以使用 ``gedit ~/.bashrc`` 命令打开 *.bashrc* 文件，然后拖到底部修改/删除对应的行即可。

连接Kinect摄像头
------------------
接上Kinect的外接电源，将数据USB口插入电脑，会在虚拟机右下角多出一个名为 *Microsoft Xbox NUI Motor* 的USB形状图标，如下图所示：

.. image:: {image}vm1.jpg
	:alt: vm

右键图标 -> 连接，使图标变亮，即可将Kinect设备连入虚拟机。这时旁边又会多出一个名为 *Microsoft Xbox NUI Camera* 的照相机形状图标，如下图所示：

.. image:: {image}vm2.jpg
	:alt: vm

同样右键图标 -> 连接，使图标变亮，即可将摄像头设备连入虚拟机，完成Kinect的连入操作。

测试
------
打开3个terminal窗口，分别输入下面的3条命令并回车：

.. code-block:: ubuntu

	roscore
	roslaunch freenect_launch freenect.launch
	rosrun rqt_image_view rqt_image_view

如果没有红色文字出现或者没有意外跳出，则运行正常。在输入最后一条命令后会启动 *rqt_image_view* 工具，如下图所示：

.. image:: {image}u1.jpg
	:alt: ubuntu

然后从窗口的下拉菜单中选择 */camera/depth/image* ，能正常显示深度图像，则摄像头驱动启动正常，如下图所示：

.. image:: {image}u2.jpg
	:alt: ubuntu

同样，选择 */camera/rgb/image_raw* 将会显示彩色图像。如果测试正常，则在terminal窗口中使用 **ctrl + z** 组合键来结束掉所有程序。

exbot_xi开发包例程
===================

exbot_xi开发包的更新
---------------------
我们会不定期更新exbot_xi开发包，并同步在GitHub上，凡是装有Ubuntu for ROS开发版的系统很容易更新exbot_xi开发包。打开terminal窗口，输入下面的命令即可对开发包进行更新：

.. code-block:: ubuntu

	cd ~/catkin_ws/src/exbot_xi
	git pull

如果出现 *Already up-to-date.* 的提示，则更新成功。如果对包有所修改，可能有些情况下无法更新，那么可以使用 ``git reset --hard`` reset一下，然后再使用 ``git pull`` 更新。

使用rviz观察点云图像（3D重构）
------------------------------
如果使用仿真机器人，则打开4个terminal窗口，分别输入下面4条命令并回车：

.. code-block:: ubuntu

	roscore
	roslaunch exbotxi_bringup fake_exbotxi.launch 
	roslaunch exbotxi_bringup 3dsensor.launch 
	roslaunch exbotxi_rviz view_robot.launch
	
第1条命令用于启动ROS master；第2条命令用于启动ExBot XI仿真机器人；第3条命令用于启动RGBD摄像头；第4条命令用于启动ROS的可视化工具rviz，并加载view_robot相关配置。

.. tip:: 如果是使用ExBot XI平台，则只需要将第2条命令换成 ``roslaunch exbotxi_bringup minimal.launch`` 即可。

.. image:: {image}s1.jpg
	:alt: sample

在rviz左边的 *Displays* 选项栏中勾选 **LaserScan** ，即可显示RGBD摄像头模拟激光雷达的画面，如下图所示：

.. image:: {image}s2.jpg
	:alt: sample

在rviz左边的 *Displays* 选项栏中勾选 **Registered PointCloud** ，即可进行3D点云重构显示，如下图所示：

.. image:: {image}s3.jpg
	:alt: sample

gmapping构图实验 (SLAM mapping)
------------------------------------
如果使用仿真机器人，则打开4个terminal窗口，分别输入下面4条命令并回车：

.. code-block:: ubuntu

	roscore
	roslaunch exbotxi_bringup fake_exbotxi.launch 
	roslaunch exbotxi_bringup 3dsensor.launch 
	roslaunch exbotxi_nav gmapping_demo.launch
	roslaunch exbotxi_rviz view_navigation.launch 

第1条命令用于启动ROS master；第2条命令用于启动ExBot XI仿真机器人；第3条命令用于启动RGBD摄像头；第4条命令用于启动gmapping算法包，以及相关配置；第5条命令用于启动ROS的可视化工具rviz，并加载view_navigation相关配置。

.. tip:: 如果是使用ExBot XI平台，则只需要将第2条命令换成 ``roslaunch exbotxi_bringup minimal.launch`` 即可。

.. image:: {image}s4.jpg
	:alt: sample
	
Kinect模拟激光雷达构图效果如上图所示，对于地图的详细解释可以参考ROS wiki中gmapping对应部分。在这种2D SLAM实验中，由于通过RGBD摄像头模拟激光雷达导致2D点云数据扇角太小，而且没有精确的位姿数据做参考，会造成构图效果差。而且Kinect在ROS中采集数据时有卡顿，数据配准也不太精确，效果会略差于ASUS Xtion pro live摄像头。

在成功运行gmapping后，可以新开一个terminal窗口，使用下面的命令启动键盘控制程序：

.. code-block:: ubuntu

	roslaunch exbotxi_teleop keyboard_teleop.launch

效果如下图：

.. image:: {image}s5.jpg
	:alt: sample

如果希望保存构建好的地图，在任意时刻开启一个新的terminal窗口，使用命令 ``rosrun map_server map_saver -f ~/my_map`` 即可将当时构建好的地图保存在 *~/my_map.pgm* 文件里。使用命令 ``eog ~/my_map.pgm`` 可以以图片形式查看地图。

.. _Ubuntu for ROS集合: http://blog.exbot.net/archives/702
