在pcDuino内安装ROS Groovy
#############################

:tags: ros, pcduino
:summary: 环境：Windows7 64位。

    在pcDuino上面安装ROS，也许很多人的第一反应是参考树莓派等其他板子机的经验，或者直接编译源码。其实大可不必，ROS大团队当然考虑到了板子机对ROS的需求，已有支持Ubuntu ARM的远程库，
    官方教程 `Ubuntu ARM install of ROS Groovy <http://www.ros.org/wiki/groovy/Installation/UbuntuARM>`_ ，pcDuino + Lubuntu系统，完美安装ROS。当然还是有点美中不足，这里把流程记录下来。

安装流程
===============
先确保按照《 `PcDuino入手设置流程（for ROS） <{filename}2013-07-18_setup_pcduino_for_ros.rst>`_ 》做好准备工作。
以pcDuino的默认用户 ``ubuntu`` 身份进入Lubuntu系统。打开Terminal，然后依次执行以下流程。

配置更新源
-----------
.. code-block:: ubuntu

    sudo sh -c 'echo "deb http://packages.ros.org/ahendrix-mirror/ubuntu precise main" > /etc/apt/sources.list.d/ros-latest.list'

设置秘钥
---------
.. code-block:: ubuntu

    wget http://packages.ros.org/ros.key -O - | sudo apt-key add -

更新软件
----------
.. code-block:: ubuntu

    sudo apt-get update

这时可能会出现一个错误（20130531版Lubuntu）：

    W: Conflicting distribution: http://www.wiimu.com pcduino Release (expected pcduino but got )

可以直接把对应源注释掉。方法是用LeafPad编辑器打开/etc/apt/sources.list：

.. code-block:: ubuntu

    sudo leafpad /etc/apt/sources.list

注释掉http://www.wiimu.com对应的两行如图：

.. image:: {image}modify.jpg
    :alt: modify

保存后再用 ``sudo apt-get update`` 更新。即可顺利更新完毕。

.. note:: “http://www.wiimu.com” 是执行 ``sudo board-config.sh`` 进入Board Configuration界面运行 ``Update`` 给pcDuino升级用的，如果需要Update pcDuino，需要重新打开这行。

安装ROS
--------------
ROS目前主要有如下3种配置：

====================  ================================================================
ros-groovy-ros-base   Meta package for ros-base variant of ROS.
ros-groovy-ros-comm   ROS communications-related packages, including
                      core client libraries (roscpp, rospy) and graph
                      introspection tools (rostopic, rosnode, rosservice, rosparam).
ros-groovy-ros-full   Meta package for ros-full variant of ROS.
====================  ================================================================

3中配置方案，功能包依次丰富。但ros-groovy-ros-full安装时目前会出现依赖包版本问题：

    The following packages have unmet dependencies:
    ros-groovy-ros-full : Depends: ros-groovy-rqt-common-plugins (= 0.2.14-0precise-20130402-0859-+0000) but it is not going to be installed
    E: Unable to correct problems, you have held broken packages.

ros-groovy-ros-comm 和 ros-groovy-ros-base 能够顺利装完，这里我装的是 ros-groovy-ros-comm：

.. code-block:: ubuntu

    sudo apt-get install ros-groovy-ros-comm

可以用 ``apt-cache search ros-groovy`` 命令查看还有哪些包可以装。

初始化rosdep
---------------
.. code-block:: ubuntu

    sudo apt-get install python-rosdep
    sudo rosdep init
    rosdep update

设置ROS随Terminal启动运行
--------------------------
.. code-block:: ubuntu

    echo "source /opt/ros/groovy/setup.bash" >> ~/.bashrc
    source ~/.bashrc

测试
-----
此时运行命令 ``roscore`` 应该能看到ROS master正常运行消息：

::

    started roslaunch server http://ubuntu:37709/
    ros_comm version 1.9.44

    SUMMARY
    ========

    PARAMETERS
     * /rosdistro
     * /rosversion

    NODES

    auto-starting new master
    process[master]: started with pid [3734]
    ROS_MASTER_URI=http://ubuntu:11311/

    setting /run_id to 5956b562-f670-11de-8ea2-26eb04d6389b
    process[rosout-1]: started with pid [3747]
    started core service [/rosout]
