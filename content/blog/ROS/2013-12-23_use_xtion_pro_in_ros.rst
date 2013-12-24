Use ASUS Xtion pro (no RGB) in ROS
########################################

:tags: turtlebot, ros, xtion
:summary: 本文介绍如何在turtlebot上应用ASUS Xtion pro (no RGB)，注意Xtion pro (no RGB)和Xtion pro Live (RGB-D)是不同的两款深度摄像头，前者缺少一个RGB摄像头，无色彩信息，而有者是带RGB的深度摄像头。Xtion pro在ROS圈里似乎已经没有什么市场了，网络上没看到有人讨论它在ROS里面的驱动问题。我先前就是把这名字弄混了，一不小心坑别人买了Xtion pro，在这里就解决一下它的驱动问题。

	环境：ROS Hydro，Xtion pro (no RGB)

.. contents:: 目录

前言
=====
《 `Fix 3dsensor.launch兼容Kinect和ASUS Xtion pro Live <{filename}2013-10-29_fix_kinect_xtion_pro_with_3dsensor.rst>`_ 》一文介绍了如何在Groovy中解决Kinect和Xtion pro Live两款RGB-D摄像头的驱动问题。《 `给自制Turtlebot装上ASUS Xtion pro Live摄像头 <{filename}2013-12-18_use_xtion_pro_live_in_trutlebot.rst>`_ 》一文介绍了如何在Hydro中解决Xtion pro Live的驱动问题，本文与之类似，在Hydro中解决Xtion pro的驱动问题。

新版Xtion pro Live需要用openni2作驱动，在ROS里面相关的封装对应两个包： *openni2_camera* 和 *openni2_launch*。理论上Xtion pro也可以用 *openni2_camera* 来驱动，但是实践过程中会出问题。

Fix Driver
==========
首先确保ROS Hydro环境已经配置好。

安装openni2_launch包
---------------------
ROS里openni2驱动的封装包包含两个部分，一个是openni2_camera，另一个是openni2_launch。openni2_camera需要修改源码，因此采用源码编译的方式，而openni2_launch没什么需要编译的源码，直接从远程库拖下来（由于依赖关系，openni2_camera也会被顺带拖下来）。

.. code-block:: ubuntu

	sudo apt-get install ros-hydro-openni2-launch

后面的步骤，就是为编译openni2_camera而做的了。
	
新建catkin工作空间
-------------------
如果已经有自己的catkin工作空间则跳过，否则新建catkin工作空间：

.. code-block:: ubuntu

	mkdir -p ~/catkin_ws/src
	cd ~/catkin_ws/src
	catkin_init_workspace
	cd ~/catkin_ws/
	catkin_make
	echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc

对应解释参照《`配置ROS工作空间catkin+rosbuild <{filename}2013-12-20_overlay_catkin_and_rosbuild.rst>`_》。关闭所有的terminal在重新打开，使环境变量生效。

下载openni2_camera源码
-----------------------
.. code-block:: ubuntu

	cd ~/catkin_ws/src
	git clone git@github.com:ros-drivers/openni2_camera.git

如果没有安装git，先用 ``sudo apt-get install git`` 命令安装git。然后进入catkin工作空间的包目录下，将openni2_camera的源码下载下来。

修改源码
---------
.. code-block:: ubuntu

	cd ~/catkin_ws/src/openni2_camera/src
	gedit openni2_driver.cpp

进入到openni2_camera的源码目录，编辑openni2_driver.cpp文件。找到 ``OpenNI2Driver::applyConfigToOpenNIDevice()`` 函数，在其内部找到如下三行：

.. code-block:: cpp

	setIRVideoMode(ir_video_mode_);
	setColorVideoMode(color_video_mode_);
	setDepthVideoMode(depth_video_mode_);

将其替换为：

.. code-block:: cpp

	if (device_->hasIRSensor()) setIRVideoMode(ir_video_mode_);
	if (device_->hasColorSensor()) setColorVideoMode(color_video_mode_);
	if (device_->hasDepthSensor()) setDepthVideoMode(depth_video_mode_);

保存并退出。

编译openni2_camera
-------------------
.. code-block:: ubuntu

	cd ~/catkin_ws
	catkin_make

进入到catkin工作空间根目录，编译所有包。

测试
-----
可以直接使用openni2_launch里的文件进行测试。

.. code-block:: ubuntu

	roslaunch openni2_launch openni2.launch 
	rosrun rqt_image_view rqt_image_view

第一条命令启动openni2.launch脚本，如果没有红色的Error出现，则正常。第二条语句打开ROS图像查看的GUI，在image_view GUI里面选择 */camera/depth/image* 就能看到下图所示的深度图像了：

.. image:: {image}depth.jpg
    :alt: Depth Image

至此，驱动部分已经Fix完成。Xtion pro与Xtion pro Live相比，体积重量等等都一样，只是少了个RGB摄像头，而RGB摄像头对大多数人来说是很重要的。可能是Xtion pro已经被抛弃了吧，导致其驱动问题无人问津。ROS里面 *openni2_** 的开发者似乎都没考虑用它来驱动Xtion pro，或许说这就是一个bug。

将Xtion pro (no RGB)用在turtlebot还会有一些小问题的，如何Fix 3dsensor.launch，参考《 `给自制Turtlebot装上ASUS Xtion pro Live摄像头 <{filename}2013-12-18_use_xtion_pro_live_in_trutlebot.rst>`_ 》，其他的小问题有待解决，但建议还是直接用Xtion pro Live合算。

