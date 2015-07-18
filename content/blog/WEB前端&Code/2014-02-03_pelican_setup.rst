Windows8.1 Pelican 安装与配置流程
##################################

:tags: python, pelican, github
:summary: pelican的安装和配置并不复杂，本文记录全部流程。

	环境：Windows8.1, Python2.7, pelican

.. contents:: 目录

Pelican
=========
安装配置pelican
-----------------
打开PowerShell，输入下面的命令：

.. code-block:: ubuntu

	mkvirtualenv pelicanenv --no-site-packages
	pip install pelican

第1条命令创建名为pelicanenv的Python虚拟环境；第2命令使用pip安装pelican，经过一长串的warnning后，应该可以顺利安装完毕。

安装依赖包
------------
这里主要是安装Fabric，以及fab命令需要的pycrypto和ecdsa。在PowerShell中输入下面的命令：

.. note:: 保证自己当前处于前面建立的pelicanenv虚拟环境下，否则就装到默认Python环境中去了。看PowerShell的光标，如果显示诸如 *(pelicanenv)PS D:\>* 字样就表示在pelicanenv环境下，否则使用 ``workon pelicanenv`` 命令进入pelicanenv环境中。

.. code-block:: ubuntu

	$env:VS90COMNTOOLS=$env:VS120COMNTOOLS
	pip install Fabric
	pip install pycrypto
	pip install ecdsa
	
.. note:: 上面命令中的 *$env:VS120COMNTOOLS* 需要根据你的Visual Studio进行修改，如果你安装了VS2010则跳过，不需要修改；如果你装了VS2012，则填写 ``$env:VS90COMNTOOLS=$env:VS110COMNTOOLS``；如果你装了VS2013，则填写 ``$env:VS90COMNTOOLS=$env:VS120COMNTOOLS`` 。否则后面安装pycrypto会出现 *error: Unable to find vcvarsall.bat* 的错误。 (refer `彻底解决 error: Unable to find vcvarsall.bat <http://blog.csdn.net/secretx/article/details/17472107>`_ )

生成pelican项目
----------------
``cd D:\`` 来到D盘根目录，输入 ``pelican-quickstart -p testpelican`` 来快速建立名为testpelican的项目，测试用，其他就随意填写了，一路配置下来，则会在D盘看到“testpelican”文件夹，即为自己的pelican项目。

``cd testpelican`` 进入testpelican目录，输入下面的命令：

.. code-block:: ubuntu

	fab build
	fab serve

则会看到如图所示的结果，表示本地server开启。

.. image:: {image}powershell.jpg
    :alt: powershell

打开浏览器，输入 ``localhost:8000``，就能看到生成的网页了。

.. image:: {image}pelican.jpg
    :alt: pelican

想了解更多，参考Pelican官方文档：http://docs.getpelican.com/en/latest/

Git工具 for GitHub
===================
怎么在GitHub上面建博，网文一大堆，这里只记录环境的配置流程。假设你已经在GitHub上面有了自己的仓库，并且已经配置好自己的公共密钥，私有密钥保存在PC本地。

GitHub for Windows
-------------------
GitHub for Windows是GitHub官方图形界面工具，使用方便，但对比功能比较弱。习惯命令操作的用Git Shell也不错。下载地址：http://windows.github.com/

tortoisegit
------------
喜欢使用图形界面操作，尤其是TortoiseSVN的老粉丝，应该更喜欢TortoisGit。

下载并安装tortoisegit：http://code.google.com/p/tortoisegit/wiki/Download  
下载并安装msysgit：http://code.google.com/p/msysgit/downloads/list

.. tip:: 在PowerShell中使用 ``regsvr32 /u "D:\Program Files (x86)\Git\git-cheetah\git_shell_ext64.dll"`` 命令可以去掉Git Bash的右键菜单选项，装好msysgit后，右键文件夹会有一长条Git选项，清除后清爽很多。其中路径为自己安装msysgit的路径，如果装的是32位的，dll名还要改为 **git_shell_ext.dll**。

加载私有密钥
-------------
如果不加载私有密钥，可以克隆你的GitHub仓库到本地，但是无法提交更新到GitHub。假设你已经将GitHub远程仓库克隆到本地，用资源管理器打开本地的仓库，右键选择 TortoiseGit -> Settings，在打开的窗口中选择 Git -> Remote -> Origin，在Putty Key里面填入自己的私有密钥（对应的公共密钥已经在GitHub端配置好）。

.. image:: {image}turtoisegit.jpg
    :alt: turtoisegit settings
	

	
	
	
