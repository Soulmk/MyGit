#!/usr/bin/python
# -*- coding: utf-8 -*-
__author__ = '浩哥'

import re
import requests
import sys
import MySQLdb
import time

#reload(sys)
#sys.setdefaultencoding('utf-8')
#print sys.getdefaultencoding()

header = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; WOW64; rv:39.0) Gecko/20100101 Firefox/39.0'}
url='http://www.wooyun.org/bugs/'

result = requests.get(url,headers=header,timeout=15)

recontent = result.content
getpagenum=re.search('<p class=\"page\">(.*?)<a',recontent,re.S)
getpagenum=re.search(',(.*?)页',getpagenum.group(1))
pagenum=int(getpagenum.group(1))
#print pagenum

def Get_content(url):
    print url
    result = requests.get(url,headers=header,timeout=15)
    recontent= result.content
    get_urlcontent =re.search('<h2>漏洞详情</h2>(.*?)<hr align="center"/>',recontent,re.S)
    return get_urlcontent.group(1)
def Get_nowday():
    print time.strftime( ISOTIMEFORMAT, time.localtime( time.time() ) )

def Save(info):#将结果输出到MYSQL中
    db=MySQLdb.connect("127.0.0.1","root","123456","wooyun",charset='utf8')
    url_content=Get_content(info['url']);
    nowday=Get_nowday()
    cursor=db.cursor()
    sql="LOCK TABLES sys_record WRITE;"
    cursor.execute(sql)
    sql="INSERT INTO sys_record VALUES(null,'wooyun','"+info['time']+"','all','"+info['title']+"','"+url_content+"',false,'中等','"+info['url']+"','2015-12-20','saturn');"
    print sql
    #cursor.execute(sql)
    sql="UNLOCK TABLES;"
    cursor.execute(sql)
    db.close
    return

for i in range(1,2):
    url = 'http://www.wooyun.org/bugs/page/%s' %(i)#想要爬行的网址
    info = {}
    result = requests.get(url,headers=header,timeout=15)
    recontent = result.content
    get_listTable =re.search('<table class=\"listTable\">(.*?)</table>',recontent,re.S)
    #print get_listTable.group(1)
    get_tbody =re.search('<tbody>(.*?)</tbody>',get_listTable.group(1),re.S)
    get_tr =re.findall('<tr>(.*?)</tr>', get_tbody.group(1), re.S)#re.S表示表示多行匹配，提取所有td标签
    #print get_tr
    index=0
    for i in get_tr:
        info['time']=re.search('<th>(.*?)</th>',i,re.S).group(1)
        info['url'] ='http://www.wooyun.org' + re.search('href="(.*?)">', i,re.S).group(1)#正则匹配漏洞列表的URL，结果是unicode编码
        info['title']=re.search('\">(.*?)</a>', i,re.S).group(1)#正则匹配漏洞列表的标题，结果是unicode编码
        Save(info)


        #print info['time']
        #print info['title'].unquote(str(s)).dcode('utf8')
        #print info['url']
        #if keys in info['title']: #关键字跟所获取的漏洞标题相匹配
         #   print info
