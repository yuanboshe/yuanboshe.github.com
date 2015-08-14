10分钟安装ROS（Windows + 虚拟机）
###################################

:tags: exbotxi, ros
:summary: 无论你是ROS新手还是ROS老鸟，重新安装ROS都是一件很头疼的事情。完全版有2G多内容需要更新，网络状况不好时可能一两天才能装完，而对于新手来说钻研几个月也不见得能配出完美的开发环境，毕竟官方wiki的资料并不完善，还有很多细节需要处理。而Ubuntu for ROS正是解决这些问题的好办法，下载完Ubuntu for ROS后，10分钟即可完成安装，安装完成后可以立即做ROS学习，开发。本文以VMWare Workstation 10.0.0为例记录虚拟机中安装Ubuntu for ROS的流程，裸机中安装Ubuntu for ROS请参考《10分钟安装ROS（U盘/CD刻录盘 + 裸机）》

	环境：Windows 8.1, VMWare Workstation 10.0.0.

.. contents:: 目录

准备工作
============
首先从 `Ubuntu for ROS发行版集合 <http://blog.exbot.net/archives/702>`_ 页面下载Ubuntu for ROS iso文件，本文以Hydro开发版 *ubuntu12.04-ros-exbot-h2-140330* 为例，下载后是ubuntu12.04-ros-exbot-h2-140330.iso文件。

然后打开虚拟机VMWare，以下分为安装和预览两种方式介绍。安装方式会在虚拟机中安装全新的Ubuntu操作系统，安装过程需要10分钟（不知道是不是因为我是SSD硬盘比较快）；预览方式可以像本地新系统一样进行任意操作，但不会在虚拟机中生成系统文件，虚拟机重启后任何修改都无效，预览方式使用ROS无需安装，更快捷，适合立即体验ROS。

安装方式安装
=============
文件 -> 新建虚拟机，将会打开新建虚拟机向导；选择“典型”，下一步；选择“安装程序光盘映像文件(iso)” -> 浏览，选择前面下载的iso文件，下一步：

.. image:: {image}step1.jpg
	:alt: step1

“简易安装信息”页面中的用户名和密码等所有信息都可以随便填写，安装完成后此页面填写的内容不会生效，下一步；“命名虚拟机”页面中填写虚拟机的名字和存放位置，下一步：

.. image:: {image}step2.jpg
	:alt: step2

“指定磁盘容量”页面中，默认20G足以，下一步；将会出现最后一步的页面：

.. image:: {image}step3.jpg
	:alt: step3

点击“自定义硬件”按钮，给虚拟机增加内存（ *开发版Ubuntu for ROS* 必须将虚拟机内存提高为1.5G或者更高，否则报错无法安装，而 *基础版Ubuntu for ROS* 默认1G即可安装和使用，若是基础版可以跳过此步）：

.. image:: {image}step4.jpg
	:alt: step4

关闭，点击“完成”即可完成设置。虚拟机会自动启动，并加载iso文件进行安装，稍等片刻便会出现安装画面：

.. image:: {image}step5.jpg
	:alt: step5

一路毫无技术含量地默认设置“Continue”即可，几分钟即可安装完成。安装完成后会提示重启，重启后在登陆界面输入密码 **exbot** 即可进入系统，现在可以开始使用ROS了：

.. image:: {image}step6.jpg
	:alt: step6

打开terminal，输入命令“roscore”，回车，即可看到ROS master启动成功：

.. image:: {image}step7.jpg
	:alt: step7

Enjoy your ROS time!

.. note:: 安装完成后可能会跳出一个 *Update information* 窗口，关闭即可。

预览方式试用
=============
预览方式更快捷，无需安装，几步简单的操作即可体验ROS。

文件 -> 新建虚拟机，将会打开新建虚拟机向导；选择“典型”，下一步；选择“稍后安装操作系统”，下一步：

.. image:: {image}stepv1.jpg
	:alt: stepv1

“选择客户机操作系统”页面中，“客户机操作系统”选择“Linux”，版本“Ubuntu”，下一步；“命名虚拟机”页面中填写虚拟机的名字和存放位置，下一步：

.. image:: {image}stepv2.jpg
	:alt: stepv2

然后一路下一步直至完成，完成设置后会回到虚拟机主页面：

.. image:: {image}stepv3.jpg
	:alt: stepv3

选择“编辑虚拟机设置”，打开虚拟机设置对话框；CD/DVD (SATA) -> 使用ISO映像文件 -> 浏览，选择前面下载的iso文件；内存调整为1.5G或者更高（ *开发版Ubuntu for ROS* 必须将虚拟机内存提高为1.5G或者更高，否则报错无法进行预览，而 *基础版Ubuntu for ROS* 默认1G即可）：

.. image:: {image}stepv4.jpg
	:alt: stepv4

确认后将回到主页面，点击“开启此虚拟机”，稍等片刻将来到引导页面：

.. image:: {image}stepv5.jpg
	:alt: stepv5

在引导页面中，默认第一个“boot the Live System”，几秒钟或者回车后，开启预览Ubuntu系统；在登陆界面输入密码 **exbot** 即可进入系统，现在可以开始使用ROS了：

.. image:: {image}stepv6.jpg
	:alt: stepv6

打开terminal，输入命令“roscore”，回车，即可看到ROS master启动成功：

.. image:: {image}stepv7.jpg
	:alt: stepv7

Enjoy your ROS time!

.. tip:: 如果试用着还不错，想安装在虚拟机里面，看见桌面上的“Install Ubuntu for ROS”图标了吧，双击即可进入安装程序，过程与安装方式类似。

要注意的问题
==============
新建虚拟机后，最好将虚拟机内存调整到2G或者更大，并增加处理器核心总数。开发版Ubuntu for ROS的安装需要1.5G或者更大的内存，否则无论是安装过程，还是预览过程，都会出现error而无法正常进行。

例如，使用预览方式进入系统，会弹出下面的错误。

	The system is running in low-graphics mode

	Your screen, graphics cards, and input device settings could not be detected correctly. You will need to configure these yourself.

并且点进去后，即使到达登陆界面，也无法输入，卡住不动。
