强大的响应式设计工具Bootstrap
##################################

:tags: web, github
:summary: 这几天Github访问不畅，Github pages也刷新缓慢。也有朋友抱怨我的主页不仅刷新慢，还半天都是个白板背景，内容页面很窄字体小等。虽然是HTML5 + CSS3写的，后来越看越不爽，越刷越不爽，影响写博客的心情，一怒之下，花了一天多时间，用强大的响应式设计工具Bootstrap外加Font Awesome重写了所有页面，它的强大谁用谁知道，CSS几乎被我删干净，只留了一个文件，js全部删光，img也只留了几个特定的。重写之后，即使Github pages传输速度慢，但只要html返回，就能快速套用样式显示主要内容，不像之前等几十秒钟都还是白背景。

	工具：Bootstrap 3.0.3, Font Awesome 4.0.3.

.. contents:: 目录

问题分析
=========
用YSlow分析了下，之前主要页面内容展示慢主要有下面几个原因：

* http请求过多
* font文件挂载在github空间，很多通用的css, js文件都是挂在github下而非CDN方式放在CDN服务器端
* 大量冗余css和js，html布局不佳，css没有放在最前端
* 大量标志图片

解决办法当然是重构html，精简css；因为用了bootstrap和font awesome，js全部删光，css通过bootstrap的html class属性定制；用了CDN服务，主要的css, js都在CDN服务器端；因为用了awesome，图片也减少了一半多。

Bootstrap + Font Awesome 简单的CDN加载
=======================================
通过CDN服务在html里面加载Bootstrap + Font Awesome太简洁了！

head部分添加下面两句：

.. code-block:: html

    <link rel="stylesheet" href="http://cdn.bootcss.com/twitter-bootstrap/3.0.3/css/bootstrap.min.css">
    <link rel="stylesheet" href="http://cdn.bootcss.com/font-awesome/4.0.3/css/font-awesome.min.css">

footer后面添加下面几句：

.. code-block:: html

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script src="http://cdn.bootcss.com/jquery/1.10.2/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="http://cdn.bootcss.com/twitter-bootstrap/3.0.3/js/bootstrap.min.js"></script>

OK了，Bootstrap + Font Awesome里面的东西随便用！

一些资源
==========
Bootstrap框架相关工具大集合：http://www.bootcss.com/

HTML + CSS编码规范：http://codeguide.bootcss.com/

Bootstrap文档：http://v3.bootcss.com/getting-started/

Font Awesome文档：http://fontawesome.io/

Bootstrap中文网开放CDN服务：http://open.bootcss.com/

