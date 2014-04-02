Windows Python虚拟环境配置（Distribute + pip + virtualenv + virtualenvwrapper-powershell）
##########################################################################################

:tags: python
:summary: 对于Python开发新手，很多人会迷茫那些各种名目的工具和概念，如Python2.7, Python3.3, Distribute, pip, virtualenv，Setuptools， easy_install， 这些东东到底干嘛的，有什么作用，为什么每个配置教程总会碰到它们，到底该如何选择？好吧，不必都搞懂，只要知道当前怎么配置最合适就行了。本文记录了最新的Python虚拟环境配置流程，个人觉得也是最优雅干净的配置方式，如果还在用一些乱糟糟的方法配置，还是弃暗投明吧。

	环境：Win8.1, Python2.7, Python3.3, Distribute, pip, virtualenv, virtualenvwrapper-powershell, PowerShell.

.. contents:: 目录

概念
=======
初学Pyhon，恐怕绝大部分人都会面对Distribute, Setuptools, pip, easy_install, virtualenv等工具吧，这些东西到底是什么呢？http://guide.python-distribute.org/index.html 给出了前四个的解释，以及所有工具的配置教程。

Distribute -> Setuptools
-------------------------
	Distribute is a collection of enhancements to the Python standard library module: distutils (for Python 2.3.5 and up on most platforms; 64-bit platforms require a minimum of Python 2.4) that allows you to more easily build and distribute Python packages, especially ones that have dependencies on other packages.
	
	Distribute was created because the Setuptools package is no longer maintained. Third-party packages will likely require setuptools, which is provided by the Distribute package. Therefore, anytime time a packages depends on the Setuptools package, Distribute will step in to say it already provides the setuptools module.

Distribute是Setuptools的替代方案。它们都是Python标准库模块的增强，可以让人们很方便地建立和发布Python包，特别是在有依赖的情况下。既然Distribute是Setuptools的替代方案，能用Distribute就别用Setuptools了。

pip -> easy_install
---------------------
	Pip is an installer for Python packages written by Ian Bicking. It can install packages, list installed packages, upgrade packages and uninstall packages.
	
	The pip application is a replacement for easy_install. It uses mostly the same techniques for finding packages, so packages that were made easy_installable should be pip-installable as well.

pip是easy_install的替代方案。它们都是Python包管理工具，可以让人们很方便地安装，更新，卸载Python包。既然pip是easy_install的替代方案，能用pip就别用easy_install了。

virtualenv
------------
http://www.tylerbutler.com/2012/05/how-to-install-python-pip-and-virtualenv-on-windows-with-powershell/ 给出了一些说明：

	The more Python development you do, though, the more packages you’re going to need. Wouldn’t it be nice if you could install all the packages into a ‘special’ location where they wouldn’t interfere with any other packages? This is where virtualenv comes in. It creates a virtual Python interpreter and isolates any packages installed for that interpreter from others on the system. There are lots of ways this comes in handy; I’ll leave enumerating them as an exercise for the reader, but if you think for a minute you can see why this will come in handy. And if you can’t yet, then give yourself a few weeks of Python development, then come back and look at this post again once you realize you need to use virtualenv.

对于开发者来说，Python的包各种各样，版本也各种各样，如果所有的包都装在一个Python环境里面，难免会遇到一些冲突情况，而且部署在其他地方的时候也显得臃肿冗余。virtualenv是这样一个工具，可以虚拟出N个独立的Python的工作环境，针对某一个应用所需要的包，都装在某一个特定的虚拟环境里面，不同的环境互不干扰。使用虚拟环境来管理自己的应用所需要的包，是非常优雅的事。当然你只是随便用用，都装置一个Python环境里面也无可厚非。

配置
=====
本文记录了Windows 8.1下面搭建Python虚拟环境的操作流程。

运行powershell
---------------
PowerShell是Windows的shell工具，提供类似UNIX系统里面的一些命令。Windows 7和Windows 8默认自带PowerShell，如果是Windows XP之类的，可能还要自己先装下PowerShell。

