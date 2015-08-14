ROS开发环境之Eclipse (C/C++ & python)
######################################

:tags: turtlebot, ros, python, cpp
:summary: 可能绝大部分人都习惯用Eclipse来做开发吧，可谓ROS开发No.1的IDE。2013年的时候写过一篇配置Eclipse的文章，现在再次总结一下。

	环境：ROS Hydro, Ubuntu 12.04, Eclipse for C/C++ Kepler.

:status: draft

.. contents:: 目录

准备工作
=====================
安装JDK
---------
安装JDK，Ubuntu系统中默认不附带常规JDK，而是OpenJDK，需要自己安装常规JDK，这里装最新的JDK8。

.. code-block:: ubuntu

	sudo add-apt-repository ppa:webupd8team/java
	sudo apt-get update
	sudo apt-get install oracle-java8-installer

安装Eclipse for C/C++
----------------------
从官网下载Eclipse for C/C++，（http://www.eclipse.org/downloads/ 从链接进去，选择Linux 32 bit版本），如 *eclipse-cpp-kepler-SR2-linux-gtk.tar.gz* ，放在 *~/Downloads/* 文件夹下。使用下面的命令解压“安装”：

.. code-block:: ubuntu

	sudo tar vxzf eclipse-cpp-kepler-SR2-linux-gtk.tar.gz -C /usr/local
	cd /usr/local
	sudo chown -R exbot:exbot eclipse


创建快捷方式
-------------
打开terminal，输入命令：

.. code-block:: ubuntu

	sudo gedit /usr/share/applications/eclipse.desktop

将打开gedit编辑器，贴入下面的代码：

.. code-block:: ymal

	[Desktop Entry]
	Version=1.0
	Type=Application
	Name=Eclipse
	Icon=/usr/local/eclipse/icon.xpm
	Exec=bash -i -c "/usr/local/eclipse/eclipse"
	Comment=Develop with pleasure!
	Categories=Development;IDE;
	Terminal=false

完成后在Dash菜单输入 *eclipse* 将会看到Eclipse图标，以后启动eclipse都从快捷方式启动。

.. tip:: 使用 *gedit* 一般会留下一个带 *\*.\*~* 的备份文件，使用命令 ``sudo rm -f /usr/share/applications/eclipse.desktop~`` 删除。

下载测试代码
-------------
.. code-block:: ubuntu

	cd catkin_ws/src
	git clone https://github.com/yuanboshe/exbot_xi.git

配置Eclipse (C/C++)
=====================

生成工程文件
--------------
.. code-block:: ubuntu

	cd ~/catkin_ws
	catkin_make --force-cmake -G"Eclipse CDT4 - Unix Makefiles" -DCMAKE_BUILD_TYPE=Debug -DCMAKE_ECLIPSE_MAKE_ARGUMENTS=-j8

导入工程
---------
File --> Import --> Existing projects into workspace

"Select root directory" 选择 *~/catkin_ws/build* ，"Finish" 结束。

Fix "Invalid arguments" 等问题
-------------------------------
Project -> Properties -> C/C++ General -> Preprocessor Include Paths, Macros etc. -> Providers 选上 CDT GCC Built-in Compiler Settings

Project -> Index -> Rebuild

测试
------
Ctrl + B build工程

打开terminal，输入 ``roscore`` 启动ROS master

Debug Configurations -> C/C++ Application -> Browse -> ".../catkin_ws/devel/lib/exbotxi_example/control"

源码位于：[Source directory]/exbot_xi/exbotxi_example/nodes/control.cpp

可以看到启动信息，调试正常。

配置Eclipse (Python)
=====================
安装PyDev
-----------
设置代理，国内被墙无法更新。

Help -> Install New Software··· -> Add

Name: PyDev  
Location：http://pydev.org/updates

选择 PyDev for Eclipse -> Next ... Finish 后等待安装完成，完成后会要求重启。

配置PyDev
----------
重启后需要对PyDev进行配置。

Window -> Preferences -> PyDev -> Interpreters -> Python Interpreter -> New -> Browse...

填入路径：/usr/bin/python2.7

确认。

测试
------
修改Project名字，改为 "exbot" （名字不能包含 *@* 等字符）。

打开terminal，输入 ``roscore`` 启动ROS master

源码位于：[Source directory]/exbot_xi/exbotxi_example/nodes/control.py

打开源码，右键 Debug As -> Python Run

可以看到启动信息，调试正常。

一些有用的ROS插件
==================
CMake Editor
--------------
Help -> Install New Software··· -> Add

Name: CMake Editor  
Location：http://cmakeed.sourceforge.net/eclipse/

Rinzo XML Editor
------------------
Help -> Eclipse Marketplace... -> Search "Rinzo XML Editor" -> Install

只安装 Rinzo XML Editor Core 就行了。

YEditor
--------
Help -> Eclipse Marketplace... -> Search "YEdit" -> Install

优化工作
==========
增加文件关联
-----------------
Window -> Preferences -> Gerneral -> Editors -> File Associations

关联至 Rinzo XML Editor：\*.launch, \*.concert, \*.xacro, \*.urdf  

关联至 YEdit：\*.rviz

增加ROS Formatting
-------------------
将我的 cpp format 文件 "Eclipse_format_yuanboshe.xml" 拷贝到Ubuntu。

Window -> Preferences -> C/C++ -> Code Style -> Formatter -> Import...

增强显示效果
-------------
Window -> Preferences -> General -> Editors -> Text editors

Check: show line numbers, insert space for tabs, show whitespace characters

Window -> Preferences -> Rinzo XML -> Formatting

Indentation size: 2    
Line width: 160  
Select: Indent using spaces  
Check: show line numbers  

快捷键
----------
Window -> Preferences -> Gerneral -> Keys  

Remove Trailing Whitespace -> ctrl+shift+D "In Windows"













