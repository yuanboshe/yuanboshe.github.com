MySql 从 csv中导入数据
#################################

:tags: mysql
:summary:

    环境：Windows7 64位。

    这里pcDuino的设置是为安装ROS，故所有流程为在microSD卡内刷Lubuntu的流程。为了在pcDuino里面装ROS，需要准备一张4G（最好大于4G）的microSD卡，pcDuino的NAND flash只有2G，装Lubuntu后只剩几百M，不够装ROS使用。

:status: draft

.. contents:: 目录

...
=======================================
如果你的csv文件放在本地机器上，并且不是mysql指定的路径下，就需要使用

mysql tianchi --local-infile -hlocalhost -uroot


.. code-block:: sql

	load data local infile '~/tianchi/origin_data.csv'  
	into table origin_data
	character set utf8
	fields terminated by "," 
	lines terminated by '\n'
	ignore 1 lines
	(user_id, brand_id, `type`, @visit_datetime)
	set visit_datetime = STR_TO_DATE(@visit_datetime, '%c-%e');

日期格式
----------
日期格式的format占位符参考：http://www.webjx.com/database/mysql-9370.html