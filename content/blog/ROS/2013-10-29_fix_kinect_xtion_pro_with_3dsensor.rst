Fix 3dsensor.launch兼容Kinect和ASUS Xtion pro Live
####################################################

:tags: turtlebot, ros, xtion, kinect
:summary: 忘了是从哪里看来的消息，说ROS里面的openni已经不能用来驱动Kinect和Xtion pro Live摄像头了，究其原因，说是openni驱动更新出现了问题，而且官方也不再更新了。当前Ubuntu某个摄像头包已经包含了Kinect驱动，新版Xtion pro Live也不能用以前的openni驱动。那么现在的Kinect和Xtion pro Live用什么驱动呢？玩turtlebot免不了使用3dsensor.launch来启动深度摄像头相关的nodes但3dsensor.launch里面依旧使用的openni驱动，大部分玩家都是买的现成turtlebot，不明白为什么他们的Kinect还能用得起来而我的Kinect却无法用openni驱动起来，也许是他们没有更新openni包吧。对于我这种没买turtlebot的，只有自己fix 3dsensor.launch的摄像头驱动问题了。

	环境：ROS Groovy + Kinect / Xtion pro Live

.. contents:: 目录

Kinect
============
准备工作
----------
安装 ``turtlebot`` 工具包（refer [turtlebot]_ ）：

.. code-block:: ubuntu

    > sudo apt-get install ros-groovy-turtlebot ros-groovy-turtlebot-apps ros-groovy-turtlebot-viz

之后可能还需要禁用Ubuntu内建的Kinect驱动：

.. code-block:: ubuntu

    > sudo modprobe -r gspca_kinect
    > echo 'blacklist gspca_kinect' | sudo tee -a /etc/modprobe.d/blacklist.conf

安装 ``freenect`` 驱动包（refer [freenect]_  )：

.. code-block:: ubuntu

    > sudo apt-get install ros-groovy-freenect-stack

Fixe Kinect 3dsensor.launch
----------------------------
Kinect的Fix很简单，只需要修改 ``3dsensor.launch`` 即可。
进入到3dsensor路径，对其进行编辑：

.. code-block:: ubuntu

    > roscd turtlebot_bringup/launch/
    > sudo gedit 3dsensor.launch

.. note:: 可以先用 ``sudo cp 3dsensor.launch 3dsensor_back.launch`` 将以前的launch文件备份一份，以防万一。

找到下面的代码：

.. code-block:: xml

    <node pkg="nodelet" type="nodelet" name="openni_camera_loader" args="load openni_camera/driver $(arg manager)" respawn="true">
        <rosparam file="$(find turtlebot_bringup)/param/3dsensor.yaml" command="load"/>
        <param name="depth_registration" value="$(arg depth_registration)"/>
    </node>

将 ``openni`` 改为 ``freenect`` 即可，即：

.. code-block:: xml

     <node pkg="nodelet" type="nodelet" name="freenect_camera_loader" args="load freenect_camera/driver $(arg manager)" respawn="true">
        <rosparam file="$(find turtlebot_bringup)/param/3dsensor.yaml" command="load"/>
        <param name="depth_registration" value="$(arg depth_registration)"/>
    </node>

启动测试
---------
依次启动 ``minimal.launch``，``3dsensor.launch`` 和 ``rviz``：

.. code-block:: ubuntu

    > roslaunch turtlebot_bringup minimal.launch
    > roslaunch turtlebot_bringup 3dsensor.launch
    > roslaunch turtlebot_rviz_launchers view_robot.launch

rviz启动后，勾选“Registered DepthCloud”和“LaserScan”，即可看到深度摄像头利用深度信息重建的3D点云图像，如下图：

.. image:: {image}kinect1.jpg
    :alt: Kinect 3dsensor

场景中红色点线即为从点云中提取的模拟2D激光雷达的信息。

Xtion pro Live
================
准备工作
----------
安装 ``turtlebot`` 工具包（refer [turtlebot]_ ）：

