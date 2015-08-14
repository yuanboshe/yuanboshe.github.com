10分钟安装ROS（U盘/CD刻录盘 + 裸机）2015-07-19更新
#########################################################

:tags: aicroboxi, ros
:authors: Yuanbo She
:summary: 距离上次写这篇经验分享帖已经16个月了，玩ROS的熟手越来越多，但过时和不负责的转载依旧对新手造成困扰。总结这十几个月朋友们遇到的问题，更新本贴！废话少说，旧帖参考《`10分钟安装ROS（U盘/CD刻录盘 + 裸机） <2014-03-install_ros_in_10mins_pc.html>`_》，本文简介裸机中安装Ubuntu for ROS的方法，虚拟机中安装Ubuntu for ROS请参考《`10分钟安装ROS（Windows + 虚拟机）2015-07-19更新 <2015-07-install_ros_in_10mins_vm_new.html>`_》教程。

    工具：UltraISO 9.6.2.3059, Ubuntu for ROS iso.

.. contents:: 目录

准备工作
============

所谓“裸机”安装，是指在PC机中安装全新的操作系统，可以在PC机中作为独立的操作系统存在，也可以与Windows等操作系统组成双系统/多系统。

Ubuntu for ROS 发行版下载后是iso文件，可以按照安装Ubuntu的方式进行安装，例如制作成Live CD在没有操作系统的计算机上安装，或者直接导入虚拟机进行安装，非常方便。本文在虚拟机VMWare中安装只需要10分钟即可完成，这里介绍U盘安装方法，刻录CD安装类似。虚拟机中安装请参考《`10分钟安装ROS（Windows + 虚拟机）2015-07-19更新 <2015-07-install_ros_in_10mins_vm_new.html>`_》。

准备材料：

* 下载Ubuntu for ROS，例如下载UROS1404I64DEV_aicrobo_150715，下载后是UROS1404I64DEV_aicrobo_150715.iso文件。正式Ubuntu for ROS发行版集合页面《`Ubuntu for ROS <http://aicrobo.github.io/ubuntu_for_ros.html>`_》。
* 下载UltraISO并安装，本文使用的是UltraISO 9.6.2.3059。

制作Ubuntu U盘启动盘
=====================

打开UltraISO，文件 -> 打开 -> 选择下载的Ubuntu for ROS iso文件：

.. image:: {image}iso1.jpg
	:alt: iso1

插入U盘，启动 -> 写入硬盘印象...，写入方式选择“USB-ZIP+ v2”，格式化U盘，然后写入即可：

.. image:: {image}iso2.jpg
	:alt: iso2

.. note:: 经常有人问制作的U盘启动盘在自己的机器上无法启动，主要原因是制作的启动盘与主板BIOS兼容性问题，解决方案如下。

    1. 使用8G或者以上的U盘制作（8G，16G试验均可），不要使用4GU盘制作（兼容太差）。
    2. 写入方式选择USB-HDD+ v2，或者USB-ZIP+ v2，这两种方式的兼容性比较强。

至此，将会看到名为“UROS1404I64”的U盘启动盘，制作完成。

裸机安装
===========
将U盘启动盘插入PC机，然后开机。PC机主板上电后按下快捷键进入启动介质选择界面，选择对应的U盘启动。

.. tip:: 不同的主板BIOS设置一般不同，快捷键位（一般在F1~F12里面）也不一样，多尝试几个按键。快捷键通常会有两个功能：一个用于进入BIOS，一个用于进入启动介质选择界面。

完成后，将U盘插入要装Ubuntu for ROS的计算机，重启。如果没有从U盘启动，就需要设置一下BIOS启动顺序，进入BIOS，第一启动项设置为USB方式启动。

后面的安装过程参考《`10分钟安装ROS（Windows + 虚拟机）2015-07-19更新 <2015-07-install_ros_in_10mins_vm_new.html>`_》，基本上一样。

.. tip:: 笔记本安装时卡在选择头像的地方无法继续，此问题在新版本中已经解决。填写用户名和密码可以随便填（不会生效），但主机名会生效，所有发布版本默认用户名和密码均为 **aicrobo** 。