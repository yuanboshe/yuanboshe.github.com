Opencv 完美配置攻略 2014 (Win8.1 + Opencv 2.4.8 + VS 2013)
###########################################################

:tags: cv, opencv
:summary: 2012年4月给同学写了篇傻瓜式的 `VS2010+Opencv-2.4.0的配置攻略 <http://www.cnblogs.com/freedomshe/archive/2012/04/25/2470540.html>`_ 结果没有想到，点击量一路飙升，固定在了Google “Opencv 配置” 关键词搜索的榜首。现在看看，已经过时了，版本升级后看不到ttb了，还有很多不足的地方需要修正。新电脑需要重新配置环境，结合新版本，再来写篇最完美的傻瓜教程，看能不能超过以前的那篇 :)

	环境：Windows 8.1, Opencv 2.4.8, VS 2013.
	
.. contents:: 目录

配置
======
下载安装软件
-------------
下载 `Opencv for Windows <http://opencv.org/>`_ 最新版本，本文是 Opencv 2.4.8。双击后会出现解压提示，实际上就是“安装”了，路径填写为 *D:/Program Files*，然后确定。

.. note:: *D:/Program Files* 可以为任意自己希望opencv安装的路径，解压完成后，会在你所填目录中新增一个 opencv文件夹，里面就是opencv的所有内容了。例如按照我的路径，解压完成后Opencv就在 *D:/Program Files/opencv* 里面了。

下载 VS 2013，并安装。（自己找破解吧）

配置环境变量
-------------
在系统变量里面新建变量，名为 **OPENCV** ，值为自己解压opencv路径下的build路径，如 *D:\\Program Files\\opencv\\build*。

.. image:: {image}env1.jpg
	:alt: env1
	
.. tip:: 这一步是方便以后如果opencv路径改变了，只需要修改此变量就可以了，而不必做大范围修改。

在系统变量里面编辑 **Path** 变量，在末尾添加 ``;%OPENCV%\x86\vc12\bin`` 。

.. image:: {image}env1.jpg
	:alt: env1

.. note:: x86和x64分别表示32bit和64bit的VS工程，根据自己的工程来修改，否则虽编译成功但会运行错误；vc10, vc11, vc12 分别表示VS2010, VS2012, VS2013的Visual Studio使用的编译器版本，根据自己的VS版本来填写正确的编译器版本号。

.. note:: 多谢 *@玄影游侠* 的提醒，环境变量设置好后最好注销（重启）一下系统，可能有的系统环境变量不会立即生效，而导致一系列路径相关的问题。

编写Opencv的VS工程容属性表
-----------------------------
在opencv根目录（例如 *D:\\Program Files\\opencv*）下新建VS属性表文件 **opencv248.props**，或者直接下载我的 `opencv248.props <{image}opencv248.props>`_ 属性表文件。

opencv248.props 文件内容如下：

.. code-block:: xml

	<?xml version="1.0" encoding="utf-8"?>
	<Project ToolsVersion="4.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
	  <ImportGroup Label="PropertySheets" />
	  <PropertyGroup Label="UserMacros" />
	  <PropertyGroup>
		<IncludePath>$(OPENCV)\include;$(IncludePath)</IncludePath>
		<LibraryPath Condition="'$(Platform)'=='Win32'">$(OPENCV)\x86\vc12\lib;$(LibraryPath)</LibraryPath>
		<LibraryPath Condition="'$(Platform)'=='X64'">$(OPENCV)\x64\vc12\lib;$(LibraryPath)</LibraryPath>
	  </PropertyGroup>
	  <ItemDefinitionGroup>
		<Link Condition="'$(Configuration)'=='Debug'">
		  <AdditionalDependencies>opencv_calib3d248d.lib;opencv_contrib248d.lib;opencv_core248d.lib;opencv_features2d248d.lib;opencv_flann248d.lib;opencv_gpu248d.lib;opencv_highgui248d.lib;opencv_imgproc248d.lib;opencv_legacy248d.lib;opencv_ml248d.lib;opencv_nonfree248d.lib;opencv_objdetect248d.lib;opencv_ocl248d.lib;opencv_photo248d.lib;opencv_stitching248d.lib;opencv_superres248d.lib;opencv_ts248d.lib;opencv_video248d.lib;opencv_videostab248d.lib;%(AdditionalDependencies)</AdditionalDependencies>
		</Link>
		<Link Condition="'$(Configuration)'=='Release'">
		  <AdditionalDependencies>opencv_calib3d248.lib;opencv_contrib248.lib;opencv_core248.lib;opencv_features2d248.lib;opencv_flann248.lib;opencv_gpu248.lib;opencv_highgui248.lib;opencv_imgproc248.lib;opencv_legacy248.lib;opencv_ml248.lib;opencv_nonfree248.lib;opencv_objdetect248.lib;opencv_ocl248.lib;opencv_photo248.lib;opencv_stitching248.lib;opencv_superres248.lib;opencv_ts248.lib;opencv_video248.lib;opencv_videostab248.lib;%(AdditionalDependencies)</AdditionalDependencies>
		</Link>
	  </ItemDefinitionGroup>
	  <ItemGroup />
	</Project>

