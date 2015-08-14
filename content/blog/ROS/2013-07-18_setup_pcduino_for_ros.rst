PcDuino入手设置流程（for ROS）
#################################

:tags: pcduino, ros
:summary:
    环境：Windows7 64位。

    这里pcDuino的设置是为安装ROS，故所有流程为在microSD卡内刷Lubuntu的流程。为了在pcDuino里面装ROS，需要准备一张4G（最好大于4G）的microSD卡，pcDuino的NAND flash只有2G，装Lubuntu后只剩几百M，不够装ROS使用。

.. contents:: 目录

1. 入手配件一览
=======================================
入手pcDuino的时候，有些配件是必须的，如:

1) 5V2A直流电源。pcDuino外接键盘鼠标启动的时候大概800mA的电流峰值，作一般用途，使用1A的电源或者电脑的USB也够了，但最好还是2A电源保险。
2) USB-microUSB数据线。此数据线不仅用于pcDuino的OTG口传输数据，还用于DCPOWER口供电（OGT口也能供电，但最好不要经常使用它供电）。
3) HDMI视频线。HDMI，VGA，DVI是常见的几种视频（视音）数据接口，这几种接口长什么样自行谷歌。pcDuino的视频输出接口是HDMI，而一般的电脑显示器的视频输入接口会有VGA和DVI的接口，如果想让pcDuino输出的视频信号被显示出来，需要购买对应的HDMI转VGA(DVI)的数据线。
4) microSD卡 + 读卡器。pcDuino的2G NAND flash不够装ROS以及一些包，最好准备一张class 10的8G（或者以上）的SD来装系统。

.. image:: {image}devices.jpg
    :alt: 一些设备

此外，还有一些外围设备是需要准备的，如：

1) 显示器。否则无法看到pcDuino的内部状态，如果无法通过HDMI输出pcDuino的内部状态，使用USB-TTL线将pcDuino的debug串口与PC机连接，也能看到pcDuino的内部状态，这里不讨论。
2) 鼠标 + 键盘。插到pcDuino的USB口上即可使用。后期透过网络SSH也能使用PC上的VNC工具操作pcDuino，但初次安装没有键盘是无法操作联网的。
3) 网线。联网更新，PC通过VNC工具访问等都需要。
4) USB Hub。以后可能会出现pcDuino的USB端口不够用的情况。

2. 设置流程
=========================================

2.1. 刷Kernel
---------------
下载LiveSuit:
`Windows (32-bit) <http://pan.baidu.com/share/link?shareid=3444498833&uk=774611580>`_ 或 `Windows (64-bit) <http://pan.baidu.com/share/link?shareid=3443290713&uk=774611580>`_

下载完后放在新建的文件夹 ``LiveSuit`` 内，双击后会自动解压到当前文件夹并安装驱动。

.. image:: {image}livesuit.jpg
    :alt: LiveSuit

.. _pcDuino官网下载页面: http://www.pcduino.com/?page_id=14

进入 `pcDuino官网下载页面`_ , 下载 `Ubuntu NAND Image Kernel (use LiveSuite or PhoenixCard) <https://s3.amazonaws.com/pcduino/Images/2013-09-06/pcduino_a10_kernel_livesuit_20130906.img>`_
下载后的文件名为 ``pcduino_a10_kernel_livesuit_20130906.img``

双击 ``LiveSuit.exe`` 启动LiveSuit，会提示是否进入向导，选否跳出。
点击 ``选择固件`` 选择之前下载的Kernel img ``pcduino_a10_kernel_livesuit_20130906.img`` 。

.. image:: {image}livesuit2.jpg
    :alt: LiveSuit V1.07

先将microUSB头插到pcDuino的OTG口（板子上有两个microUSB口，一个是OTG数据口，一个是供电口），然后按住板子的SW2按键，将USB数据线的另一端插入电脑。

.. image:: {image}pcduino.jpg
    :alt: PcDuino

.. note:: 按住板子的SW2按键后再将另一端插入电脑，如果没有反应，换个PC机上的USB端口再试，直至出现驱动安装成功提示。

    .. image:: {image}driver.jpg
        :alt: pcDuino驱动安装成功

