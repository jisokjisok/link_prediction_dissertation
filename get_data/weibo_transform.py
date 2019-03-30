# -*- coding:utf-8 -*-
import requests
import re
import random
from proxy import Proxy
from getCookie import COOKIE
from time import sleep
from store_mysql import Mysql
from weibo_spider import weiboSpider


class fansSpider(object):
    headers = [
        {
            "user-agent": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.116 Safari/537.36"},
        {
            "user-agent": "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.1 (KHTML, like Gecko) Chrome/22.0.1207.1 Safari/537.1"},
        {
            "user-agent": "Mozilla/5.0 (X11; CrOS i686 2268.111.0) AppleWebKit/536.11 (KHTML, like Gecko) Chrome/20.0.1132.57 Safari/536.11"},
        {
            "user-agent": "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/536.6 (KHTML, like Gecko) Chrome/20.0.1092.0 Safari/536.6"},
        {
            "user-agent": "Mozilla/5.0 (Windows NT 6.2) AppleWebKit/536.6 (KHTML, like Gecko) Chrome/20.0.1090.0 Safari/536.6"},
        {
            "user-agent": "Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.1 (KHTML, like Gecko) Chrome/19.77.34.5 Safari/537.1"},
        {
            "user-agent": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/536.5 (KHTML, like Gecko) Chrome/19.0.1084.9 Safari/536.5"},
        {
            "user-agent": "Mozilla/5.0 (Windows NT 6.0) AppleWebKit/536.5 (KHTML, like Gecko) Chrome/19.0.1084.36 Safari/536.5"},
        {
            "user-agent": "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1063.0 Safari/536.3"},
        {
            "user-agent": "Mozilla/5.0 (Windows NT 5.1) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1063.0 Safari/536.3"},
        {
            "user-agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_0) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1063.0 Safari/536.3"},
        {
            "user-agent": "Mozilla/5.0 (Windows NT 6.2) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1062.0 Safari/536.3"},
        {
            "user-agent": "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1062.0 Safari/536.3"},
        {
            "user-agent": "Mozilla/5.0 (Windows NT 6.2) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1061.1 Safari/536.3"},
        {
            "user-agent": "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1061.1 Safari/536.3"},
        {
            "user-agent": "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1061.1 Safari/536.3"},
        {
            "user-agent": "Mozilla/5.0 (Windows NT 6.2) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1061.0 Safari/536.3"},
        {
            "user-agent": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.24 (KHTML, like Gecko) Chrome/19.0.1055.1 Safari/535.24"},
        {
            "user-agent": "Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/535.24 (KHTML, like Gecko) Chrome/19.0.1055.1 Safari/535.24"}
    ]

    def __init__(self):
        self.wbspider = weiboSpider()
        self.proxie = Proxy()
        self.cookie = COOKIE()
        self.cookies = self.cookie.getcookie()
        field = ['id']
        self.mysql = Mysql('sinaid', field, len(field) + 1)
        self.key = 1

    def getData(self, url):
        self.url = url
        proxies = self.proxie.popip()
        print
        self.cookies
        print
        proxies
        r = requests.get("https://www.baidu.com", headers=random.choice(self.headers), proxies=proxies)
        while r.status_code != requests.codes.ok:
            proxies = self.proxie.popip()
            r = requests.get("https://www.baidu.com", headers=random.choice(self.headers), proxies=proxies)
        data = requests.get(self.url, headers=random.choice(self.headers), cookies=self.cookies, proxies=proxies,
                            timeout=20).text
        # print data
        infos = re.findall(r'fnick=(.+?)&f=1\\', data)
        if infos is None:
            self.cookies = self.cookie.getcookie()
            data = requests.get(self.url, headers=random.choice(self.headers), cookies=self.cookies, proxies=proxies,
                                timeout=20).text
            infos = re.findall(r'fnick=(.+?)&f=1\\', data)
        fans = []
        for info in infos:
            fans.append(info.split('&')[0])
        try:
            totalpage = re.findall(r'Pl_Official_HisRelation__6\d+\\">(\d+)<', data)[-1]
            print
            totalpage
        except:
            totalpage = 1
        # totalpage = re.findall(r'Pl_Official_HisRelation__\d+\\">(\d+)<', data)[-1]
        Id = [one for one in re.findall(r'usercard=\\"id=(\d+)&', data)]
        self.totalid = [Id[i] for i in range(1, len(fans) * 2 + 1, 2)]
        if int(totalpage) == 1:
            for one in self.totalid:
                self.wbspider.getUserData(one)
            item = {}
            for one in self.totalid:
                item[1] = one
                self.mysql.insert(item)
                fansurl = 'http://weibo.com/p/100505' + one + '/follow?from=page_100505&wvr=6&mod=headfollow&retcode=6102'
                # fansurl = 'http://weibo.com/p/100505' + one + '/follow?relate=fans&from=100505&wvr=6&mod=headfans&current=fans&retcode=6102'
                fan.getData(fansurl)
        elif int(totalpage) >= 5:
            totalpage = 5
        self.mulpage(totalpage)
        # if self.key == 1:
        #      self.mulpage(totalpage)
        # else:
        #     self.carepage(totalpage)

    def carepage(self,pages):
        #self.key=1
        urls = ['http://weibo.com/p/1005051497035431/follow?page={}&retcode=6102'.format(i) for i in range(2, int(pages) + 1)]
        for url in urls:
            sleep(2)
            print url.split('&')[-2]
            proxies = self.proxie.popip()
            r = requests.get("https://www.baidu.com", headers=random.choice(self.headers), proxies=proxies)
            print r.status_code
            while r.status_code != requests.codes.ok:
                proxies = self.proxie.popip()
                r = requests.get("https://www.baidu.com", headers=random.choice(self.headers), proxies=proxies)
            data = requests.get(url, headers=random.choice(self.headers), cookies=self.cookies, proxies=proxies,
                                timeout=20).text
            # print data
            infos = re.findall(r'fnick=(.+?)&f=1\\', data)
            if infos is None:
                self.cookies = self.cookie.getcookie()
                data = requests.get(self.url, headers=random.choice(self.headers), cookies=self.cookies,
                                    proxies=proxies,
                                    timeout=20).text
                infos = re.findall(r'fnick=(.+?)&f=1\\', data)
            fans = []
            for info in infos:
                fans.append(info.split('&')[0])
            Id = [one for one in re.findall(r'usercard=\\"id=(\d+)&', data)]
            totalid = [Id[i] for i in range(1, len(fans) * 2 + 1, 2)]
            for one in totalid:
                # print one
                self.totalid.append(one)
        for one in self.totalid:
            sleep(1)
            self.wbspider.getUserData(one)
        item = {}
        for one in self.totalid:
            item[1] = one
            self.mysql.insert(item)
            fansurl = 'http://weibo.com/p/100505'+one+'/follow?from=page_100505&wvr=6&mod=headfollow&retcode=6102'
            #fansurl = 'http://weibo.com/p/100505' + one + '/follow?relate=fans&from=100505&wvr=6&mod=headfans&current=fans&retcode=6102'
            fan.getData(fansurl)
    def mulpage(self, pages):
        # self.key=2
        urls = ['http://weibo.com/p/1005051497035431/follow?relate=fans&page={}&retcode=6102'.format(i) for i in
                range(2, int(pages) + 1)]
        for url in urls:
            sleep(2)
            print
            url.split('&')[-2]
            proxies = self.proxie.popip()
            r = requests.get("https://www.baidu.com", headers=random.choice(self.headers), proxies=proxies)
            print
            r.status_code
            while r.status_code != requests.codes.ok:
                proxies = self.proxie.popip()
                r = requests.get("https://www.baidu.com", headers=random.choice(self.headers), proxies=proxies)
            data = requests.get(url, headers=random.choice(self.headers), cookies=self.cookies, proxies=proxies,
                                timeout=20).text
            # print data
            infos = re.findall(r'fnick=(.+?)&f=1\\', data)
            if infos is None:
                self.cookies = self.cookie.getcookie()
                data = requests.get(self.url, headers=random.choice(self.headers), cookies=self.cookies,
                                    proxies=proxies,
                                    timeout=20).text
                infos = re.findall(r'fnick=(.+?)&f=1\\', data)
            fans = []
            for info in infos:
                fans.append(info.split('&')[0])
            Id = [one for one in re.findall(r'usercard=\\"id=(\d+)&', data)]
            totalid = [Id[i] for i in range(1, len(fans) * 2 + 1, 2)]
            for one in totalid:
                # print one
                self.totalid.append(one)
        for one in self.totalid:
            sleep(1)
            self.wbspider.getUserData(one)
        item = {}
        for one in self.totalid:
            item[1] = one
            self.mysql.insert(item)
            # fansurl = 'http://weibo.com/p/1005055847228592/follow?from=page_100505&wvr=6&mod=headfollow&retcode=6102'
            fansurl = 'http://weibo.com/p/100505' + one + '/follow?relate=fans&from=100505&wvr=6&mod=headfans&current=fans&retcode=6102'
            fan.getData(fansurl)


if __name__ == "__main__":
    url = 'http://weibo.com/p/1005051497035431/follow?relate=fans&from=100505&wvr=6&mod=headfans&current=fans&retcode=6102'
    fan = fansSpider()
    fan.getData(url)