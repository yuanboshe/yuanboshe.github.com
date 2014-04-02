Fix 3dsensor.launch兼容Kinect和ASUS Xtion pro Live
####################################################

:tags: turtlebot, ros, xtion, kinect
:summary: 忘了是从哪里看来的消息，说ROS里面的openni已经不能用来驱动Kinect和Xtion pro Live摄像头了，究其原因，说是openni驱动更新出现了问题，而且官方也不再更新了。当前Ubuntu某个摄像头包已经包含了Kinect驱动，新版Xtion pro Live也不能用以前的openni驱动。那么现在的Kinect和Xtion pro Live用什么驱动呢？经试验，Kinct使用freenect驱动，Xtion pro Live使用openni2驱动。玩turtlebot免不了使用3dsensor.launch来启动深度摄像头相关的nodes但3dsensor.launch里面依旧使用的openni驱动，大部分玩家都是买的现成turtlebot，不明白为什么他们的Kinect还能用得起来而我的Kinect却无法用openni驱动起来，也许是他们没有更新openni包吧。对于我这种没买turtlebot的，只有自己fix 3dsensor.launch的摄像头驱动问题了。

	环境：ROS Groovy + Kinect / Xtion pro Live

您所浏览的内容被隐藏了...
=============================

您所浏览的内容都是作者花费很多金钱和精力才探索出来的，虽然作者很希望将这些内容免费贡献出来，但总有一些人喜欢拿别人免费贡献出来的东西为自己谋利，却连基本的感谢都没有，甚至号称是自己的原创。对于那些转载过本文的人，请至少标明出处，给予作者最起码的尊重！

为了团队发展，也为了能有更好的条件为更多的机器人爱好者提供前沿的技术和经验，本文相关内容不再免费提供，希望大家关注ExBot http://blog.exbot.net ，所有经验将会写成教程，逐步贡献出来。