我的Pelican设置
####################

:tags: pelican
:summary: Python的Pelican是个很自由的静态站点生成工具，可以很方便的自己去开发一些功能。这里记录了一些自己定制的功能，方便我自己快速重新部署环境，或许也能给其他人一些启示。

	环境：Windows8.1, Python2.7, pelican

.. contents:: 目录

增加image相对路径功能
----------------------
在编写文档的时候经常需要插入图片，而pelican现在的做法是使用类似 *![Alt Text]({filename}/images/han.jpg)* 的格式，用{filename} replacer来指代内部引文路径。我习惯将某一篇博文的图片存进一个单独的文件夹，使用{filename} replacer不得不在后面跟上长长的rst文件名，以后修改起来也不好批量处理。

于是我增加了使用{image} replacer，在rst文档中，只要使用下面的格式即可插入图片。即rst文档保存为 */content/blog/%catogery%/%rst_file_name%.rst* 而图片保存在 */content/images/%rst_file_name%/* 路径下。在rst文档中引用图片的格式很简单，如下::

	.. image:: {image}image_name.jpg
		:alt: image_name
			
我想通过pelican插件来增加这个功能，尽量不去“破坏”pelican源码。但是pelican对插件功能描述的文档非常欠缺，导致你无法通过网络知道自己想用的插件到底是否存在。外加pelican没有针对这种功能的插件signal，修改源码应该是最合适的途径。作者也对于{filename} replacer写道::

	# we support only filename for now. the plan is to support
	# categories, tags, etc. in the future, but let's keep things
	# simple for now.

我们有理由通过修改源码增加{image} replacer。

找到下面这段代码::

	elif what == 'tag':
		origin = Tag(value, self.settings).url

找到pelican源码目录下的 *contents.py* 文件，例如我的是 *D:/Python/Envs/pelicanenv/Lib/site-packages/pelican/contents.py* 在后面添加下面的代码即可：

.. code-block:: python

	elif what == 'image': # yuanboshe added. for images in blog content
		match = re.search(r'([-\w]*).\w*$', self.source_path)
		if match:
			fname = m.group(1)
			origin = '/'.join((siteurl, "images", match.group(1), value))
		else:
			logger.warning("Unable to find {fn}, skipping url"
						   " replacement".format(fn=origin))

BAT批处理文件启动pelicanenv虚拟环境
------------------------------------
为了保证Python环境的干净，所有pelican相关以来包装在名为pelicanenv的virtualenv虚拟环境内。每次在pelican项目里面写完文档，想用pelican生成静态站点，都需要进入pelicanenv虚拟环境，然后执行生成命令。进入pelicanenv虚拟环境过程中还需要几条命令，为了便利，使用BAT批处理命令直接进入，双击.bat文件即可。

在pelican项目的根目录新建bat文件 *start-env.bat* ，内容如下：

.. code-block:: bat

	call D:\Python\Envs\pelicanenv\Scripts\activate.bat
	cmd
	
其中 *activate.bat* 路径改为自己的pelican虚拟环境的路径。

调试Pelican
--------------
如果想自己改pelican代码，或者是探索工作原理，调试环境必不可少。其实pelican的调试非常简单，在pelican项目的根目录新建一个 *start.py* 的Python文件，在文件里添加下面的代码：

.. code-block:: python

	from pelican import main
	# For PyCharm to debug pelican, added by yuanboshe
	main()

保存。调试的时候使用IDE调试这个 *start.py* 文件即可。

其他一些功能定制
-----------------
尽量使用插件方式修改，或者添加自己的功能，很多参数或者代码也可以放在配置文件里面实现，最大的工作量似乎主要集中在了Jinja2模板的编写和扩展上。从Ruby的Nanoc到Python的Pelican，都是定制化很强的静态站点生成工具，只可惜相关文档很少，只能靠自己去发掘定制方法了。

还有很多自己定制的功能暂时就不写了...
