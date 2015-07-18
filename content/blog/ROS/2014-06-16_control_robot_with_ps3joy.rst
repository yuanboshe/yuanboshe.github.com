用 PS3 手柄控制机器人
#############################

:tags: ros, ubuntu_for_ros
:summary: 本文介绍如何使用PS3手柄控制机器人。
:status: draft

.. contents:: 目录

安装
============

.. code-block:: ubuntu

	sudo apt-get install ros-hydro-joystick-drivers
	rosdep install ps3joy
	rosmake ps3joy
	

插入PS3 的USB

	$ sudo bash
	$ rosrun ps3joy sixpair

	root@exbot:~# rosrun ps3joy sixpair
	Current Bluetooth master: 20:36:00:32:00:eb
	Setting master bd_addr to 00:15:83:0c:bf:eb


	root@exbot:~# rosrun ps3joy ps3joy.py --inactivity-timeout=100
	Inactivity timeout set to 100 seconds.
	Waiting for connection. Disconnect your PS3 joystick from USB and press the pairing button.


	roslaunch ps3joy ps3.launch
