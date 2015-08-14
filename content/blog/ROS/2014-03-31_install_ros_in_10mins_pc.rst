10分钟安装ROS（U盘/CD刻录盘 + 裸机）
######################################

:tags: exbotxi, ros
:summary: 无论你是ROS新手还是ROS老鸟，重新安装ROS都是一件很头疼的事情。完全版有2G多内容需要更新，网络状况不好时可能一两天才能装完，而对于新手来说钻研几个月也不见得能配出完美的开发环境，毕竟官方wiki的资料并不完善，还有很多细节需要处理。而Ubuntu for ROS正是解决这些问题的好办法，下载完Ubuntu for ROS后，10分钟即可完成安装，安装完成后可以立即做ROS学习，开发。本文简介裸机中安装Ubuntu for ROS的方法，虚拟机中安装Ubuntu for ROS请参考《10分钟安装ROS（Windows + 虚拟机）》教程。

	工具：UltraISO 9.5.3.2901.

.. contents:: 目录

准备工作
============
Ubuntu for ROS 发行版下载后是iso文件，可以按照安装Ubuntu的方式进行安装，例如制作成Live CD在没有操作系统的计算机上安装，或者直接导入虚拟机进行安装，非常方便。笔者在虚拟机VMWare中安装只需要10分钟即可完成，这里介绍U盘安装方法，刻录CD安装类似。虚拟机中安装请参考《10分钟安装ROS（Windows + 虚拟机）》

首先从发行版集合页面下载Ubuntu for ROS发行版，例如下载ubuntu12.04-ros-by-exbot-h140317，下载后是ubuntu12.04-ros-by-exbot-h140317.iso文件。

再下载UltraISO，笔者使用的是UltraISO 9.5.3.2901，只有一个exe文件即可使用。

制作Ubuntu U盘启动盘
=====================

打开UltraISO，文件 -> 打开 -> 选择下载的Ubuntu for ROS iso文件：

.. image:: {image}iso1.jpg
	:alt: iso1

插入U盘，启动 -> 写入硬盘印象...，写入方式选择“USB-ZIP”，便携启动 -> 写入新的硬盘主引导记录(MBR) -> USB-ZIP+，确认后点写入即可：

.. image:: {image}iso2.jpg
	:alt: iso2

完成后，将U盘插入要装Ubuntu for ROS的计算机，重启。如果没有从U盘启动，就需要设置一下BIOS启动顺序，进入BIOS，第一启动项设置为USB方式启动。

后面的安装过程不用说了，一路Next就可以了，类似虚拟机中的安装过程，填写用户名和密码可以随便填，不会生效的，用户名和密码依然是 **exbot** 。