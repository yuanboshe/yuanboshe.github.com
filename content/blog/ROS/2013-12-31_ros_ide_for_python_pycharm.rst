ROS开发环境之PyCharm (python)
#############################

:tags: turtlebot, ros, python
:summary: 可以用于ROS开发的IDE很多（可以参考 http://wiki.ros.org/IDEs )，ROS的调试依赖环境变量，与外部程序有通讯，因此要求启动IDE的时候加载ROS环境参数，其他方面并无太多限制。身为编译语言的C++，常常需要IDE的辅助，否则难以完成编写和调试；而身为脚本语言的Python，随写随测，很多写手不需要IDE辅助，只是用GDB除错器就能完成调试。为了可视化的调试，以及设置断点（breakpoint），使用IDE还是很有必要的。在ROS社区，讨论最多的IDE恐怕就是eclipse了，不仅可以作为C++项目的IDE，也可以结合pydev来调试python项目。PyCharm是本人最喜欢的python IDE，不仅有Windows版本，还有Linux版本，但在ROS社区暂时还没发现有人讨论PyCharm，本文介绍用PyCharm调试ROS配置流程。

	环境：ROS Hydro, PyCharm 3.0.2, Ubuntu 12.04.

:icon: test3.jpg

.. contents:: 目录

PyCharm安装
=====================
PyCharm是个多平台的python IDE，还支持Javascript, HTML, Jinja2, reStructuredText 等语言的编辑。我在PyCharm的支持下修改基于Pyhon的Pelican静态站点生成器，制作自己的Jinja2模板，才完成了github博客系统，因此对PyCharm情有独钟。

下载安装
--------------
从PyCharm官网下载安装程序：http://www.jetbrains.com/pycharm/download/。选择Linux版本，目前有Professional和Community两个Linux版本，前者是付费版，30天免费试用期限，后者是免费版，阉割部分功能。一般使用免费版就行了，我比较喜欢折腾，用的付费版，本文以Professional版本为例，下载后的文件名为 *pycharm-professional-3.0.2.tar.gz*。（付费版激活码自行Google:)）

