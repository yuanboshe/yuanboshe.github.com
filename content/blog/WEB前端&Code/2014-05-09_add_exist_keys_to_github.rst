向GitHub添加已有的SSH Keys (Ubuntu)
#####################################

:tags: github
:summary: GitHub可以利用非对称密钥进行安全控制，即SSH方式下载与提交。SSH方式配置参考官方文档《`Generating SSH Keys <https://help.github.com/articles/generating-ssh-keys#platform-linux>`_》，对于使用多台机器的用户，其实不必每次都生成新的密钥对，那样会造成GitHub上密钥管理混乱，而且每次去GitHub粘贴自己的公钥也麻烦。我习惯将自己的密钥对保存在云盘，每次需要配置SSH访问时，再将自己的密钥拷贝到系统配置一下即可，这里记录相关流程。

	环境：Ubuntu 12.04

.. contents:: 目录

科普
=========
GitHub常用的两种库提交方式：HTTPS和SSH。通俗一点讲，如果你clone的是别人的库，那么使用HTTPS方式；如果你clone的是自己的库，那么最好用SSH方式。

HTTPS方式：安全性比SSH方式低，但是简单方便。clone的时候没有任何障碍，直接输入clone命令即可，每次提交的时候需要输入用户名和密码。所以HTTPS方式用来clone别人的存储库最合适了，如果是用来提交自己的存储库，每次提交都要输入用户名和密码太麻烦。

SSH方式：安全性比HTTPS高，基于非对称密钥，配置密钥的步骤麻烦点，但是安全性高，提交时也方便。clone的时候，如果你没有配置自己的SSH私钥，那么是不能clone别人的存储库的，如果配置了则可以直接clone；提交的时候，如果你配置进SSH的密钥对中的公钥在GitHub上该存储库的公钥列表里，那么你可以直接提交，不需要输入用户名和密钥，因为你的私钥已经代表了你的身份。所以对于经常做提交操作的用户，在系统中配置SSH是很必要的事情。

PS：别诧异为什么我很了解信息安全，因为我的本科毕业论文就是在信息所做的，开发过公钥基础设施CA中心。

生成Keys并配置SSH
===================
请参考官网教程：https://help.github.com/articles/generating-ssh-keys

总结一下就是下面几个命令：

.. code-block:: ubuntu

	ssh-keygen -f github_ubuntu -t rsa -C "yuanboshe@yeah.net"
	ssh-add github_ubuntu
	ssh -T git@github.com

.. note:: ``ssh -T git@github.com`` 那步要注意输入 **yes** 才能继续。

添加已有的Keys
================
这篇博文的point就是：不要每次到一台新机器就重新生成Keys并重新配置，这样做是很傻的，为什么不把已经在GitHub上配好的密钥对保存下来，有新系统需要配置SSH时直接拷贝过去呢？

例如在前面的步骤中我生成了一对密钥，命名为“github_ubuntu”，则私钥的文件名为 *github_ubuntu* ，公钥的文件名为 *github_ubuntu.pub* ，将公钥配置进GitHub后，就把这对密钥文件保存下来备用。

在新系统中，输入命令 ``ssh -T git@github.com`` ，会询问是否继续连接：

	The authenticity of host 'github.com (192.30.252.131)' can't be established.
	RSA key fingerprint is 16:27:ac:a5:76:28:2d:36:63:1b:56:4d:eb:df:a6:48.
	Are you sure you want to continue connecting (yes/no)? yes

输入 **yes** 确认，则可能出现下面提示：
	
	Warning: Permanently added 'github.com,192.30.252.131' (RSA) to the list of known hosts.
	Permission denied (publickey).
	
这是理所当然的，还什么都没做呢。

输入命令 ``nautilus ~/.ssh/`` 打开 *.ssh* 文件夹，然后将你的密钥对文件（我的是 *github_ubuntu* 和 *github_ubuntu.pub*）复制粘贴进去。

然后再输入命令 ``ssh -T git@github.com`` ，应该可以看到下面的结果：

	Warning: Permanently added the RSA host key for IP address '192.30.252.129' to the list of known hosts.
	Hi yuanboshe! You've successfully authenticated, but GitHub does not provide shell access.

如果你的私钥文件进行过加密，这个步骤还会要求你输入私钥文件的访问密码。

就这么简单，别再重新生成密钥对以及向GitHub公钥列表中添加新的公钥了。