    def GetBugList(self,url,headers):#获取漏洞列表
        global bug_time
        global bug_title
        global bug_url

        high="SELECT key_info FROM bug_keys WHERE key_level='high'"#高危SQL语句
        medium="SELECT key_info FROM bug_keys WHERE key_level='medium'"#中危SQL语句
        low="SELECT key_info FROM bug_keys WHERE key_level='low'"   #低危SQL语句
        #数据库连接信息
        cnx = mysql.connector.connect(user='root', password='root',host='127.0.0.1',database='wooyun_bug')
        cursor = cnx.cursor(buffered=True)  

        info = {}
        html = requests.get(url,headers = headers)
        content = html.content
        get_tr =re.findall(r'<tr>\r\n\t\t\t\t\t<th>2.*?</tr>', content, re.S)

        for i in get_tr:
            info['bug_time']=re.findall(r'<th>(.*?)</th>', i)[0]#漏洞时间
            info['bug_url'] ='http://www.wooyun.org' + re.findall('href="(.*?)">', i)[0]#漏洞URL
            info['bug_title']=re.findall('">(.*?)</a>', i)[0]    #漏洞标题       
            try:#录入高危漏洞信息
                cursor.execute(high)
                for key in cursor:
                    if key[0].encode("UTF-8") in info['bug_title']:

                        add_bug = ("INSERT INTO bug_test "
                                       "(bug_time, bug_title, bug_url, bug_level,bug_from) "
                                       "VALUES (%s, %s, %s, 'high','wooyun')")
                        data_bug = (info['bug_time'], info['bug_url'], info['bug_title'])
                        cursor.execute(add_bug, data_bug)#执行SQL语句
            except mysql.connector.Error as err:
                print("insert high bug failed")
            try:#录入中危漏洞信息
                cursor.execute(medium)
                for key in cursor:
                    if key[0].encode("UTF-8") in info['bug_title']:
                        add_bug = ("INSERT INTO bug_test "
                                       "(bug_time, bug_title, bug_url, bug_level, bug_from) "
                                       "VALUES (%s, %s, %s, 'medium', 'wooyun')")
                        data_bug = (info['bug_time'], info['bug_url'], info['bug_title'])
                        cursor.execute(add_bug, data_bug)#执行SQL语句
            except mysql.connector.Error as err:
                print("insert medium bug failed")
            try:#录入低位漏洞信息
                cursor.execute(low)
                for key in cursor:
                    if key[0].encode("UTF-8") in info['bug_title']:
                        add_bug = ("INSERT INTO bug_test "
                                       "(bug_time, bug_title, bug_url, bug_level,bug_from) "
                                       "VALUES (%s, %s, %s, 'low','wooyun')")
                        data_bug = (info['bug_time'], info['bug_url'], info['bug_title'])
                        cursor.execute(add_bug, data_bug)#执行SQL语句
            except mysql.connector.Error as err:
                print("insert medium bug failed")
        cnx.commit()#提交事务
        cursor.close()
        cnx.close()
