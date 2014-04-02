TurtleBot笔记本端ROS环境配置
####################################

:tags: turtlebot, ros
:summary: 本文记录了为TurtleBot上的笔记本配置软环境的流程。笔记本操作系统为Windows7，通过虚拟机VMWare安装Ubuntu，在Ubuntu中运行ROS主控。通过虚拟机安装Ubuntu的好处就是Windows和Ubuntu可以共存，有些驱动或者库只有Windows版本（可以通过win_ros将消息转换为ROS标准的消息，与Ubuntu网络互联），也可能你需要使用Windows环境干点别的，与官网的做法对比就是节约了一台PC。当然，缺点就是跑虚拟机要求笔记本配置不至于太过时，内存最好大于4G。

	环境：Windows7 x64, VMWare Workstation 10.0.0, Ubuntu 12.04 i386, ROS Hydro.

.. contents:: 目录

准备工作
============
请确保笔记本装有Windows7系统，并保证网络状况良好。主流软件的安装流程就不介绍了，只说注意事项。

安装虚拟机
-------------
本文使用的是VMWare Workstation 10.0.0。使用哪款虚拟机软件，什么版本的，没有太大影响，一般的虚拟机功能都差不多。

安装Ubuntu
------------
本文使用的是Ubuntu 12.04 i386。在虚拟机中装Ubuntu步骤很简单，只是自动安装过程耗时长，慢慢等待吧。

.. warning:: 如果是使用iRobot Create底盘，最好不要使用Ubuntu 13.04。虽然ROS Hydro支持Ubuntu 13.04 (Raring)，但是该版Ubuntu串口相关软件有所更新，导致turtlebot程序在连接iRobot Create的时候会出现一个bug，后面的博文会描述这个bug。

.. note:: 下载Ubuntu的时候，i386表示32位的Ubuntu系统，amd64表示64位Ubuntu系统。64位的Ubuntu需要CPU的支持，虚拟机可能会提示你修改BIOS等，直接安装32位的Ubuntu省心。另外，不同的Ubuntu版本对应的ROS远程源（软件仓库）也不一样，这点在ROS安装的过程中要注意。

Ubuntu安装好后先更新一下，打开terminal，运行更新命令：

.. code-block:: ubuntu

    sudo apt-get update

.. note:: （在Ubuntu 13.04中）可能会出现下面的更新问题：

	::

		W: Failed to fetch gzip:/var/lib/apt/lists/partial/us.archive.ubuntu.com_ubuntu_dists_raring_universe_binary-i386_Packages Hash Sum mismatch
		E: Some index files failed to download. They have been ignored, or old ones used instead.

	运行 ``sudo rm /var/lib/apt/lists/partial -r`` 命令将目录 */var/lib/apt/lists/partial* 下的所有文件清除掉，然后再 ``sudo apt-get update`` 即可。

ROS
=========
与时俱进，本文安装最新版ROS: Hydro。Refer to [Ubuntu_install_of_ROS_Hydro]_

配置更新源
-----------
Ubuntu 12.04 (Precise):

.. code-block:: ubuntu

	sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu precise main" > /etc/apt/sources.list.d/ros-latest.list'
	
.. note:: 这个更新源是Ubuntu 12.04 (Precise)的更新源，如果是其他版本的Ubuntu要使用不同的更新源。更新源只与Ubuntu版本相关，与ROS版本无关。目前Hydro只支持Ubuntu 12.04 (Precise), Ubuntu 12.10 (Quantal), Ubuntu 13.04 (Raring)三种版本的Ubuntu。

设置秘钥
---------
.. code-block:: ubuntu

    wget http://packages.ros.org/ros.key -O - | sudo apt-key add -

更新软件
----------
.. code-block:: ubuntu

    sudo apt-get update

安装ROS包
--------------
ROS目前主要有如下3种配置：