随后，已经打开了的LiveSuit会自动检测到设备，并弹出提示信息框，问是否强制格式化。选“是”，将格式化NAND，进入格式化升级，完成升级后会提示升级成功信息。退出LiveSuit。

.. image:: {image}livesuit3.jpg
    :alt: LiveSuit

2.2. 刷Lubuntu
------------------
下载 `Win32 Disk Imager <http://sourceforge.net/projects/win32diskimager>`_ 解压。

下载 `Ubuntu microSD Bootable Image <https://s3.amazonaws.com/pcduino/Images/2013-05-31/pcduino_ubuntu_mmc_20130531.7z>`_ 。
文件比较大，为Lubuntu系统的镜像文件，下载后文件名为 ``pcduino_ubuntu_mmc_20130531.7z`` ，解压出 ``pcduino_ubuntu_mmc_20130531.img`` 。据说以后都会基于这个版本在线升级，不会再提供更新的image版本了。

将microSD卡通过读卡器接入电脑，这一步要将上面的Lubuntu img刷进microSD卡内。启动Win32 Disk Imager，“Image File”里选择刚才解压出来的“pcduino_ubuntu_mmc_20130531.img”，“Device”一览选microSD卡的盘号。
点击“Write”按钮会出现提示框，确认后就开始将Lubuntu img写入SD卡了。成功写完后会出现提示信息，确认并退出。

.. image:: {image}win32diskimager.jpg
    :alt: Win32 Disk Imager

2.3. 启动Lubuntu
------------------
用HDMI线将pcDuino和显示器连起来，将鼠标和键盘连到pcDuino的两个USB端口上。取出microSD卡，插进pcDuino的microSD卡槽内，将数据线的microUSB头从pcDuino的OTG口拔出，插到另一端的DCPOWER口内，然后数据线的另一端USB头接到5V2A直流电源上。

此时，应该能够在屏幕上看到Lubuntu的启动画面了。pcDuino第一次启动会进入蓝屏的“Board Configuration”界面，配置好分辨率后选择“Done”完成配置，一会儿就能看到Lubuntu的系统界面了。

.. image:: {image}lubuntu1.jpg
    :alt: Board Configuration

.. image:: {image}lubuntu2.jpg
    :alt: Lubuntu

2.4. SD卡扩容
--------------
通过Lubuntu桌面上的“Disk Utility”工具可以看到，SD卡挂载在 ``/`` 上的分区只有1.9G，而SD卡的另外30G空间没有挂载出来。要装ROS，以及其他一些东西，系统盘1.9G肯定是不够用的，现在关键的一步
就是将系统盘扩容。

.. image:: {image}lubuntu3.jpg
    :alt: Lubuntu

通过桌面上的“LXTerminal”打开终端（Terminal），输入 ``sudo board-config.sh`` 打开板子的配置界面，选择“expand_rootfs”，一路确认后退出Board Configuration界面，会提示自动重启信息。
自动重启后会在resize执行界面停留几分钟，完后再进“Disk Utility”就能看到SD卡上剩余的空间全部并入root分区内了。

.. image:: {image}lubuntu4.jpg
    :alt: Disk Utility

.. note:: 使用pcDuino的"expand_rootfs"会将SD卡剩下空间全部扩到root分区里面，如果想自定义分区，可以使用Linux下的"GParted"工具划分。但一般也没这个必要吧，所有空间都挂在"/"下，安逸。

2.5. 联网更新
--------------
将网线插入pcDuino，打开Terminal，输入 ``ifconfig`` 可以查看本地IP地址，使用 ``ping`` 命令或者浏览器确认网络是连接状态。

.. image:: {image}lubuntu5.jpg
    :alt: ifconfig

``sudo board-config.sh`` 进入Board Configuration界面，选择最下面的“Update” -> “all” 更新pcDuino软件，大约10分钟左右能更新完。

.. image:: {image}lubuntu6.jpg
    :alt: Update all

3. END
=========

.. tip:: pcDuino 0531Lubuntu镜像的默认用户和密码都是 ``ubuntu``

至此，在pcDuino内安装ROS的准备工作已经完成，安装ROS Groovy参考《`在pcDuino内安装ROS Groovy <{filename}2013-07-20_install_ros_groovy_in_pcduino.rst>`_》