.. code-block:: ubuntu

    > sudo apt-get install ros-groovy-turtlebot ros-groovy-turtlebot-apps ros-groovy-turtlebot-viz

安装 ``openni2_camera`` 驱动包：

.. code-block:: ubuntu

    > sudo apt-get install ros-groovy-openni2-camera

安装 ``openni2_launch`` 文件包（refer [openni2_launch]_ )：

.. code-block:: ubuntu

    > cd ~/catkin_ws/src/
    > git clone https://github.com/ros-drivers/openni2_launch.git
    > cd openni2_launch
    > git checkout groovy-devel

.. warning:: 如果对 [catkin]_ 和 git 不熟悉，还是先预习一下相关知识吧。目前官方的Ubuntu更新源里没有 ``openni2_launch`` 包，只能下载源码到自己的catkin workspace里。

Fix Xtion pro Live 3dsensor.launch
------------------------------------
Xtion pro Live的Fix稍微复杂点，进入到3dsensor路径，对其进行编辑：

.. code-block:: ubuntu

    > roscd turtlebot_bringup/launch/
    > sudo gedit 3dsensor.launch

.. note:: 可以先用 ``sudo cp 3dsensor.launch 3dsensor_back.launch`` 将以前的launch文件备份一份，以防万一。

用下面的内容替换到整个 ``3dsensor.launch`` 的内容：

.. code-block:: xml

    <!-- Modified for Xtion pro Live camera. -->
    <launch>
      <arg name="camera" default="camera" />
      <arg name="publish_tf" default="false" />
      <arg name="depth_registration" default="true" />
      <arg name="rgb_processing" default="true" />
      <arg name="ir_processing" default="true" />
      <arg name="depth_processing" default="true" />
      <arg name="depth_registered_processing" default="true" />
      <arg name="disparity_processing" default="true" />
      <arg name="disparity_registered_processing" default="true" />
      <arg name="scan_processing" default="true" />
      <arg name="num_worker_threads" default="4" />
      <arg name="scan_topic" default="scan" />

      <include file="$(find openni2_launch)/launch/openni2.launch">
        <arg name="camera" value="$(arg camera)" />
        <arg name="publish_tf" value="$(arg publish_tf)" />
      </include>

      <group if="$(arg scan_processing)">
        <node pkg="nodelet" type="nodelet" name="depthimage_to_laserscan_loader" args="load depthimage_to_laserscan/DepthImageToLaserScanNodelet camera_nodelet_manager">
          <param name="scan_height" value="10" />
          <param name="output_frame_id" value="/camera_depth_frame" />
          <param name="range_min" value="0.45" />
          <remap from="image" to="/camera/depth/image_raw" />
          <remap from="scan" to="/scan" />
        </node>
      </group>
    </launch>

启动测试
---------
依次启动 ``minimal.launch``，``3dsensor.launch`` 和 ``rviz``：

.. code-block:: ubuntu

    > roslaunch turtlebot_bringup minimal.launch
    > roslaunch turtlebot_bringup 3dsensor.launch
    > roslaunch turtlebot_rviz_launchers view_robot.launch

rviz启动后，勾选“DepthCloud”和“LaserScan”，展开“DepthCloud”，选择“Color Image Topic”为“/camera/rgb/image”即可看到深度摄像头利用深度信息重建的3D点云图像，如下图：

.. image:: {image}xtion1.jpg
    :alt: Xtion pro Live 3dsensor

场景中红色点线即为从点云中提取的模拟2D激光雷达的信息。

Reference
========================

.. [turtlebot] turtlebot statck, http://wiki.ros.org/turtlebot/Tutorials/groovy/Installation
.. [freenect] freenect driver statck, http://wiki.ros.org/freenect_stack
.. [catkin] catkin/Tutorials/create_a_workspace http://wiki.ros.org/catkin/Tutorials/create_a_workspace
.. [openni2_camera] openni2_camera driver files github, https://github.com/ros-drivers/openni2_camera/tree/groovy-devel
.. [openni2_launch] openni2_launch launch files github, https://github.com/ros-drivers/openni2_launch/tree/groovy-devel