这份属性表为opencv2.4.8的VS2013工程属性表，兼容64位和32位平台，兼容Debug和Release配置。详细解释看后文，后面在VS工程中配置Opencv只需要导入这份属性表就可以了。

.. note:: 如果不是VS2013，或者Opencv版本不是2.4.8，一定要修改部分参数才能使用。详细修改办法看后文。

新建VS测试工程
----------------
文件 -> 新建 -> 项目 -> Visual C++ -> Win32 控制台应用程序（输入名称test）

.. image:: {image}step1.jpg
	:alt: step1

确定 -> 下一步 -> 附加选项选“空项目” -> 完成

.. image:: {image}step2.jpg
	:alt: step2

	
VS内配置Opencv
----------------
这里用VS属性表的方式将Opencv配进工程，每次只需要添加属性表即可完成配置，比手工界面配置方便很多。

属性管理器 -> 右键 "test"（工程名） -> 添加现有属性表

.. image:: {image}step3.jpg
	:alt: step3

找到之前新建或者下载的属性表（ *D:\\Program Files\\opencv\\opencv248.props* ），添加进工程

.. image:: {image}step4.jpg
	:alt: step4
	
测试
------
解决方案资源管理器 -> 源文件（右键）-> 添加 -> 新建项

.. image:: {image}step5.jpg
	:alt: step5
	
Visual C++ -> C++文件：输入名称test点添加

.. image:: {image}step6.jpg
	:alt: step6

粘贴下面的代码，保存：

.. code-block:: cpp

	#include <opencv2\opencv.hpp>
	#include <iostream>
	#include <string>
	using namespace cv;
	using namespace std;
	int main()
	{
		Mat img = imread("pp.jpg");
		if (img.empty())
		{
			cout << "error";
			return -1;
		}
		imshow("pp的靓照", img);
		waitKey();

		return 0;
	}

把自己的靓照改名为pp.jpg，然后放到工程项目的test文件夹里面（是里面那个test文件夹）
	
.. image:: {image}step7.jpg
	:alt: step7

按F5调试程序，如果你的图片出来了就OK了。

.. image:: {image}step8.jpg
	:alt: step8
	
进阶
=======
直接文本编写Opencv x64 x86 Debug Release 全兼容属性表
--------------------------------------------------------
新建属性表文档 **opencv248.props**，填写下面的xml内容并保存：

.. code-block:: xml

	<?xml version="1.0" encoding="utf-8"?>
	<Project ToolsVersion="4.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
	  <ImportGroup Label="PropertySheets" />
	  <PropertyGroup Label="UserMacros" />
	  <PropertyGroup>
		<IncludePath>$(OPENCV)\include;$(IncludePath)</IncludePath>
		<LibraryPath Condition="'$(Platform)'=='Win32'">$(OPENCV)\x86\vc12\lib;$(LibraryPath)</LibraryPath>
		<LibraryPath Condition="'$(Platform)'=='X64'">$(OPENCV)\x64\vc12\lib;$(LibraryPath)</LibraryPath>
	  </PropertyGroup>
	  <ItemDefinitionGroup>
		<Link Condition="'$(Configuration)'=='Debug'">
		  <AdditionalDependencies>opencv_calib3d248d.lib;opencv_contrib248d.lib;opencv_core248d.lib;opencv_features2d248d.lib;opencv_flann248d.lib;opencv_gpu248d.lib;opencv_highgui248d.lib;opencv_imgproc248d.lib;opencv_legacy248d.lib;opencv_ml248d.lib;opencv_nonfree248d.lib;opencv_objdetect248d.lib;opencv_ocl248d.lib;opencv_photo248d.lib;opencv_stitching248d.lib;opencv_superres248d.lib;opencv_ts248d.lib;opencv_video248d.lib;opencv_videostab248d.lib;%(AdditionalDependencies)</AdditionalDependencies>
		</Link>
		<Link Condition="'$(Configuration)'=='Release'">
		  <AdditionalDependencies>opencv_calib3d248.lib;opencv_contrib248.lib;opencv_core248.lib;opencv_features2d248.lib;opencv_flann248.lib;opencv_gpu248.lib;opencv_highgui248.lib;opencv_imgproc248.lib;opencv_legacy248.lib;opencv_ml248.lib;opencv_nonfree248.lib;opencv_objdetect248.lib;opencv_ocl248.lib;opencv_photo248.lib;opencv_stitching248.lib;opencv_superres248.lib;opencv_ts248.lib;opencv_video248.lib;opencv_videostab248.lib;%(AdditionalDependencies)</AdditionalDependencies>
		</Link>
	  </ItemDefinitionGroup>
	  <ItemGroup />
	</Project>

