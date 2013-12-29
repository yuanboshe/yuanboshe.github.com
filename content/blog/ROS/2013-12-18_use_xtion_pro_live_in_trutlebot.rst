给自制Turtlebot装上ASUS Xtion pro Live摄像头
#################################################

:tags: turtlebot, ros, xtion
:summary: 在《 `在iRobot Create底盘上跑Turtlebot. <2013-12-run_trutlebot_with_irobot_create.html>`_》一文中介绍了如何在irobot create底盘上面运行turtlebot，这里介绍如何给自己搭建的简易turtlebot加上ASUS Xtion pro live深度摄像头。《 `Fix 3dsensor.launch兼容Kinect和ASUS Xtion pro Live <2013-10-fix_kinect_xtion_pro_with_3dsensor.html>`_ 》一文介绍了如何在ROS Groovy中解决Kinect和Xtion pro Live驱动的问题，这里是Hydro版本的ROS，过程略有差异。

	环境：Ubuntu 12.04, ROS Hydro.

.. contents:: 目录

准备工作
==========
确保按照《 `在iRobot Create底盘上跑Turtlebot <{filename}2013-12-17_run_trutlebot_with_irobot_create.rst>`_》一文中的步骤配置好irobot create的运行环境。

安装
======
ROS里openni2驱动的封装包包含两个部分，一个是openni2_camera，另一个是openni2_launch。在ROS Groovy版本里，远程源没有openni2_launch，所以在之前的博文中使用源码编译的方法使用。而ROS Hydro的远程源两部分都有，直接远程安装即可。

安装openni2驱动包
------------------
.. code-block:: ubuntu

	sudo apt-get install ros-hydro-openni2-camera ros-hydro-openni2-launch

Fix 3dsensor.launch
---------------------
3dsensor.launch是turtlebot内启动深度摄像头感知环境的launch脚本，原本使用的是openni驱动，现在我们替换成了openni2，需要在这里做一些改动让该脚本使用openni2驱动。

.. code-block:: ubuntu

    roscd turtlebot_bringup/launch/
    sudo gedit 3dsensor.launch

通过上面的命令打开3dsensor.launch，你将看到如下内容：

.. code-block:: xml

	<!-- 
	  Turtlebot is a bit low on horsepower...

	  We use openni_camera here, turn everything on by default
	  (allows the user to conveniently see everything when
	  launching this on its own - use with 
	  turtebot_rviz_launchers/view_robot.launch to visualise)
	  and provide args to disable them so you can optimise the
	  horsepower for your application.
	  
	  For an example of disabling processing modules, check
	  any of the turtlebot_core_apps (e.g. android_make_a_map.launch
	  only enables scan_processing for depthimage_to_laserscan and
	  rgb_processing for the android tele-view).
	-->
	<launch>
	  <!-- "camera" should uniquely identify the device. All topics are pushed down
		   into the "camera" namespace, and it is prepended to tf frame ids. -->
	  <arg name="camera"      default="camera"/>
	  <arg name="publish_tf"  default="false"/>

	  <!-- Factory-calibrated depth registration -->
	  <arg name="depth_registration"              default="true"/>

	  <!-- Processing Modules -->
	  <arg name="rgb_processing"                  default="true"/>
	  <arg name="ir_processing"                   default="true"/>
	  <arg name="depth_processing"                default="true"/>
	  <arg name="depth_registered_processing"     default="true"/>
	  <arg name="disparity_processing"            default="true"/>
	  <arg name="disparity_registered_processing" default="true"/>
	  <arg name="scan_processing"                 default="true"/>

	  <!-- Worker threads for the nodelet manager -->
	  <arg name="num_worker_threads" default="4" />

	  <!-- Laserscan topic -->
	  <arg name="scan_topic" default="scan"/>

	  <include file="$(find openni_launch)/launch/openni.launch">
		<arg name="camera"                          value="$(arg camera)"/>
		<arg name="publish_tf"                      value="$(arg publish_tf)"/>
		<arg name="depth_registration"              value="$(arg depth_registration)"/>
		<arg name="num_worker_threads"              value="$(arg num_worker_threads)" />

		<!-- Processing Modules -->
		<arg name="rgb_processing"                  value="$(arg rgb_processing)"/>
		<arg name="ir_processing"                   value="$(arg ir_processing)"/>
		<arg name="depth_processing"                value="$(arg depth_processing)"/>
		<arg name="depth_registered_processing"     value="$(arg depth_registered_processing)"/>
		<arg name="disparity_processing"            value="$(arg disparity_processing)"/>
		<arg name="disparity_registered_processing" value="$(arg disparity_registered_processing)"/>
	  </include>

	   <!--                        Laserscan 
		 This uses lazy subscribing, so will not activate until scan is requested.
	   -->
	  <group if="$(arg scan_processing)">
		<node pkg="nodelet" type="nodelet" name="depthimage_to_laserscan" args="load depthimage_to_laserscan/DepthImageToLaserScanNodelet $(arg camera)/$(arg camera)_nodelet_manager">
		  <!-- Pixel rows to use to generate the laserscan. For each column, the scan will
			   return the minimum value for those pixels centered vertically in the image. -->
		  <param name="scan_height" value="10"/>
		  <param name="output_frame_id" value="/$(arg camera)_depth_frame"/>
		  <param name="range_min" value="0.45"/>
		  <remap from="image" to="$(arg camera)/depth/image_raw"/>
		  <remap from="scan" to="$(arg scan_topic)"/>

		  <!-- Somehow topics here get prefixed by "$(arg camera)" when not inside an app namespace,
			   so in this case "$(arg scan_topic)" must provide an absolute topic name (issue #88).
			   Probably is a bug in the nodelet manager: https://github.com/ros/nodelet_core/issues/7 -->
		  <remap from="$(arg camera)/image" to="$(arg camera)/depth/image_raw"/>
		  <remap from="$(arg camera)/scan" to="$(arg scan_topic)"/>
		</node>
	  </group>
	</launch>

找到 ``<include file="$(find openni_launch)/launch/openni.launch">`` 一行，将其替换为 ``<include file="$(find openni2_launch)/launch/openni2.launch">`` 保存即可。

测试
------
依次启动 **master**, **minimal.launch**, **3dsensor.launch** 和 **rviz**：

.. code-block:: ubuntu

    roscore
    roslaunch turtlebot_bringup minimal.launch
    roslaunch turtlebot_bringup 3dsensor.launch
    roslaunch turtlebot_rviz_launchers view_robot.launch

rviz启动后，勾选“DepthCloud”和“LaserScan”，展开“DepthCloud”，选择“Color Image Topic”为“/camera/rgb/image”即可看到深度摄像头利用深度信息重建的3D点云图像，如下图：

.. image:: {image}3dsensor.jpg
    :alt: Xtion pro live 3dsensor

场景中红色点线即为从点云中提取的模拟2D激光雷达的信息。