=======================  ===========================================================================================
配置名                   包含功能包
=======================  ===========================================================================================
ros-hydro-desktop-full   ROS, rqt, rviz, robot-generic libraries, 2D/3D simulators, navigation and 2D/3D perception
ros-hydro-desktop        ROS, rqt, rviz, and robot-generic libraries
ros-hydro-ros-base       ROS package, build, and communication libraries. No GUI tools.
=======================  ===========================================================================================

3种配置方案，功能包依次精简。官网推荐第一种全功能的配置，如果不缺空间就第一种吧（新装的Ubuntu有792个包，2441M资源要下载安装，更新速度因网络状况而异，我这边网络状况不好，机器更新了10个小时还没完成）：

.. code-block:: ubuntu

    sudo apt-get install ros-hydro-desktop-full

可以用 ``apt-cache search ros-hydro`` 命令查看还有哪些包可以装。

.. tip:: 如果出现如下问题，可能是网络出现问题临时下载不了某个包，重新运行 ``sudo apt-get update`` 再安装可能问题就解决了，实在不行就注释掉连不上的源吧。``update`` 或者是 ``install`` 使用 ``--fix-missing`` 参数可以节约再次更新的时间。

	::
	
		Failed to fetch http://us.archive.ubuntu.com/ubuntu/pool/main/t/texlive-base/texlive-latex-base-doc_2012.20120611-5_all.deb Connection failed [IP: 91.189.91.13 80]
		E: Unable to fetch some archives, maybe run apt-get update or try with --fix-missing?

初始化rosdep
---------------
.. code-block:: ubuntu

    sudo rosdep init
    rosdep update

设置ROS环境随Terminal启动而生效
--------------------------------
.. code-block:: ubuntu

    echo "source /opt/ros/hydro/setup.bash" >> ~/.bashrc
    source ~/.bashrc

测试
-----
此时运行命令 ``roscore`` 如果能看到类似下面的信息，说明ROS master正常运行：

::

	started roslaunch server http://ubuntu:58411/
	ros_comm version 1.9.50


	SUMMARY
	========

	PARAMETERS
	 * /rosdistro
	 * /rosversion

	NODES

	auto-starting new master
	process[master]: started with pid [10369]
	ROS_MASTER_URI=http://ubuntu:11311/

	setting /run_id to 1994c68e-66e8-11e3-9039-000c29c4ac2c
	process[rosout-1]: started with pid [10382]
	started core service [/rosout]

TurtleBot
====================
我安装的是hydro版本，请安装与ROS版本对应的turtlebot包。Refer to [turtlebot_installation]_

安装turtlebot功能包
----------------------
本人使用irobot create底盘，就不需要安装kobuki的功能包了。使用下面的命令进行安装（100个包，66.8MB，二十分钟左右就能装好）：

.. code-block:: ubuntu

	sudo apt-get install ros-hydro-turtlebot ros-hydro-turtlebot-apps ros-hydro-turtlebot-viz ros-hydro-turtlebot-simulator

.. note:: 在安装过程中因网络状况可能还会出现 *Failed to fetch* 的问题，同样跟之前一样的解决方案。装好后最好重启一下Ubuntu，否则可能会有一些意料之外的错误信息。

测试
-----
试着执行下面的命令：

.. code-block:: ubuntu

	roslaunch turtlebot_bringup minimal.launch 

如果出现类似下面的信息，并且没有报错，说明安装完好：

