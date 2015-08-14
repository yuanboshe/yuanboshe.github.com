10分钟安装ROS（Windows + 虚拟机）2015-07-19更新
#################################################

:tags: aicroboxi, ros
:authors: Yuanbo She
:summary: 距离上次写这篇经验分享帖已经16个月了，玩ROS的熟手越来越多，但过时和不负责的转载依旧对新手造成困扰。总结这十几个月朋友们遇到的问题，更新本贴！废话少说，旧帖参考《`10分钟安装ROS（Windows + 虚拟机） <2014-03-install_ros_in_10mins_vm.html>`_》，本文以VMWare Workstation 10.0.4为例记录虚拟机中安装Ubuntu for ROS的流程，裸机中安装Ubuntu for ROS请参考《`10分钟安装ROS（U盘/CD刻录盘 + 裸机）2015-07-19更新 <2015-07-install_ros_in_10mins_pc_new.html>`_》教程。

	环境：Windows 8.1, VMWare Workstation 10.0.4, Ubuntu for ROS.

.. contents:: 目录

准备工作
============
所谓“虚拟机”安装，是指在PC本来的系统中安装虚拟机软件（如VMWare系列），然后在虚拟机中安装Ubuntu for ROS系统。

准备材料：

* 下载Ubuntu for ROS，例如下载UROS1404I64DEV_aicrobo_150715，下载后是UROS1404I64DEV_aicrobo_150715.iso文件。正式Ubuntu for ROS发行版集合页面《`Ubuntu for ROS <http://aicrobo.github.io/ubuntu_for_ros.html>`_》。
* 下载虚拟机软件并安装，本文使用的是VMWare Workstation 10.0.4。

.. tip:: VMWare Workstation 10.0.0~3版本存在内存不够bug。

Ubuntu for ROS的安装
=====================
打开虚拟机VMWare，文件 -> 新建虚拟机，将会打开新建虚拟机向导；选择“典型”，下一步；选择“安装程序光盘映像文件(iso)” -> 浏览，选择前面下载的iso文件，下一步：

.. image:: {image}step1.jpg
	:alt: step1

.. tip:: “UROS1404I64”和“UROS1404I32”中，最后两位表示Ubuntu系统版本，分别为64位和32位。

“客户机操作系统”选择“Linux”，版本选择与Ubuntu for ROS版本对应的Ubuntu版本（“Ubuntu 64位”/“Ubuntu 32位），下一步：

.. image:: {image}step2.jpg
	:alt: step2

填写虚拟机名称和存放位置，下一步：

.. image:: {image}step3.jpg
	:alt: step3

然后一路“下一步”直到“完成”：
    
.. image:: {image}step4.jpg
	:alt: step4

“开启此虚拟机”，进入Ubuntu for ROS安装选项界面：

.. image:: {image}step5.jpg
	:alt: step5

此时主要分两种模式使用或者安装：“预览模式”和“安装模式”，分别对应“live - boot the Live System”和“install - start the installer directly”两个选项。

预览模式
------------
预览模式对应“live - boot the Live System”选项，不需要安装即可立即使用Ubuntu for ROS系统进行ROS学习与开发，但关机后自动恢复，进入系统后做的所有修改无效。

预览模式会将iso文件内的系统在内存中加载，就像硬盘上的系统一样可以直接使用，不占有硬盘空间，关机后消失。

从预览模式系统桌面上的安装图标，也可以进入安装模式进行Ubuntu for ROS系统的硬盘安装。

.. image:: {image}view1.jpg
	:alt: view1

安装模式
-----------
安装模式对应“install - start the installer directly”选项，直接将Ubuntu for ROS系统装在虚拟机硬盘文件上，永久保存。

进入安装界面后，一路“Next”就可以了，没有什么需要选择的选项。

.. image:: {image}install1.jpg
	:alt: install1

唯一可能会让人产生迷惑的地方，是“Keyboard layout”一步，“Continue”按键可能会因为屏幕未缩放而看不到，需要用鼠标将窗口向左拖动，或者直接回车。

.. image:: {image}install2.jpg
	:alt: install2

另外，在安装完成或者其他需要重启的时候，可能会卡在下面的界面无法重启，此时只需要在虚拟机内强制重启就可以了。

.. image:: {image}install3.jpg
	:alt: install3

系统测试
---------------
打开“terminal”，输入“roscore”并回车，看到ros master启动成功：

.. image:: {image}test.jpg
	:alt: test

.. note:: 安装完成，重启后会跳出 *Update information* 对话框，**Close** 掉就可以了。所有发布版本默认用户名和密码均为 **aicrobo** 。