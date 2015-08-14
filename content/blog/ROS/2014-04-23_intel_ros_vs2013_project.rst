10分钟上手玩ROS仿真机器人
##############################

:tags: exbotxi, ros
:summary: 没钱买ROS移动机器人平台？那就玩玩免费的ROS仿真机器人平台吧！ROS里面玩仿真机器人是很容易的事情，但从0开始配置到能玩ROS仿真机器人是很麻烦的，新手想凭自己的Search能力玩起来，先磨几个月再考虑吧。10分钟上手玩不是玩笑，下载好Ubuntu for ROS开发版后，如果使用虚拟机预览模式进入系统，10分钟都不要就能上手玩！

	环境：Windows, VMWare Workstation 10.0, Ubuntu for ROS h2-140330.

:status: draft

.. contents:: 目录

win_ros的VS工程
======================
参考：http://wiki.ros.org/win_ros/hydro/Msvc%20SDK%20Projects

0.1 新建控制台应用程序

1. 项目属性：
输出目录：..\..\..\devel\lib\intel_ros
中间目录：..\temp
目标文件名：<node_name>

6. vc10 编译

4. Debugging Environment
添加：
ROS_MASTER_URI=http://localhost:11311
PATH=C:\opt\rosdeps\hydro\x86\lib;C:\opt\rosdeps\hydro\x86\bin;C:\opt\ros\hydro\x86\lib;C:\opt\ros\hydro\x86\bin;$(Path)
$(LocalDebuggerEnvironment)

除了添加 PATH外，还要添加ROS_MASTER_URI=http://localhost:11311。多变量可能添加不成功，需要参考 http://connect.microsoft.com/VisualStudio/feedback/details/739477/visual-c-2010-set-multiple-variables-for-project-debug-environment 中的说法，是VS里面的换行在.user文件里面变成了tab的缘故，需要手动改为CR LF间隔

.. code-block:: text

	CR LF should be escaped in the .user file
	see also: http://www.w3.org/TR/2004/REC-xml-20040204/#sec-references

	- close project
	- edit and save .user file in text editor:
	<LocalDebuggerEnvironment>foo1=bar1
	foo2=bar2</LocalDebuggerEnvironment>
	- open project 
		
2. 重新编译intel的两个lib，用与ROS统一的vc编译器和运行时库编译：项目属性 -> C/C++ -> 代码生成 -> 运行库

3. 导入intel_ros属性表 



5. 取消预编译头


voicesynthesis 需要加入winmm.lib
voiceRecognition 需要加入 ../common 目录



win_ros在vs2013下编译
=========================
参考： http://wiki.ros.org/win_ros/hydro/Msvc%20Compiled%20SDK

1. 除windows sdk 7.1 外其他都安装

1-2. 把git加入环境变量，如：C:\Program Files (x86)\Git\bin;C:\Program Files (x86)\Git\cmd

否则会出现找不到git的问题：

	'git' is not recognized as an internal or external command,operable program or batch file.
	
1-3. cmd中执行编码设置（windows默认GBK）否则python命令会出问题，如：

	'utf8' codec can't decode byte 0xb2 in position 6: invalid start byte

chcp 65001  就是换成UTF-8，在命令行标题栏上点击右键，选择"属性"->"字体"，将字体修改为True Type字体"Lucida Console"，然后点击确定将属性应用到当前窗口

如果还报错，就用美国英语编码：chcp 437 是美国英语
	  
chcp 936 可以换回默认的GBK 

2. winros_init_workspace --track=hydro ws

winros_init_workspace.py 在D:\Python\Python27\Scripts内，可以看到操作

如果不成功，catkin空间没有init起来，参照 http://wiki.ros.org/win_ros/hydro/Msvc%20Overlays 手动建立catkin workspace，然后把win_ros源码src靠过去

4. fix catkin_install_python

修改 D:\ros_ws\src\common_msgs\actionlib_msgs\CMakelist.txt 里面的catkin_install_python，改为install，否则会出错

5. 重编译tinyxml.lib

来到 D:\ros_ws\src\win_ros\rosdeps\win_tinyxml 执行 make compile命令编译，把编译好的tinyxml.lib覆盖 C:\opt\rosdeps\hydro\x86\lib 的tinyxml.lib。否则会有下面的错误

	error LNK2038: mismatch detected for '_MSC_VER': value '1600' doesn't match value '1800' 
	
	
detail steps of compile win_ros
=====================================

1. open cmd

	> mkdir C:\work
	> cd C:\work
	> winros_init_workspace --track=hydro ws

2. 修改 setup.bat 在最下面添加：call "D:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\vcvarsall.bat"

3. 

	> cd C:\work\ws
	> setup
	> winros_init_build --track=hydro
	# Parse and edit config.cmake to configure build settings
	# especially CMAKE_BUILD_TYPE if you want to build Debug
	> winros_make
	# Optional install step
	> winros_make --install

4. winros_make 错误的解决：

	CMake Error at common_msgs/actionlib_msgs/CMakeLists.txt:19 (catkin_install_pyth
	on):
	Unknown CMake command "catkin_install_python".

修改 D:\ros_ws\src\common_msgs\actionlib_msgs\CMakelist.txt 里面的catkin_install_python，改为install

5. 编译boost