::

	started roslaunch server http://ubuntu:58100/

	SUMMARY
	========

	PARAMETERS
	 * /bumper2pointcloud/pointcloud_radius
	 * /cmd_vel_mux/yaml_cfg_file
	 * /diagnostic_aggregator/analyzers/input_ports/contains
	 * /diagnostic_aggregator/analyzers/input_ports/path
	 * /diagnostic_aggregator/analyzers/input_ports/remove_prefix
	 * /diagnostic_aggregator/analyzers/input_ports/timeout
	 * /diagnostic_aggregator/analyzers/input_ports/type
	 * /diagnostic_aggregator/analyzers/kobuki/contains
	 * /diagnostic_aggregator/analyzers/kobuki/path
	 * /diagnostic_aggregator/analyzers/kobuki/remove_prefix
	 * /diagnostic_aggregator/analyzers/kobuki/timeout
	 * /diagnostic_aggregator/analyzers/kobuki/type
	 * /diagnostic_aggregator/analyzers/power/contains
	 * /diagnostic_aggregator/analyzers/power/path
	 * /diagnostic_aggregator/analyzers/power/remove_prefix
	 * /diagnostic_aggregator/analyzers/power/timeout
	 * /diagnostic_aggregator/analyzers/power/type
	 * /diagnostic_aggregator/analyzers/sensors/contains
	 * /diagnostic_aggregator/analyzers/sensors/path
	 * /diagnostic_aggregator/analyzers/sensors/remove_prefix
	 * /diagnostic_aggregator/analyzers/sensors/timeout
	 * /diagnostic_aggregator/analyzers/sensors/type
	 * /diagnostic_aggregator/base_path
	 * /diagnostic_aggregator/pub_rate
	 * /mobile_base/base_frame
	 * /mobile_base/battery_capacity
	 * /mobile_base/battery_dangerous
	 * /mobile_base/battery_low
	 * /mobile_base/cmd_vel_timeout
	 * /mobile_base/device_port
	 * /mobile_base/odom_frame
	 * /mobile_base/publish_tf
	 * /mobile_base/use_imu_heading
	 * /mobile_base/wheel_left_joint_name
	 * /mobile_base/wheel_right_joint_name
	 * /robot/name
	 * /robot/type
	 * /robot_description
	 * /robot_state_publisher/publish_frequency
	 * /rosdistro
	 * /rosversion
	 * /turtlebot_laptop_battery/acpi_path
	 * /use_sim_time

	NODES
	  /
		bumper2pointcloud (nodelet/nodelet)
		cmd_vel_mux (nodelet/nodelet)
		diagnostic_aggregator (diagnostic_aggregator/aggregator_node)
		mobile_base (nodelet/nodelet)
		mobile_base_nodelet_manager (nodelet/nodelet)
		robot_state_publisher (robot_state_publisher/robot_state_publisher)
		turtlebot_laptop_battery (linux_hardware/laptop_battery.py)

	auto-starting new master
	process[master]: started with pid [3258]
	ROS_MASTER_URI=http://localhost:11311

	setting /run_id to dcbfb5a6-66f2-11e3-8995-000c29c4ac2c
	process[rosout-1]: started with pid [3271]
	started core service [/rosout]
	process[robot_state_publisher-2]: started with pid [3274]
	process[diagnostic_aggregator-3]: started with pid [3275]
	process[mobile_base_nodelet_manager-4]: started with pid [3276]
	process[mobile_base-5]: started with pid [3277]
	process[cmd_vel_mux-6]: started with pid [3278]
	process[bumper2pointcloud-7]: started with pid [3279]
	process[turtlebot_laptop_battery-8]: started with pid [3357]
	[WARN] [WallTime: 1387267906.563684] Battery : unable to check laptop battery info [/proc/acpi/battery/BAT0 does not exist]
	[WARN] [WallTime: 1387267906.567031] Battery : unable to check laptop battery state [/proc/acpi/battery/BAT0 does not exist]
	[turtlebot_laptop_battery-8] process has finished cleanly
	log file: /home/viki/.ros/log/dcbfb5a6-66f2-11e3-8995-000c29c4ac2c/turtlebot_laptop_battery-8*.log

到这一步算是完成了Turtlebot软件环境的配置，但官方默认是Kobuki底盘（即Turtlebot2）的配置，如果使用iRobot Create底盘或者是Roomba底盘，还必须做其他环境变量的配置，请参考
《 `在iRobot Create底盘上跑Turtlebot <{filename}2013-12-17_run_trutlebot_with_irobot_create.rst>`_ 》

Reference
============
.. [Ubuntu_install_of_ROS_Hydro] http://wiki.ros.org/hydro/Installation/Ubuntu
.. [turtlebot_installation] http://wiki.ros.org/turtlebot/Tutorials/hydro/Installation