打开terminal，进入 *pycharm-professional-3.0.2.tar.gz* 所在路径。我习惯将程序装在 *~/programs/* 路径下，如果没有 *~/programs/* 先用 `mkdir ~/programs` 命令创建之。然后运行下面的命令：

.. code-block:: ubuntu

	tar xfz pycharm-professional-3.0.2.tar.gz -C ~/programs
	cd ~/programs/pycharm-3.0.2/bin/
	./pycharm.sh 

第一条命令将 *pycharm-3.0.2* 解压到 *~/programs/* 路径下；第二条命令进入 *~/programs/pycharm-3.0.2/bin/* 路径；第三条命令则启动PyCharm，如果是第一次启动，则自动进入安装步骤，按照安装步骤完成安装即可。

安装完成后点左上角的 *Dash home*，输入“py”如果看到 *PyCharm* 图标则安装成功。

.. image:: {image}pycharm1.jpg
    :alt: PyCharm

设置快捷方式
--------------
这一步将要修改PyCharm快捷方式，使从快捷方式启动PyCharm的同时加载ROS环境变量。

打开terminal，输入下面的命令：

.. code-block:: ubuntu

	gedit ~/.local/share/applications/jetbrains-pycharm.desktop

这条命令将打开jetbrains-pycharm.desktop快捷方式文件，可以看到文件内容如下：

::
	
	[Desktop Entry]
	Version=1.0
	Type=Application
	Name=PyCharm
	Icon=/home/viki/programs/pycharm-3.0.2/bin/pycharm.png
	Exec=bash -i -c "/home/viki/programs/pycharm-3.0.2/bin/pycharm.sh" %f
	Comment=Develop with pleasure!
	Categories=Development;IDE;
	Terminal=false
	StartupWMClass=jetbrains-pycharm

修改 *Exec* 变量一行，在中间添加 ``bash -i -c`` 即改为 ``Exec=bash -i -c "/home/viki/programs/pycharm-3.0.2/bin/pycharm.sh" %f`` ，保存并退出。添加 ``bash -i -c`` 是为了在通过快捷方式启动PyCharm的同时加载ROS环境变量（ROS环境变量加载脚本配置在 *~/.bashrc* 文件内）。

.. warning:: 如果打开的文件是空，则表示没有找到jetbrains-pycharm.desktop文件，可能是安装路径不在本地用户目录下，或者版本不同导致的文件名不一致。可以在 *~/.local/share/applications/* 和 */usr/share/applications/* 两个路径下用 ``ls *pycharm*`` 命令找找看。

.. tip:: 如果没有上述快捷方式文件，自己新建一个，只要文件内容类似上面的类容，路径正确即可。快捷方式可以放在 *~/.local/share/applications/* 和 */usr/share/applications/* 两个位置。当然也可以放在任意其他位置，功能跟放在上面两个位置一样，但左边的任务栏不会正确显示图标。

用PyCharm调试Python工程
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

向PyCharm里添加工程
-----------------------
从 *Dash home* 里启动PyCharm，将看到下面的Welcome界面：

.. image:: {image}pycharm2.jpg
    :alt: PyCharm

这里我们导入 *rospy_tutorials* 包，使之成为PyCharm的python工程。点击 **Open Directory** 按钮，在弹出的对话框中选择 *~/catkin_ws/src/ros_tutorials/rospy_tutorials/* 路径，如下图：

.. image:: {image}pycharm3.jpg
    :alt: PyCharm

点击 *OK*，工程将被创建，如下图：

.. image:: {image}pycharm4.jpg
    :alt: PyCharm

设置python2.7为PyCharm工程的Interpreter
----------------------------------------
PyCharm默认将Python 3.2设置为工程的interpreter，而ROS使用的是Python 2.7，这里需要设置一下，使用Python 2.7，否则无法运行ROS相关的Python库。

*File* 菜单 -> *Settings* 项，打开设置对话框，选择 *Project Interpreter* -> *Python Interpreters* 如下图：

.. image:: {image}setting1.jpg
    :alt: PyCharm

点击右边选框的加号，增加 *Python 2.7 Interpreter*，并将其设置为工程默认，结果如下图：

.. image:: {image}setting2.jpg
    :alt: PyCharm

调试
------
先打开一个terminal，输入 ``roscore`` 命令启动ROS Master。

在PyCharm左边的 *Project* 树形框中，找到 *talker.py* 文件，打开。然后找到 “hello world” 所在的位置，修改为 “hello I'm yuanboshe”，并设置断点，如下图：

.. image:: {image}test1.jpg
    :alt: PyCharm

保存后，右键左边的 *talker.py* 文件，弹出右键菜单，选择 *Debug 'talker'* 项：

.. image:: {image}test2.jpg
    :alt: PyCharm

启动调试后，*talker* 程序就会运行，并会运行到断点处停下来：

.. image:: {image}test3.jpg
    :alt: PyCharm

在下面的变量栏能够看到变量值。取消断点，按 **F9** 继续运行，将下面的显示窗口切换到 *Console* 窗口，能够看到修改后的信息，如下：

.. image:: {image}test4.jpg
    :alt: PyCharm

回到桌面，再开一个terminal窗口，输入 ``rosrun rospy_tutorials listener`` 命令，可以看到正确的监听消息，如下图：

.. image:: {image}test5.jpg
    :alt: PyCharm

最后
=====
作为脚本语言的Python，debug要比作为编译语言的C++方便简单得多，其他的Python IDE也可以使用类似方式使之能够用来调试ROS工程。由于缺少了编译环节，不需要CMake的参与，无论是catkin工程还是rosbuild工程都一样的设置，没有差异。