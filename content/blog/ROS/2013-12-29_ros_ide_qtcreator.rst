ROS开发环境之Qt Creator
#############################

:tags: turtlebot, ros, qt
:summary: 可以用于ROS开发的IDE很多（可以参考 http://wiki.ros.org/IDEs )，ROS的调试依赖环境变量，与外部程序有通讯，因此要求启动IDE的时候加载ROS环境参数，其他方面并无太多限制。最常用的IDE是eclipse，本人也是如此，eclipse调试环境的配置可以参照作者旧博客 `Configure Eclipse IDE in catkin of Ros Groovy <http://www.cnblogs.com/freedomshe/archive/2013/05/16/configure_eclipse_in_catkin.html>`_ ，Qt Creator比Eclipse要轻量级，配置起来也更方便简洁。本文记录ROS开发环境，Qt Creator的配置过程。

	环境：ROS Hydro, Qt Creator 5.2.0.

:icon: test1.jpg

.. contents:: 目录

QtCreator安装
=====================
QtCreator安装方式很多，本文以Qt 5.2.0为例，我直接下载离线安装程序安装。

下载安装
--------------
从http://qt-project.org/downloads下载QtCreator安装程序。对于Ubuntu 32位系统，点击 *Qt 5.2.0 for Linux 32-bit (425 MB)* 将下载离线安装程序（ *Qt Online Installer for Linux 32-bit (23 MB)* 为在线安装程序，不推荐），下载后的文件名为 *qt-linux-opensource-5.2.0-x86-offline.run*。

双击 *.run* 安装文件直接图形界面安装，默认安装在 */home/<user>/Qt5.2.0* 下（ *<user>* 为你的用户名，这里为 *viki* ）。

.. image:: {image}qtinstaller.jpg
    :alt: Qt Installer

按照指示一路Next即可安装完成。

安装完成后点左上角的 *Dash home*，输入“qt”如果看到 *Qt Creator* 图标则安装成功。

.. image:: {image}qt.jpg
    :alt: Qt Creator

设置快捷方式
--------------
这一步将要修改Qt Creator快捷方式，使从快捷方式启动Qt Creator的同时加载ROS环境变量。

打开terminal，输入下面的命令：

.. code-block:: ubuntu

	gedit ~/.local/share/applications/DigiaQtOpenSource-qtcreator.desktop

这条命令将打开DigiaQtOpenSource-qtcreator.desktop快捷方式文件，可以看到文件内容如下：

::
	
	[Desktop Entry]
	Type=Application
	Exec=/home/viki/Qt5.2.0/Tools/QtCreator/bin/qtcreator
	Name=Qt Creator (Opensource)
	GenericName=The IDE of choice for Qt development.
	Icon=QtProject-qtcreator
	Terminal=false
	Categories=Development;IDE;Qt;
	MimeType=text/x-c++src;text/x-c++hdr;text/x-xsrc;application/x-designer;application/vnd.qt.qmakeprofile;application/vnd.qt.xml.resource;text/x-qml;text/x-qt.qml;text/x-qt.qbs;

修改 *Exec* 变量一行，在中间添加 ``bash -i -c`` 即改为 ``Exec=bash -i -c /home/viki/Qt5.2.0/Tools/QtCreator/bin/qtcreator`` ，保存并退出。添加 ``bash -i -c`` 即是为了在通过快捷方式启动Qt Creator的同时加载ROS环境变量（ROS环境变量加载脚本配置在 *~/.bashrc* 文件内）。

