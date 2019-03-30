# -*- coding:utf-8 -*-

import requests
import re
from store_mysql import Mysql
import MySQLdb


class weiboSpider(object):
    headers = {
        "user-agent": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.116 Safari/537.36"
    }
    cookies = {
        'TC-Page-G0': '1bbd8b9d418fd852a6ba73de929b3d0c',
        'login_sid_t': '0554454a652ee2a19c672e92ecee3220',
        '_s_tentry': '-',
        'Apache': '8598167916889.414.1493773707704',
        'SINAGLOBAL': '8598167916889.414.1493773707704',
        'ULV': '1493773707718:1:1:1:8598167916889.414.1493773707704:',
        'SCF': 'An3a20Qu9caOfsjo36dVvRQh7tKzwKwWXX7CdmypYAwRoCoWM94zrQyZ-5QJPjjDRpp2fBxA_9d6-06C8vLD490.',
        'SUB': '_2A250DV37DeThGeNO7FEX9i3IyziIHXVXe8gzrDV8PUNbmtAKLWbEkW8qBangfcJP4zc_n3aYnbcaf1aVNA..',
        'SUBP': '0033WrSXqPxfM725Ws9jqgMF55529P9D9WhR6nHCyWoXhugM0PU8VZAu5JpX5K2hUgL.Fo-7S0ecSoeXehB2dJLoI7pX9PiEIgij9gpD9J-t',
        'SUHB': '0jBY7fPNWFbwRJ',
        'ALF': '1494378549',
        'SSOLoginState': '1493773739',
        'wvr': '6',
        'UOR': ',www.weibo.com,spr_sinamkt_buy_lhykj_weibo_t111',
        'YF-Page-G0': '19f6802eb103b391998cb31325aed3bc',
        'un': 'fengshengjie5 @ live.com'
    }

    def __init__(self):
        field = ['title', 'name', 'id', 'wblevel', 'addr', 'graduate', 'care', 'careurl', 'fans', 'fansurl', 'wbcount',
                 'wburl']
        conn = MySQLdb.connect(user='root', passwd='123456', db='zhihu', charset='utf8')
        conn.autocommit(True)
        self.cursor = conn.cursor()
        self.mysql = Mysql('sina', field, len(field) + 1)

    def getUserData(self, id):
        self.cursor.execute('select id from sina where id=%s', (id,))
        data = self.cursor.fetchall()
        if data:
            pass
        else:
            item = {}
            # test = [5321549625,1669879400,1497035431,1265189091,5705874800,5073663404,5850521726,1776845763]
            url = 'http://weibo.com/u/' + id + '?topnav=1&wvr=6&retcode=6102'
            data = requests.get(url, headers=self.headers, cookies=self.cookies).text
            # print data
            id = url.split('?')[0].split('/')[-1]
            try:
                title = re.findall(r'<title>(.*?)</title>', data)[0]
                title = title.split('_')[0]
            except:
                title = u''
            try:
                name = re.findall(r'class=\\"username\\">(.+?)<', data)[0]
            except:
                name = u''
            try:
                totals = re.findall(r'class=\\"W_f\d+\\">(\d*)<', data)
                care = totals[0]
                fans = totals[1]
                wbcount = totals[2]
            except:
                care = u''
                fans = u''
                wbcount = u''
            try:
                urls = re.findall(r'class=\\"t_link S_txt1\\" href=\\"(.*?)\\"', data)
                careUrl = urls[0].replace('\\', '').replace('#place', '&retcode=6102')
                fansUrl = urls[1].replace('\\', '').replace('#place', '&retcode=6102')
                wbUrl = urls[2].replace('\\', '').replace('#place', '&retcode=6102')
            except:
                careUrl = u''
                fansUrl = u''
                wbUrl = u''
            profile = re.findall(r'class=\\"item_text W_fl\\">(.+?)<', data)
            try:
                wblevel = re.findall(r'title=\\"(.*?)\\"', profile[0])[0]
                addr = re.findall(u'[\u4e00-\u9fa5]+', profile[1])[0]  # 地址
            except:
                profile1 = re.findall(r'class=\\"icon_group S_line1 W_fl\\">(.+?)<', data)
                try:
                    wblevel = re.findall(r'title=\\"(.*?)\\"', profile1[0])[0]
                except:
                    wblevel = u''
                try:
                    addr = re.findall(u'[\u4e00-\u9fa5]+', profile[0])[0]
                except:
                    addr = u''
            try:
                graduate = re.findall(r'profile&wvr=6\\">(.*?)<', data)[0]
            except:
                graduate = u''
            item[1] = title
            item[2] = name
            item[3] = id
            item[4] = wblevel
            item[5] = addr
            item[6] = graduate
            item[7] = care
            item[8] = careUrl
            item[9] = fans
            item[10] = fansUrl
            item[11] = wbcount
            item[12] = wbUrl
