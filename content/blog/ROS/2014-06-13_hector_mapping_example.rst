用hector mapping构建地图
#############################

:tags: ros, ubuntu_for_ros, exbotxi
:summary: 本文介绍如何在Ubuntu for ROS中配置Hokuyo（或者是rplidar），运行hector slam中的mapping示例代码。示例代码包含在exbot_xi开发包中，Ubuntu for ROS开发版已经包含此开发包。

.. contents:: 目录

安装配置LiDar
===============
exbot_xi内置了Hokuyo和rplidar的启动程序，可以根据自己的LiDar型号来选择。其中Hokuyo不需要进行任何设置即可驱动，如果使用的是rplidar，需要编译rplidar的驱动程序。

rplidar的配置
--------------
rplidar的ROS端配置可以参考 https://github.com/yuanboshe/exbot_sensors 的相关配置说明，或者直接看本网接下来的流程说明。

rplidar的ROS端驱动封装放在exbot_sensors开发包内，需要先下载exbot_sensors包。打开terminal，输入下面的代码即可：

.. code-block:: ubuntu

	cd ~/catkin_ws/src/
	git clone https://github.com/yuanboshe/exbot_sensors.git

要使用rplidar还需要编译rplidar的sdk，从rplidar官方网站下载sdk（http://rplidar.robopeak.com/download.html），如 *rplidar_sdk_v1.4.2.7z* 解压并拷贝到Ubuntu for ROS中，如拷贝后为 */home/exbot/rplidar_sdk_v1.4.2* 。

.. note:: sdk的版本号请根据实际情况加以修改，本文以老版本的驱动号为例。

然后执行下面的命令对rplidar的sdk进行编译：

.. code-block:: ubuntu

	cd ~/rplidar_sdk_v1.4.2/sdk/sdk/
	make

执行命令 ``gedit ~/catkin_ws/src/exbot_sensors/rplidar/CMakeLists.txt`` 打开rplidar ROS端封装的编译配置文件，找到 *set(RPLIDAR_DIR /home/exbot/rplidar_sdk_v1.4.1/sdk)* 一行，将路径改正确（如版本号改为1.4.2）。

接下来使用下面的命令编译rplidar的ROS端驱动：

.. code-block:: ubuntu

	cd ~/catkin_ws/
	catkin_make --pkg rplidar

通用配置
----------
exbot_xi开发包选择使用的LiDar型号是通过环境中的 *SENSOR_2D* 参数进行选择的，*SENSOR_2D* 参数可以是 ``rplidar`` 或者是 ``hokuyo`` 。设置方法如下：

输入命令 ``gedit ~/.bashrc`` 打开 **.bashrc** 文件，在最下面添加 ``export SENSOR_2D=rplidar`` 一行即可将参数设置为 ``rplidar`` 。

测试LiDar
==========

rplidar接入
-------------
将rplidar接入Ubuntu for ROS开发版系统内部，输入命令 ``ls /dev/ttyUSB*`` 查看USB端口占用情况，结果可能如下所示：

	exbot@ubuntu:~$ ls /dev/ttyUSB*  
	/dev/ttyUSB0  
	exbot@ubuntu:~$   
	
如果只有一个USB接入设备，那么rplidar的接入端口就是上面显示的 **/dev/ttyUSB0**，记录下来。

输入命令 ``gedit catkin_ws/src/exbot_xi/exbotxi_bringup/launch/include/rplidar_2d_sensor.launch.xml`` 打开rplidar的配置文件，找到 *<param name="com_path" type="string" value="/dev/ttyUSB1" />* 一行，将其中的 *value* 值改为刚才找到的端口路径 **/dev/ttyUSB0** 然后保存。

Hokuyo接入
-------------
hokuyo的端口默认是 **/dev/ttyACM0** 一般不会出现冲突，接入系统即可使用。
      
启动测试
----------
打开4个terminal，分别输入下面的命令：

.. code-block:: ubuntu

	roscore
	roslaunch exbotxi_bringup fake_exbotxi.launch 
	roslaunch exbotxi_bringup 2dsensor.launch 
	roslaunch exbotxi_rviz view_mobile.launch 

其中第3条命令用于启动LiDar设备，并从设备中获取数据。第4条命令用于启动rviz观察数据。

rviz启动后将看到图形界面，勾选左边的 *LaserScan* 选框，将可以看到LiDar中的点云数据，如图中的红色点。

.. image:: {image}lidar.jpg
	:alt: lidar

hector slam
===============
hector slam 已经可以直接通过ROS远程源安装，在Ubuntu for ROS中执行下面的命令即可：

.. code-block:: ubuntu

	sudo apt-get install ros-hydro-cmake-modules ros-hydro-hector-slam


手持LiDar做mapping
--------------------------
依次输入下面的命令，保持LiDar水平移动即可在rviz窗口中看到构建地图的过程。

.. code-block:: ubuntu

	roscore
	roslaunch exbotxi_bringup fake_exbotxi.launch 
	roslaunch exbotxi_bringup 2dsensor.launch 
	roslaunch exbotxi_nav hector_mapping_demo.launch
	roslaunch exbotxi_rviz view_navigation.launch 

用ExBot XI平台做mapping
------------------------
与手持LiDar类似，只需要将 *fake_exbotxi* 改为真实机器人的启动命令即可。输入下面的命令：

.. code-block:: ubuntu

	roscore
	roslaunch exbotxi_bringup minimal.launch 
	roslaunch exbotxi_bringup 2dsensor.launch 
	roslaunch exbotxi_nav hector_mapping_demo.launch
	roslaunch exbotxi_rviz view_navigation.launch 
	roslaunch exbotxi_teleop keyboard_teleop.launch 


.. note:: 如果使用的是rplidar，由于rplidar与机器人底盘都是使用ttyUSB？端口，所以需要按照前面的步骤将端口号修改正确，建议先将底盘的USB接入计算机，然后再接入rplidar，这样机器人底盘的端口就是 *ttyUSB0*，rplidar的端口就是默认的 *ttyUSB1*。

将键盘焦点放在键盘控制的terminal窗口中，然后通过键盘控制机器人移动，并可以从rviz中观察机器人构建的地图。此地图只需要LiDar设备即可，不需要其他传感器输入，如下图是rplidar的效果，如果使用频率更高的hokuyo，能够得到更好的地图：

.. image:: {image}map.jpg
	:alt: map

