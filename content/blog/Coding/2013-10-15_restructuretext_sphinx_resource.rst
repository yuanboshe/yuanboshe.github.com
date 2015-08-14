reStructuredText + Sphinx的一些学习资源
########################################

:tags: reStructuredText, sphinx
:summary: 一些reStructuredText & Sphinx的学习资源，备查。

.. contents:: 目录

reStructuredText
================================
reStructuredText学习资源
--------------------------
`Docutils上的reST教程（传送） <http://docutils.sourceforge.net/rst.html>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    Docutils is an open-source text processing system for processing plaintext documentation into useful formats, such as HTML, LaTeX, man-pages, open-document or XML. It includes reStructuredText, the easy to read, easy to use, what-you-see-is-what-you-get plaintext markup language.

*Docutils: Documentation Utilities* 上面有解释，可以把它看成是Python下的文档处理库，reStructuredText是Docutils项目的一部分，想学reStructuredText去官网（Docutils）没错，里面有详细的上手教程和指令参考等。

**User Documentation** 里面 `A ReStructuredText Primer`_ 和 `Quick reStructuredText <http://docutils.sourceforge.net/docs/user/rst/quickref.html>`_
分别是入门教程和快速参考手册，看完就能写出比较完美的文档了。`text source <http://docutils.sourceforge.net/docs/user/rst/quickstart.txt>`_ 是 `A ReStructuredText Primer`_
的 ``.rst`` 格式文档，对照一下能够帮助理解reST各种标记的效果。

.. _A ReStructuredText Primer: http://docutils.sourceforge.net/docs/user/rst/quickstart.html

**Reference Documentation** 里面的内容可以当成是速查手册，比如需要用到什么指令的时候，可以来这里 `reStructuredText Directives <http://docutils.sourceforge.net/docs/ref/rst/directives.html>`_

`Sphinx上的reST教程（传送） <http://sphinx-doc.org/rest.html>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Sphinx is a tool that makes it easy to create intelligent and beautiful documentation, written by Georg Brandl and licensed under the BSD license.

这里的Sphinx不是同名的搜索引擎的那个Sphinx，而是一款Python Documentation Generator，它通过Docutils使用reST，能够方便地将reST存档转换为HTML，PDF等格式的用户手册，支持用户自定义和修改样式，功能强大。
大多reST的使用者都会使用Sphinx工具制作自己的文档，Sphinx提供的reST教程虽然没有Docutils上的丰富，但排版美观，让人更愿意在这里看。

在线reStructuredText编辑工具
-------------------------------------
`Online reStructuredText editor（传送） <http://rst.ninjs.org/>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.. figure:: {image}Online_reStructuredText_editor.jpg
    :alt: Online reStructuredText editor

    Online reStructuredText editor

所见即所得的在线reST转换工具，转换并不是那么实时，但凑合着初学用用吧。写熟悉后，这种工具就完全没必要使用了。

`reST to HTML conversion（传送） <http://www.tele3.cz/jbar/rest/rest.html>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Docutils官网推荐的一个在线工具，有最大字数限制，而且不是实时预览——要点“Render”才可以得到预览页面，不太方便。

.. figure:: {image}online_rest2html.jpg
    :alt: reST to HTML conversion

    reST to HTML conversion

离线reStructuredText编辑器
---------------------------
`ReText（传送） <http://sourceforge.net/projects/retext>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ReText可以离线编辑reStructuredText和Markdown，有点类似著名的Markdown编辑器MarkdownPad 2。ReText跟MarkdownPad 2一样有个烦人的问题——编码问题——当保存中文的时候，即使选择了utf-8编码，
也会在Python解析的时候出现“非utf-8编码”的提示，导致无法对中文进行转换。ReText新版本是Python3.x下的，也许是我的Windows + Python2.7导致的水土不服，也许在Ubuntu下面或者Python3.x下面会
好些，总之，现在对我来说用处不大了，直接使用PyCharm编辑，虽然没有实时预览的功能，但有高亮提示，转换方便，用起来没什么麻烦的。

`ReText Windows安装说明 <http://sourceforge.net/p/retext/wiki/Windows%20Install%20of%20ReText>`_ 如果想在Windows下面这条ReText，可以参考这个流程，安装起来比较麻烦，中间也许会遇到一些问题。
如无法加载PySide模块的问题，使用 ``easy_install`` 可以解决。
而后也许会遇到 ``error: Unable to find vcvarsall.bat`` 的错误，需要先在控制台执行一下 ``SET VS90COMNTOOLS=%VS110COMNTOOLS%`` （VS2008对应90，VS2010对应100，VS2012对应110），如果你没有VS2008的编译器就会出现这个问题，
这条命令的意思是将默认的VS2008的编译器改成使用VS2012的编译器（如果你装了VS2012），参考<http://stackoverflow.com/questions/2817869/error-unable-to-find-vcvarsall-bat>。

`PyCharm（传送） <http://www.jetbrains.com/pycharm/index.html>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PyCharm是款很不错的Python IDE，在我的Pelican项目中，不仅可以方便调试Pelican源码，跟踪到源码内部，还支持模板Jinja2的语法格式，提供高亮，动态提示等功能。源码 + 调试，是学习别人代码
最重要的方式。

.. figure:: {image}pycharm.jpg
    :alt: PyCharm IDE

    PyCharm IDE

.. note:: 如果希望Pelican + PyCharm做调试，项目不能放在中文路径下（但Pelican项目的子目录可以有中文路径），否则出现非utf-8编码错误，导致无法调试。

Sphinx
=========
一些文档
---------
`Sphinx官网文档（传送） <http://sphinx-doc.org/contents.html>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
想上手Sphinx，从头开始看文档吧，几条命令即可生成自己的HTML版本用户手册。其中 `HTML theming support <http://sphinx-doc.org/theming.html>`_ 教你如何快速生成不同样式的HTML文档。

想看中文版的来这里
`中文版的Sphinx文档1 <http://sphinx-doc-zh.readthedocs.org/en/latest/contents.html>`_ 和
`中文版的Sphinx文档2 <http://zh-sphinx-doc.readthedocs.org/en/latest/contents.html>`_ 样式不同内容一样，不知道它们是什么关系。都只有部分汉化了。

.. tip:: 用Sphinx生成的HTML文档，如果按照内建模板生成的，点旁边的 *Show Source* 链接就能看到 ``.rst`` 的源文档，方便做比对学习。

`OpenAlea的Sphinx文档（传送） <http://openalea.gforge.inria.fr/doc/openalea/doc/_build/html/source/sphinx/sphinx.html>`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
OpenAlea里面的文档就是用Sphinx组织的，里面也有一些Sphinx使用方面的教程，排版什么都都不错。



