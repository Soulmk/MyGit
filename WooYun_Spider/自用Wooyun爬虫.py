#!/usr/bin/python
# -*- coding: utf-8 -*-
__author__ = 'KK-http://molok.lofter.com'

import re
import requests
import sys

reload(sys)
sys.setdefaultencoding('utf-8')

header = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; WOW64; rv:39.0) Gecko/20100101 Firefox/39.0'}
def getwooyun(pages,keys):
    for i in range(1,pages):
        url = 'http://www.wooyun.org/bugs/page/%s' %(i)#想要爬行的网址
        info = {}
        q = requests.get(url,headers=header,timeout=15)
        content = q.content
        get_td =re.findall('<td>(.*?)</td>', content, re.S)#re.S表示表示多行匹配，提取所有td标签
        for i in get_td:
            info['url'] ='http://www.wooyun.org' + re.findall('href="(.*?)">', i)[0]#正则匹配漏洞列表的URL，结果是unicode编码
            info['title']=re.findall('">(.*?)</a>', i)[0]#正则匹配漏洞列表的标题，结果是unicode编码
            if keys in info['title']: #关键字跟所获取的漏洞标题相匹配
                Write(info)

def Write(info):#将结果输出到HTML文件中
    f = open('KO.html', 'a')
    get = '<a href="' + info['url'] + ' "target="_blank">' + info['title'] + '</a><br><br>\n'
    f.write(get)
    f.close()
    return

if __name__ == '__main__':
    f = open('KO.html', 'w')
    code = '''<head><meta http-equiv="Content-Type" content="text/html; charset=utf-8" /></head><h1>Designed by <a href="http://molok.lofter.com" target="_blank">M0L0K</a></h1>'''
    f.write(code)
    f.close()
    pages = raw_input("Spider Pages:")#输入要爬行的页数
    keys = raw_input("Check Keys:")#输入要查询的关键字
    getwooyun(int(pages),keys.decode('gbk'))#keys为输入的关键字，汉字gbk解码为unicode，程序内外编码统一
    #decode 的作用是将其他编码的字符串转换成 Unicode 编码
    #encode 的作用是将Unicode编码转换成其他编码的字符串
    print "That's OK! Good Luck For You~"
