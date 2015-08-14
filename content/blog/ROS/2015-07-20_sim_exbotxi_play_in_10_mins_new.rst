10分钟上手玩ROS仿真机器人
##############################

:tags: exbotxi, ros
:summary: 没钱买ROS移动机器人平台？那就玩玩免费的ROS仿真机器人平台吧！ROS里面玩仿真机器人是很容易的事情，但从0开始配置到能玩ROS仿真机器人是很麻烦的，新手想凭自己的Search能力玩起来，先磨几个月再考虑吧。10分钟上手玩不是玩笑，下载好Ubuntu for ROS开发版后，如果使用虚拟机预览模式进入系统，10分钟都不要就能上手玩！

	环境：Windows, VMWare Workstation 10.0, Ubuntu for ROS h2-140330.

:status: draft

.. contents:: 目录

准备工作
=========
在电脑里面装好虚拟机，这里以VMWare Workstation 10.0为例。

从 `Ubuntu for ROS官网 <http://blog.exbot.net/archives/702>`_ 下载Ubuntu for ROS开发版，这里下载的是 **ubuntu12.04-ros-exbot-h2-140330** 。

要想看到底最快几分钟能玩起来，请参照Ubuntu for ROS虚拟机安装教程的 `预览方式试用Ubuntu for ROS <http://blog.exbot.net/archives/762#id4>`_ 。  

示例程序
==========
进入正题，快捷命令来了。

.. tip:: 在terminal中输入命令的时候，输入一半按一下 *Tab* 键可以自动补全命令，如果没有自动补全，连按两下 *Tab* 键可以显示候选。

.. note:: 输入下面例子中的命令后回车将执行命令，在terminal窗口按下 **Ctrl + C** 组合键可以退出正在运行的程序。

显示模型
----------
打开terminal，输入命令：

.. code-block:: ubuntu

	roslaunch exbotxi_rviz view_model.launch

将会打开rviz，并加载查看机器人模型的配置，如下图：

.. image:: {image}view1.jpg
	:alt: view model

这里加载的是ExBot XI移动机器人平台模型，在该配置里面只能简单地查看模型，无法做控制等操作。

.. tip:: 鼠标左键点住机器人拖动，可以旋转视图；鼠标中键点住机器人拖动，可以平移视图；鼠标右键点住机器人拖动，或者滚动滚轮，可以放大缩小视图。

键盘控制
----------
早说过ExBot XI移动机器人平台兼容turtlebot了，这里就用turtlebot包的键盘控制node来控制机器人移动。

**Ctrl + C** 结束掉前面的程序，关闭terminal，然后再打开3个terminal，分别输入下面的3个命令：

.. code-block:: ubuntu

	roslaunch exbotxi_bringup fake_exbotxi.launch
	roslaunch turtlebot_teleop keyboard_teleop.launch
	roslaunch exbotxi_rviz view_mobile.launch 

第1条命令用于启动ExBot XI仿真机器人，启动成功后显示信息如下：

.. image:: {image}sim.jpg
	:alt: view robot

第2条命令用于启动键盘控制node。第3条命令用于打开ROS可视化工具rviz，并加载移动机器人视图配置。

现在将光标focus在第2条命令的terminal窗口，便可以通过键盘控制仿真机器人了：

.. image:: {image}control1.jpg
	:alt: view control

控制方式在terminal窗口上有提示，**i**, **k** 为前后，**j**, **l** 为左右转向。

turtlebot的keyboard_teleop.launch键盘控制，自带速度平滑功能，加减速平滑过渡，当不按键盘的时候会停下。

.. tip:: 打开一个terminal后，如果想再开一个terminal，可以在前面那个terminal窗口内区域鼠标右键，选择 **Open Tab** 打开，这样可以避免多个terminal独立窗口切换麻烦。

rqt GUI控制
-------------
现在换ROS里面的便民工具rqt，用GUI来控制机器人。

**Ctrl + C** 结束掉前面第2个terminal（运行keyboard_teleop.launch的terminal）运行的程序，换成执行下面的命令：

.. code-block:: ubuntu

	rosrun rqt_robot_steering rqt_robot_steering 

运行成功后用rqt的Robot Steering GUI控制机器人的界面如下：

.. image:: {image}control2.jpg
	:alt: view control

将光标focus在Robot Steering GUI上面，两个进度条的作用很明显，就是前后速度和转向速度。你可以用鼠标直接拖动，也可以用键盘来调整，按键是 **wsad**, **zx** 分别用于转向和前后速度的归零，空格用于所有速度的归零。

Interactive Marker控制
------------------------
现在体验下rviz的Interactive Marker控制移动机器人。
**Ctrl + C** 结束掉前面第2个terminal（运行rqt_robot_steering的terminal）运行的程序，然后...然后没有然后了，不用输入什么命令了。

Focus在rviz界面，选择最上面 **Interact** 工具，勾上左边 *Displays* 栏的 *InteractiveMarkers* 显示项。将会看到下面的界面：

.. image:: {image}control3.jpg
	:alt: view control

现在可以直接用鼠标在rviz界面上操作机器人了，红色箭头用来操作前进后退，蓝色圈圈用来操作转弯...

代码控制
----------
不管用什么控制方式控制机器人都只是玩玩，手柄控制，Android手机控制，等等在后面的exbot_xi包中会更新，作为一个ROS移动机器人的开发者，最需要知道的是如何使用代码控制。

现在先测试exbotxi_example package中的示例代码，前面第2个terminal还空着，在这个terminal中输入启动示例代码的命令：

.. code-block:: ubuntu
	
	rosrun exbotxi_example move

机器人开始转圈了，效果如图：

.. image:: {image}program1.jpg
	:alt: view program

**Ctrl + C** 结束掉 *move* 例程，机器人便会停止运行，换成下面的命令：

.. code-block:: ubuntu
	
	rosrun exbotxi_example move.py

可以看到效果一样。不同的是 *move* 例程是用cpp写的，*move.py* 例程是用python写的，代码在解释放在后面的教程中说明，源码放在 *~/catkin_ws/src/exbot_xi/exbotxi_example/nodes* 路径下。

真实机器人
============
前面说过 *roslaunch exbotxi_bringup fake_exbotxi.launch* 是启动仿真ExBot XI机器人平台的命令，如果在真实机器人上面试验，换成另外一条启动命令即可，同时电脑里面的可视化界面会同步显示机器人运行轨迹，效果跟使用仿真机器人一样，只不过多了一个真实的机器人在现实环境中运行。

ExBot将不断丰富exbot_xi移动机器人开发包功能，提供更多移动机器人控制示例代码，如果对移动机器人感兴趣，请关注 ExBot ROS版，http://blog.exbot.net/archives/category/ros 。ExBot XI移动机器人平台请参考 `ExBot XI移动机器人平台 <http://item.taobao.com/item.htm?spm=a230r.1.14.5.dcOLJj&id=37550412891&_u=v10nmj0b411>`_ 。
