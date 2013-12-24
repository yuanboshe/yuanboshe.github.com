在iRobot Create底盘上跑Turtlebot
#################################################

:tags: turtlebot, ros, xtion
:summary: 在iRobot create底盘上面跑turtlebot功能包，其实并不是件困难的事情，只是没有做过研究的人不知道如何下手罢了，本文记录全部流程。

	环境：Ubuntu 12.04, ROS Hydro.

.. contents:: 目录

准备工作
============
首先确保按照《 `TurtleBot笔记本端ROS环境配置 <{filename}2013-12-15_prepare_softs_for_turtlebot.rst>`_》一文中的步骤配置好ROS环境，并安装好turtlebot功能包。

用USB-TTL线将底盘与PC连接，设置虚拟机连接USB设备。下面的一系列操作要在首次测试前执行，以后测试不必执行。

配置irobot create 底盘环境变量
-------------------------------
turtlebot包默认配置是用于kobuki底盘的，直接运行会无法与irobot create底盘通讯，因此要改成irobot create底盘的配置。执行下面的命令，将在用户目录的 *.bashrc* 文件下添加命令中的脚本语句，随terminal的启动而执行：

.. code-block:: ubuntu

	echo "export TURTLEBOT_BASE=create" >> ~/.bashrc  
	echo "export TURTLEBOT_STACKS=circles" >> ~/.bashrc

可以设置的变量有如下四个，可以根据自己的需求修改::

    export TURTLEBOT_BASE=create
    export TURTLEBOT_STACKS=circles
    export TURTLEBOT_3D_SENSOR=kinect
    export TURTLEBOT_SIMULATION=false

重新打开terminal之后，这些变量就会生效。

赋予PC访问底盘接口权限
-----------------------
对于DIY玩家来说，用自己的Ubuntu系统连接irobot create底盘，跑turtlebot的底盘驱动包的时候，会遇到如下Error：

    [ERROR] [WallTime: 1383454018.987015] Failed to open port /dev/ttyUSB0.  Please make sure the Create cable is plugged into the computer.

这时PC无法与底盘通讯，问题的原因很可能是没有将自己的Ubuntu用户加入 *dialout* 用户组，解决办法如下。

列出ttyUSB设备：

.. code-block:: ubuntu

     ls -l /dev/ttyUSB*

结果可能是这样：

    crw-rw---- 1 root dialout 188, 0 Nov  2 10:31 /dev/ttyUSB0

如果没有 *ttyUSB0* ，重新插拔一下USB转串口线。

查看自己的用户组：

.. code-block:: ubuntu

    groups

结果可能是这样：

    viki adm cdrom sudo dip plugdev lpadmin sambashare

表示自己的用户不在 *dialout* 用户组内，通过下面的命令加入（我的用户名是 *viki* ，需要替换成自己的ubuntu用户名）：

.. code-block:: ubuntu

    sudo gpasswd -a viki dialout

重启系统后，设置才会生效。可以通过 ``groups`` 命令查看是否添加成功。

.. warning:: 如果你使用的是 **Ubuntu 13.04** ，*Failed to open port /dev/ttyUSB0* 的Error还是会存在，表面看似乎是串口权限的问题，其实是turtlebot内部隐藏的一个bug。在Ubuntu 13.04，可能是串口相关软件做了更新，行为与之前的版本不太一样，通过调试发现，在turtlebot的 *create_driver* package的 *create_driver.py* 文件的213行，*self.ser.open()* 处会抛出一段exception，显示 *the port is already open* 。注释掉这一行，在重启机器后能够正常连接上irobot create底盘，但是当退出连接，尝试重新连接的时候，会出现 *Error reading from SCI port. No data.* 的Error。暂时还没发现比较好的解决方案，也没有做深入研究。

运行测试
==========
最简单的turtlebot测试就是键盘控制测试了。

键盘远程控制测试
------------------
启动3个terminal分别运行以下命令：

.. code-block:: ubuntu

    roscore
    roslaunch turtlebot_bringup minimal.launch
    roslaunch turtlebot_teleop keyboard_teleop.launch

这3个terminal分别：启动master，启动turtlebot底盘，启动键盘控制。实际上不运行 ``roscore`` 也行， *minimal.launch* 里面会附带运行，但作为ROSer，还是规范点开机就执行 ``roscore`` 。

控制方式在启动 *keyboard_teleop.launch* 上面的terminal里面有提示::

    Control Your Turtlebot!
    ---------------------------
    Moving around:
       u    i    o
       j    k    l
       m    ,    .

    q/z : increase/decrease max speeds by 10%
    w/x : increase/decrease only linear speed by 10%
    e/c : increase/decrease only angular speed by 10%
    space key, k : force stop
    anything else : stop smoothly

例如：键盘按键 **“i”** ”是前进，键盘按键 **“,”** 是后退...