这份属性表为opencv2.4.8的VS工程属性表，兼容64位和32位平台，兼容Debug和Release配置。

很容易看出如何修改：

* 如果你没有配置%OPENCV%环境变量，则只需要修改 *IncludePath* 和 *LibraryPath* 所指三个标签，用绝对路径代替 *$(OPENCV)*；
* 如果你的Visual Studio版本与我的不同，则需要修改 *LibraryPath* 所指两个标签的将编译器版本号，VS2010对应vc10，VS2012对应vc11，VS2013对应vc12；
* 如果你的opencv与我的版本不同，只需要将两个 *AdditionalDependencies* 标签内的所有lib的版本号修正即可（所有的248改为自己的版本号），并在opencv的lib目录下检查一下lib名称是否对应。

通过VS界面建立自己的VS项目属性表
----------------------------------
网上一大堆，就不具体说明了。与自己文本编写属性表不同的是，通过界面新建的属性表要为不同的配置单独建立，导入的时候也要针对配置单独导入。

属性管理器 ->展开 *项目名* -> 右键 *Debug | Win32* -> 添加新项目属性表

.. image:: {image}props1.jpg
	:alt: props1

添加属性表，取名为“opencv248x86.Debug.props”。
	
.. image:: {image}props2.jpg
	:alt: props2

属性管理器 ->展开 *Debug | Win32* -> 双击 新建的 *opencv248x86.Debug* 打开属性页面 -> VC++ 目录

.. image:: {image}props3.jpg
	:alt: props3

编辑 **包含目录** 一栏，添加opencv的include路径，例如我的是 *D:\\Program Files\\opencv\\build\\include*；编辑 **库目录** 一栏，添加opencv的lib路径，例如我的是 *D:\\Program Files\\opencv\\build\\x86\\vc12\\lib* 。

.. image:: {image}props4.jpg
	:alt: props4

.. note:: 将光标移到编辑框会在右边出现小下拉三角，点击小三角，再选择编辑打开路径选择窗口选择对应路径。如果直接粘贴则粘贴在现有内容前面用分号隔开，否则会失去继承性。

.. note:: **库目录** 一栏选择opencv的lib路径时，如果工程是64位则选择opencv的x64目录，如果是32位则选择x86。Visual Studio的版本与编译器版本号的对应关系是：VS2010 -> vc10, VS2012 -> vc11, VS2013 -> vc12，选择目录的时候注意自己的VS工程版本。

在属性页面 -> 链接器 -> 输入 -> 附加依赖项 -> 编辑。添加下面的lib列表::

	opencv_calib3d248d.lib
	opencv_contrib248d.lib
	opencv_core248d.lib
	opencv_features2d248d.lib
	opencv_flann248d.lib
	opencv_gpu248d.lib
	opencv_highgui248d.lib
	opencv_imgproc248d.lib
	opencv_legacy248d.lib
	opencv_ml248d.lib
	opencv_nonfree248d.lib
	opencv_objdetect248d.lib
	opencv_ocl248d.lib
	opencv_photo248d.lib
	opencv_stitching248d.lib
	opencv_superres248d.lib
	opencv_ts248d.lib
	opencv_video248d.lib
	opencv_videostab248d.lib

.. image:: {image}props5.jpg
	:alt: props5
	
确定两次后完成Debug版本的属性表编辑。

同样依照上面的步骤编写Release版本的属性表，唯一不同的是在“附加依赖项”中填入的是Release版本的lib列表::

	opencv_calib3d248.lib
	opencv_contrib248.lib
	opencv_core248.lib
	opencv_features2d248.lib
	opencv_flann248.lib
	opencv_gpu248.lib
	opencv_highgui248.lib
	opencv_imgproc248.lib
	opencv_legacy248.lib
	opencv_ml248.lib
	opencv_nonfree248.lib
	opencv_objdetect248.lib
	opencv_ocl248.lib
	opencv_photo248.lib
	opencv_stitching248.lib
	opencv_superres248.lib
	opencv_ts248.lib
	opencv_video248.lib
	opencv_videostab248.lib

.. tip:: \*d.lib的是Debug版本lib，\*.lib的是Release版本lib。
