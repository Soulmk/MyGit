#!/usr/bin/python
# -*- coding: utf-8 -*-
#__author__ = 'KK@补丁君'


import requests
# from bs4 import BeautifulSoup
# import lxml
import re
import mysql.connector
from mysql.connector import errorcode
import time

from datetime import date, time, datetime, timedelta


               
def GetBug():#获取漏洞列表
    global bug_time
    global bug_title
    global bug_url

    high="SELECT key_info FROM bug_keys WHERE key_level='high'"#高危SQL语句
    medium="SELECT key_info FROM bug_keys WHERE key_level='medium'"#中危SQL语句
    low="SELECT key_info FROM bug_keys WHERE key_level='low'"   #低危SQL语句
    #数据库连接信息
    cnx = mysql.connector.connect(user='root', password='root',host='127.0.0.1',database='wooyun_bug')
    cursor = cnx.cursor(buffered=True)  

    now = datetime.now()
    now_time = now.strftime('%Y-%m-%d %H:%M:%S') #获取当前时间

    max_page=30#爬取的最大页数


    for i in range(1,max_page+1):
        url = 'https://butian.360.cn/vul/list-more/state/8/page/%s' %(i)#想要爬行的网址
        headers = {
          "Host":"butian.360.cn",
          "User-Agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.106 Safari/537.36",
          "Accept":"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
          "Accept-Language": "zh-CN,zh;q=0.8",
          "Accept-Encoding":"gzip, deflate, sdch",
          "Referer":"https://butian.360.cn/vul/list-more/state/8",
          "Connection":"keep-alive"}
        info = {}
        html = requests.get(url,headers = headers)
        content = html.content
        get_list =re.findall(r'<div class="ld-lsit-info">.*?<span class="color_td1">', content, re.S)

        if i == 1:
            f = open('sign.txt', 'r')#读取文件中的标记url

            sign=f.read()#取出标记的url 

            f.close()

            sign_url=re.findall(r'<a href="(/vul/info/qid/QTVA-.*?)">',content)[0]#获取第一条url以作为最后写入文件当标记url

            f = open('sign.txt','w')

            f.write('https://butian.360.cn'+sign_url)#写入每次程序运行的第一页的第一条url作为下次的标记

            f.close()
            for j in get_list:
                info['bug_title'] = re.findall(r'<a href="/vul/info/qid/QTVA-.*?>(.*?)</a>',j)[0]
                info['bug_url'] = 'https://butian.360.cn' + re.findall(r'<a href="(/vul/info/qid/QTVA-.*?)">',j)[0]
                info['bug_time'] = re.findall(r'<p>(.*?) <span class="color_td1">',j)[0]
                info['bug_time'] = re.sub('年', '-', info['bug_time'])
                info['bug_time'] = re.sub('月', '-', info['bug_time'])
                info['bug_time'] = re.sub('日', '', info['bug_time'])
                try:#录入高危漏洞信息
                    cursor.execute(high)
                    for key in cursor:
                        if key[0].encode("UTF-8") in info['bug_title']:

                            add_bug = ("INSERT INTO bug_test "
                                           "(bug_time, bug_title, bug_url, bug_level,bug_from) "
                                           "VALUES (%s, %s, %s, 'high','360butian')")
                            data_bug = (info['bug_time'], info['bug_title'], info['bug_url'])
                            cursor.execute(add_bug, data_bug)#执行SQL语句
                except mysql.connector.Error as err:
                    print now_time+"---SQL error---insert high bug failed"
                try:#录入中危漏洞信息
                    cursor.execute(medium)
                    for key in cursor:
                        if key[0].encode("UTF-8") in info['bug_title']:
                            add_bug = ("INSERT INTO bug_test "
                                           "(bug_time, bug_title, bug_url, bug_level, bug_from) "
                                           "VALUES (%s, %s, %s, 'medium', '360butian')")
                            data_bug = (info['bug_time'], info['bug_title'], info['bug_url'])
                            cursor.execute(add_bug, data_bug)#执行SQL语句
                except mysql.connector.Error as err:
                    print now_time+"---SQL error---insert medium bug failed"
                try:#录入低位漏洞信息
                    cursor.execute(low)
                    for key in cursor:
                        if key[0].encode("UTF-8") in info['bug_title']:
                            add_bug = ("INSERT INTO bug_test "
                                           "(bug_time, bug_title, bug_url, bug_level,bug_from) "
                                           "VALUES (%s, %s, %s, 'low','360butian')")
                            data_bug = (info['bug_time'], info['bug_title'], info['bug_url'])
                            cursor.execute(add_bug, data_bug)#执行SQL语句
                except mysql.connector.Error as err:
                    print now_time+"---SQL error---insert medium bug failed"
        else:
            for j in get_list:
                info['bug_title'] = re.findall(r'<a href="/vul/info/qid/QTVA-.*?>(.*?)</a>',j)[0]
                info['bug_url'] = 'https://butian.360.cn' + re.findall(r'<a href="(/vul/info/qid/QTVA-.*?)">',j)[0]
                info['bug_time'] = re.findall(r'<p>(.*?) <span class="color_td1">',j)[0]
                info['bug_time'] = re.sub('年', '-', info['bug_time'])
                info['bug_time'] = re.sub('月', '-', info['bug_time'])
                info['bug_time'] = re.sub('日', '', info['bug_time'])

                if sign in info['bug_url']:
                    break
                else:

                    try:#录入高危漏洞信息
                        cursor.execute(high)
                        for key in cursor:
                            if key[0].encode("UTF-8") in info['bug_title']:

                                add_bug = ("INSERT INTO bug_test "
                                               "(bug_time, bug_title, bug_url, bug_level,bug_from) "
                                               "VALUES (%s, %s, %s, 'high','360butian')")
                                data_bug = (info['bug_time'], info['bug_title'], info['bug_url'])
                                cursor.execute(add_bug, data_bug)#执行SQL语句
                    except mysql.connector.Error as err:
                        print now_time+"---SQL error---insert high bug failed"
                    try:#录入中危漏洞信息
                        cursor.execute(medium)
                        for key in cursor:
                            if key[0].encode("UTF-8") in info['bug_title']:
                                add_bug = ("INSERT INTO bug_test "
                                               "(bug_time, bug_title, bug_url, bug_level, bug_from) "
                                               "VALUES (%s, %s, %s, 'medium', '360butian')")
                                data_bug = (info['bug_time'], info['bug_title'], info['bug_url'])
                                cursor.execute(add_bug, data_bug)#执行SQL语句
                    except mysql.connector.Error as err:
                        print now_time+"---SQL error---insert medium bug failed"
                    try:#录入低位漏洞信息
                        cursor.execute(low)
                        for key in cursor:
                            if key[0].encode("UTF-8") in info['bug_title']:
                                add_bug = ("INSERT INTO bug_test "
                                               "(bug_time, bug_title, bug_url, bug_level,bug_from) "
                                               "VALUES (%s, %s, %s, 'low','360butian')")
                                data_bug = (info['bug_time'], info['bug_title'], info['bug_url'])
                                cursor.execute(add_bug, data_bug)#执行SQL语句
                    except mysql.connector.Error as err:
                        print now_time+"---SQL error---insert medium bug failed"
    cnx.commit()#提交事务
    cursor.close()
    cnx.close()


#设置定时任务:多长时间执行一次爬行
def runTask(func, day=0, hour=0, min=0, second=0):
  now = datetime.now()
  period = timedelta(days=day, hours=hour, minutes=min, seconds=second)
  next_time = now + period
  strnext_time = next_time.strftime('%Y-%m-%d %H:%M:%S')
  while True:
      iter_now = datetime.now()
      iter_now_time = iter_now.strftime('%Y-%m-%d %H:%M:%S') 
      if str(iter_now_time) == str(strnext_time):
          print "start_work: %s" % iter_now_time
          func()
          print "this_task_done."
          iter_time = iter_now + period
          strnext_time = iter_time.strftime('%Y-%m-%d %H:%M:%S')
          print "next_iter: %s \n\n" % strnext_time
          continue

if __name__ == "__main__":

    runTask(GetBug, day=0, hour=0, min=1,second=0)#一分钟定时任务
    