.. warning:: 如果打开的文件是空，则表示没有找到DigiaQtOpenSource-qtcreator.desktop文件，可能是安装路径不在本地用户目录下，或者版本不同导致的文件名不一致。可以在 *~/.local/share/applications/* 和 */usr/share/applications/* 两个路径下用 ``ls *qt*`` 命令找找看。

.. tip:: 如果没有上述快捷方式文件，自己新建一个，只要文件内容类似上面的类容，路径正确即可。快捷方式可以放在 *~/.local/share/applications/* 和 */usr/share/applications/* 两个位置，当然也可以放在任意位置，功能一样但左边的任务栏不会正确显示图标。

用Qt Creator调试C++工程
========================
可以自己建立包做实验，为求简洁，这里直接从GitHub下载现有的源码包，即大家熟悉的 *ros_tutorials* 包。

新建catkin工作空间
-------------------
如果已经有自己的catkin工作空间则跳过，否则新建catkin工作空间：

.. code-block:: ubuntu

	mkdir -p ~/catkin_ws/src
	cd ~/catkin_ws/src
	catkin_init_workspace
	cd ~/catkin_ws/
	catkin_make
	echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc

对应解释参照《`配置ROS工作空间catkin+rosbuild <{filename}2013-12-20_overlay_catkin_and_rosbuild.rst>`_》。关闭所有的terminal在重新打开，使环境变量生效。

向catkin工作空间添加源码包
---------------------------
这里添加 *ros_tutorials* 源码包。

.. code-block:: ubuntu

	cd ~/catkin_ws/src
	git clone git@github.com:ros/ros_tutorials.git -b hydro-devel
	ls

可以看到下面的信息，表示 *ros_tutorials* 已经被下载到了 *~/catkin_ws/src* 目录下。

::

	viki@ROS:~/catkin_ws/src$ ls
	CMakeLists.txt  ros_tutorials

向Qt Creator里添加工程
-----------------------
从 *Dash home* 里启动Qt Creator，将看到下面的Welcome界面：

.. image:: {image}qt2.jpg
    :alt: Qt Creator

这里我们导入 *roscpp_tutorials* 包，使之成为工程。点击 **Open Project** 按钮，在弹出的对话框中选择 *~/catkin_ws/src/ros_tutorials/roscpp_tutorials/* 路径下的 **CMakeLists.txt** 文件，如下图：

.. image:: {image}qt3.jpg
    :alt: Qt Creator

点击 *Open*，将会出现编译路径选择对话框。这里要注意了，需要 *Browse* 将路径修改为 *~/catkin_ws/build/* 的路径，如下图：

.. image:: {image}qt4.jpg
    :alt: Qt Creator

点击 *Next* 后，在出现的对话框的 *Arguments* 一栏填入 ``-DCMAKE_BUILD_TYPE=Debug`` （不填后面将无法调试），然后点击 *Run CMake* 即可开始编译，结果如下图：

.. image:: {image}qt5.jpg
    :alt: Qt Creator

如果没有错误信息，则点击 *Finish* 完成，在 *Edit* 界面可以看到工程结构，可以开始编辑工程了。

调试
------
先打开一个terminal，输入 ``roscore`` 命令启动ROS Master。

在Qt Creator的 *Edit* 界面工程目录中，找到 *talker.cpp* 文件，找到 “hello world” 所在的位置，修改为 “hello I'm yuanboshe”，并设置断点，如下图：

.. image:: {image}test1.jpg
    :alt: Qt Creator

保存后，从左下角的工程面板里选择 *talker* 可执行程序项，然后按 **F5** 快捷键运行调试。稍等片刻，Qt Creator会需要一点时间编译所有程序，编译完成后，会运行到断点处停下来：

.. image:: {image}test2.jpg
    :alt: Qt Creator

取消断点，按 **F5** 继续运行，在弹出的 *Application Output* 界面能够看到修改后的信息，如下：

.. image:: {image}test3.jpg
    :alt: Qt Creator

回到桌面，再开一个terminal窗口，输入 ``rosrun roscpp_tutorials listener`` 命令，可以看到正确的监听消息，如下图：

.. image:: {image}test4.jpg
    :alt: Qt Creator

关于Debug问题
--------------
如果之前在CMake的时候没有填写 ``-DCMAKE_BUILD_TYPE=Debug`` 参数，则编译出来的程序不可用于调试。按下调试快捷键 **F5** 的时候，可能会出现下面的警告信息：

::

	This does not seem to be a "Debug" build.
	Setting breakpoints by file name and line number may fail.

	Section .debug_info: Not found.
	Section .debug_abbrev: Not found.
	Section .debug_line: Not found.
	Section .debug_str: Not found.
	Section .debug_loc: Not found.
	Section .debug_range: Not found.
	Section .gdb_index: Not found.
	Section .note.gnu.build-id: Found.
	Section .gnu.hash: Found.
	Section .gnu_debuglink: Not found.

可以通过左边的"Projects"->"Run CMake"重新设置参数，并make，如下图：

.. image:: {image}debug.jpg
    :alt: ROS debug
