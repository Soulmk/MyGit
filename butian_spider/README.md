#爬虫功能：
设置一个定时任务，对补天漏洞平台公开出的最新漏洞进行爬行，将与关键字相匹配的漏洞信息存储到数据库中，可供前端程序调用。 
此爬虫可为其他漏洞库作参考，例如爬取乌云的漏洞，修改正则表达式即可
***
使用mysql数据库存储数据
##表结构：
bug_info用于存储爬取到的漏洞信息
***
CREATE TABLE `bug_info` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `bug_time` varchar(255) DEFAULT NULL,
  `bug_title` varchar(255) DEFAULT NULL,
  `bug_url` varchar(255) DEFAULT NULL,
  `spider_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `bug_level` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM AUTO_INCREMENT=15921 DEFAULT CHARSET=utf8;
***
bug_keys用于存储爬虫关键字
***
CREATE TABLE `bug_keys` (
  `key_id` int(20) NOT NULL AUTO_INCREMENT,
  `key_info` varchar(255) NOT NULL,
  `key_level` varchar(255) NOT NULL,
  PRIMARY KEY (`key_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
***
**其中：run.bat可将程序输出信息保存到log.txt中，以备日后查看日志
sign.txt为爬虫标记，存储爬虫第一个url记录，以备后面循环任务到此标记结束爬行