**Win + R** 打开启动对话框，输入 **powershell** 启动PowerShell工具。

.. tip:: 在PowerShell中鼠标选中文字，右键则表示复制；鼠标移动到光标处，右键则表示粘贴。

安装Python
------------
从Python官网(http://python.org/download/)下载Python 2.x和Python 3.x的32bit Windows Installer。

本例中下载的是 python-2.7.6.exe 和 python-3.3.3.exe ，分别安装在 *D:/Python/Python27* 和 *D:/Python/Python33* 路径下，默认没有将Python路径配置进系统环境变量内。

在系统变量中新建一项，变量名为 ``Python``，变量值为 ``D:/Python/Python27`` （以Python2.7为例，需要使用Python3.3时将 ``Python`` 变量修改为 ``D:/Python/Python33`` 即可）。编辑 **Path** 变量，在末尾添加 ``;%Python%;%Python%/Scripts``。

.. image:: {image}env1.jpg
    :alt: env1
	
重新打开PowerShell，输入命令 ``python``, 如果显示如下，则表示配置成功。

	Python 2.7.6 (default, Nov 10 2013, 19:24:18) [MSC v.1500 32 bit (Intel)] on win32
	Type "help", "copyright", "credits" or "license" for more information.
	>>>

安装Distribute
----------------
将 `distribute_setup.py <http://python-distribute.org/distribute_setup.py>`_ 下载到 *D:/Python/* 目录下。

打开PowerShell，运行命令 ``python D:/Python/distribute_setup.py`` 即可完成安装。

安装Pip
---------
将 `get-pip.py <https://raw.github.com/pypa/pip/master/contrib/get-pip.py>`_ 下载到 *D:/Python/* 目录下。

打开PowerShell，运行命令 ``python D:/Python/get-pip.py`` 即可完成安装。

如果不需要配置Python虚拟环境，则到这一步就可以结束了。

安装virtualenv和virtualenvwrapper-powershell
----------------------------------------------
在安装前有两件事情要做：第一是确保PowerShell的执行策略允许执行 *import-module* 命令，否则会出现策略错误提示，修改组策略需要以管理员身份运行PowerShell；第二是要设置用户的 *WORKON_HOME* 环境变量，也可以不设置，默认为系统的用户目录 "C:/Users/xxxx"。

1. 打开PowerShell，输入 ``Start-Process powershell -Verb runas`` 将会以管理员身份打开另外一个PowerShell，在新打开的PowerShell里面输入 ``Set-ExecutionPolicy RemoteSigned`` 会显示如下信息，回车即可完成策略修改：

	执行策略更改
	执行策略可帮助你防止执行不信任的脚本。更改执行策略可能会产生安全风险，如 http://go.microsoft.com/fwlink/?LinkID=135170
	中的 about_Execution_Policies 帮助主题所述。是否要更改执行策略?
	[Y] 是(Y)  [N] 否(N)  [S] 挂起(S)  [?] 帮助 (默认值为“Y”):

2. 打开用户环境变量设置窗口，在用户变量里新建 ``WORKON_HOME`` 变量，值设置为 ``D:/Python/Envs``，如下图：

.. image:: {image}env2.jpg
    :alt: env2

.. tip:: 在PowerShell里面使用 ``$env:WORKON_HOME="D:/Python/Envs"`` 可以临时设置 *WORKON_HOME* 变量，设置后关闭PowerShell即失效。

运行下面的命令，完成virtualenv和irtualenvwrapper-powershell的安装设置：

.. code-block:: ubuntu

	pip install virtualenv
	pip install virtualenvwrapper-powershell
	mkdir $env:WORKON_HOME
	import-module virtualenvwrapper

前两条命令使用pip安装virtualenv和virtualenvwrapper-powershell；第3条命令新建 *WORKON_HOME* 变量指向的文件夹；最后一条命令则是在PowerShell中导入virtualenvwrapper模块。

完成上面的设置后，在PowerShell中输入命令 ``Get-Command *virtualenv*`` 就能够看到virtualenv的快捷命令了::

	PS C:\Users\XPS 12> Get-Command *virtualenv*

	CommandType     Name                                               ModuleName
	-----------     ----                                               ----------
	Alias           cdvirtualenv ->                                    VirtualEnvWrapper
	Alias           cpvirtualenv ->                                    VirtualEnvWrapper
	Alias           lsvirtualenv ->                                    VirtualEnvWrapper
	Alias           mkvirtualenv ->                                    VirtualEnvWrapper
	Alias           rmvirtualenv ->                                    VirtualEnvWrapper
	Function        add2virtualenv                                     VirtualEnvWrapper
	Function        CDIntoVirtualEnvironment                           VirtualEnvWrapper
	Function        Copy-VirtualEnvironment                            VirtualEnvWrapper
	Function        GetVirtualEnvData                                  VirtualEnvWrapper
	Function        Get-VirtualEnvironment                             VirtualEnvWrapper
	Function        LooksLikeAVirtualEnv                               VirtualEnvWrapper
	Function        NewVirtualEnvData                                  VirtualEnvWrapper
	Function        New-VirtualEnvironment                             VirtualEnvWrapper
	Function        Remove-VirtualEnvironment                          VirtualEnvWrapper
	Function        Set-VirtualEnvironment                             VirtualEnvWrapper
	Function        showvirtualenv                                     VirtualEnvWrapper
	Function        virtualenvwrapper_get_python_version               VirtualEnvWrapper
	Function        virtualenvwrapper_get_site_packages_dir            VirtualEnvWrapper
	Application     virtualenv.exe
	Application     virtualenv-2.7.exe

常用的就是那几个有别名的命令了，lsvirtualenv -> 列出环境，mkvirtualenv -> 新建环境，rmvirtualenv -> 删除环境（通常需要带 -r 参数迭代删除）。

修复中文后缀BUG
-----------------
打开PowerShell，输入命令 ``mkvirtualenv testenv --no-site-packages`` 新建名为 *testenv* 的Python环境。如果安装有阿里旺旺，则可能会出现下面的一系列错误信息::

	PS C:\Users\XPS 12> mkvirtualenv testenv --no-site-packages
	New python executable in testenv\Scripts\python.exe
	Installing setuptools, pip...
	  Complete output from command D:\Python\Envs\testenv\Scripts\python.exe -c "import sys, pip; sys...d\"] + sys.argv[1:])
	)" setuptools pip:
	  Ignoring indexes: https://pypi.python.org/simple/
	Downloading/unpacking setuptools
	Cleaning up...
	Exception:
	Traceback (most recent call last):
	  File "D:\Python\Python27\lib\site-packages\virtualenv_support\pip-1.5.1-py2.py3-none-any.whl\pip\basecommand.py", line
	 122, in main
		status = self.run(options, args)
	  File "D:\Python\Python27\lib\site-packages\virtualenv_support\pip-1.5.1-py2.py3-none-any.whl\pip\commands\install.py",
	 line 274, in run
		requirement_set.prepare_files(finder, force_root_egg_info=self.bundle, bundle=self.bundle)
	  File "D:\Python\Python27\lib\site-packages\virtualenv_support\pip-1.5.1-py2.py3-none-any.whl\pip\req.py", line 1166, i
	n prepare_files
		url = finder.find_requirement(req_to_install, upgrade=self.upgrade)
	  File "D:\Python\Python27\lib\site-packages\virtualenv_support\pip-1.5.1-py2.py3-none-any.whl\pip\index.py", line 209,
	in find_requirement
		file_locations, url_locations = self._sort_locations(locations)
	  File "D:\Python\Python27\lib\site-packages\virtualenv_support\pip-1.5.1-py2.py3-none-any.whl\pip\index.py", line 128,
	in _sort_locations
		sort_path(os.path.join(path, item))
	  File "D:\Python\Python27\lib\site-packages\virtualenv_support\pip-1.5.1-py2.py3-none-any.whl\pip\index.py", line 109,
	in sort_path
		if mimetypes.guess_type(url, strict=False)[0] == 'text/html':
	  File "D:\Python\Python27\Lib\mimetypes.py", line 303, in guess_type
		init()
	  File "D:\Python\Python27\Lib\mimetypes.py", line 364, in init
		db.read_windows_registry()
	  File "D:\Python\Python27\Lib\mimetypes.py", line 264, in read_windows_registry
		for subkeyname in enum_types(hkcr):
	  File "D:\Python\Python27\Lib\mimetypes.py", line 249, in enum_types
		ctype = ctype.encode(default_encoding) # omit in 3.x!
	UnicodeDecodeError: 'ascii' codec can't decode byte 0xb0 in position 1: ordinal not in range(128)

	Storing debug log for failure in C:\Users\XPS 12\pip\pip.log
	----------------------------------------
	...Installing setuptools, pip...done.
	Traceback (most recent call last):
	  File "D:\Python\Python27\lib\runpy.py", line 162, in _run_module_as_main
		"__main__", fname, loader, pkg_name)
	  File "D:\Python\Python27\lib\runpy.py", line 72, in _run_code
		exec code in run_globals
	  File "D:\Python\Python27\Scripts\virtualenv.exe\__main__.py", line 9, in <module>
	  File "D:\Python\Python27\lib\site-packages\virtualenv.py", line 824, in main
		symlink=options.symlink)
	  File "D:\Python\Python27\lib\site-packages\virtualenv.py", line 992, in create_environment
		install_wheel(to_install, py_executable, search_dirs)
	  File "D:\Python\Python27\lib\site-packages\virtualenv.py", line 960, in install_wheel
		'PIP_NO_INDEX': '1'
	  File "D:\Python\Python27\lib\site-packages\virtualenv.py", line 902, in call_subprocess
		% (cmd_desc, proc.returncode))
	OSError: Command D:\Python\Envs\testenv\Scripts\python.exe -c "import sys, pip; sys...d\"] + sys.argv[1:]))" setuptools
	pip failed with error code 2
	Added activation script por Powershell to D:\Python\Envs/testenv\Scripts.
	(testenv)PS C:\Users\XPS 12>

据说这是由“\*.阿里旺旺接收的可疑文件”引起的汉字编码问题，解决方案为：打开 *D:/Python/Python27/Lib/mimetypes.py* 文件，找到 *default_encoding = sys.getdefaultencoding()* 一行，在前面添加下面的代码，保存并退出即可。(Refer: 参考 http://webrawler.blog.51cto.com/8343567/1339637 )

.. code-block:: python

	# begin fix bug
	if sys.getdefaultencoding() != 'gbk':
		reload(sys)
		sys.setdefaultencoding('gbk')
	# end

.. tip:: 使用 ``deactivate`` 命令退出 *testenv* 环境，使用 ``rmvirtualenv testenv`` 命令删除刚才创建的 *testenv* 环境。

使用virtualenv
---------------
在PowerShell下面使用virtualenv，下面的这几个命令比较常用：

* ``mkvirtualenv env_name --no-site-packages`` 可以用来创建新的虚拟环境。参数 *--no-site-packages* 可以用来阻止命令将原来Python系统中装过的包复制到新的虚拟环境里面。
* ``deactivate`` 用来退出当前的虚拟环境。
* ``lsvirtualenv`` 用来列出所有的虚拟环境。
* ``workon env_name`` 用来激活，或者切换到某一个虚拟环境下。
* ``rmvirtualenv env_name -r`` 用来删除某一个虚拟环境。参数 *-r* 表示迭代删除，往往目录非空的时候得带上这个参数。

如果需要在其它地方使用virtualenv，则先从PowerShell进入到对应的virtualenv，然后再打开对应的程序。或者参照 *D:/Python/Envs/env_name/Scripts/activate.bat* 文件的内容配置。对于IDE来说通常配置 *D:/Python/Envs/env_name/Scripts/python.exe* 即可。

最后
=====
个人觉得结构还是很清晰的，针对特定的应用使用特定的virtualenv确实很优雅，一次配置好后使用起来也并不麻烦，但并不是每个人都需要virtualenv。