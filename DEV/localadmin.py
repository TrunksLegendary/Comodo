

import os
import subprocess
import shutil,urllib2,time
from subprocess import PIPE, Popen
import socket
import smtplib
import mimetypes
import ctypes
Head_computer=os.environ['COMPUTERNAME'] 
from subprocess import PIPE, Popen
import _winreg


def ipaddress():
    import socket
    return socket.gethostbyname(socket.gethostname())    
def computername():
    import os
    return os.environ['COMPUTERNAME']


def Collectlogs(fileToSend,computer_name):
    s=[]
    Obj = os.popen('net localgroup administrators').read()
    obj1 = os.popen('hostname').read()
    for i in [i.strip() for i in Obj.split('\n')  if i.strip()]:
        s.append(i)
    ki=[]
       
    a=s[4:-1]
    for c, value in enumerate(a, 1):
        i=","+str(c)+" "+value+"\n"
        ki.append(i)
        
	
    b="".join(ki)
    computer_name=computer_name
    fileToSend=os.path.join(os.environ['TEMP'],'local-admin-group.csv')
	
    with open(fileToSend, 'w') as f:
        f.write('Computer Name,Admin users\n')
        f.write(str(obj1))
        f.write(''+str(b))
        f.write('\n')
        f.write('\n')
def Download(Path, URL, FileName,Extension):
    import urllib2
    import os
    fn = FileName + Extension
    fp = os.path.join(Path, fn)
    req = urllib2.Request(URL, headers={'User-Agent' : "Magic Browser"})
    con = urllib2.urlopen(req)
    with open(fp, 'wb') as f:
        while True:
            chunk=con.read(100*1000*1000)
            if chunk:
                f.write(chunk)
            else:
                break
	return fp
    
def computername():
    return os.environ['COMPUTERNAME']
def ipaddress():
    return socket.gethostbyname(socket.gethostname())


    print "Report is sent head Computer"
work_directory=os.path.join(os.getenv('TEMP'),'local-admin-Report.csv')
print work_directory
try :
    shutil.rmtree(work_directory)
except:
    pass
try :
    os.remove(work_directory)
except:
    pass
try:
    os.remove(log_directory_path)
except :
    pass
log_directory_path=os.path.join(os.environ['TEMP'],Head_computer)
Collectlogs(log_directory_path,Head_computer)