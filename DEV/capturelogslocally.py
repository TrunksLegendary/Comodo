no=70   # Timeout 
Head_computer=r'DESKTOP-3L1G08R' # Head computer to send the email 
KEY=r'aBC123456'  # Define your 9 digit strong alphanumeric key 
import ast
import threading
import time
import os
from subprocess import PIPE, Popen
import ctypes
import shutil
import pubnub
def Download(URL, DownloadTo = None, FileName = None):
    import urllib
    import ssl
    if FileName:
        FileName = FileName
    else:
        FileName = URL.split('/')[-1]
        
    if DownloadTo:
        DownloadTo = DownloadTo
    else:
        DownloadTo = os.path.join(os.environ['TEMP'])
        
    DF = os.path.join(DownloadTo, FileName)
    with open(os.path.join(DownloadTo, FileName), 'wb') as f:
        try:
            context = ssl._create_unverified_context()
            f.write(urllib.urlopen(URL,context=context).read())
        except:
            f.write(urllib.urlopen(URL).read())
    if os.path.isfile(DF):
        return DF
    else:
        return False

def zip_item(path,final_path):  # Creating ZIP file
    import zipfile
    zip_ref = zipfile.ZipFile(path, 'r')
    zip_ref.extractall(final_path)
    zip_ref.close()
    return final_path

def Import_pubnub(DEST):
    BDPATH = Download(r'https://drive.google.com/uc?export=download&id=1R1KFmrC0jh6TOdCFePt2SNTbu_ti_CpP', FileName = 'PUBNUB.zip')
    SRC = os.path.join(os.environ['TEMP'])
    path=zip_item(BDPATH,SRC)
    SRC = os.path.join(os.environ['TEMP'],'PUBNUB')
    from distutils.dir_util import copy_tree
    copy_tree(SRC, DEST)
    import pubnub 
    from pubnub.pnconfiguration import PNConfiguration
    from pubnub.pubnub import PubNub
    from pubnub.callbacks import SubscribeCallback
    print "Pubnub is imported"
    return DEST

import os
import subprocess
import shutil,urllib2,time
from subprocess import PIPE, Popen
import socket
import smtplib
import mimetypes
import ctypes
import _winreg
import os.path

class disable_file_system_redirection:
    _disable = ctypes.windll.kernel32.Wow64DisableWow64FsRedirection
    _revert = ctypes.windll.kernel32.Wow64RevertWow64FsRedirection
    def __enter__(self):
        self.old_value = ctypes.c_long()
        self.success = self._disable(ctypes.byref(self.old_value))
    def __exit__(self, type, value, traceback):
        if self.success:
            self._revert(self.old_value)
            

import _winreg
import os
def computername():
    import os
    return os.environ['COMPUTERNAME']

## get ip address
def ipaddress():
    import socket
    return socket.gethostbyname(socket.gethostname())
## detect all installed software through registry key            

def DNDS(rtkey, pK, kA):
    ln = []
    lv = []
    try:
        oK = _winreg.OpenKey(rtkey, pK, 0, kA)
        i = 0
        while True:
            try:
                bkey = _winreg.EnumKey(oK, i)
                vkey = os.path.join(pK, bkey)
                oK1 = _winreg.OpenKey(rtkey, vkey, 0, kA)
                try:
                    tls = []
                    DN, bla = _winreg.QueryValueEx(oK1, 'DisplayName')
                    DV, bla = _winreg.QueryValueEx(oK1, 'DisplayVersion')
                    _winreg.CloseKey(oK1)
                    ln.append(DN)
                    lv.append(DV)
                except:
                    pass
                i += 1
            except:
                break
        _winreg.CloseKey(oK)
        return zip(ln, lv)
    except:
        return zip(ln, lv)


## detect whether the computer is 32 bit or 64 bit
'''
def INSTALLED(KEY):
    SAM=[]
    SAM.append(KEY)
    rK = _winreg.HKEY_LOCAL_MACHINE
    sK = r'SYSTEM\CurrentControlSet\Control\Session Manager\Environment'
    openedKey = _winreg.OpenKey(rK, sK, 0, _winreg.KEY_READ)
    arch, bla = _winreg.QueryValueEx(openedKey, 'PROCESSOR_ARCHITECTURE')
    arch = str(arch)
    _winreg.CloseKey(openedKey)
    ## sorting all collected data from all the way, filtered duplicates and listed the final result!
    if arch == 'AMD64':
        fList = DNDS(_winreg.HKEY_LOCAL_MACHINE, r'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall', _winreg.KEY_WOW64_32KEY | _winreg.KEY_READ)
        fList.extend(DNDS(_winreg.HKEY_LOCAL_MACHINE, r'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall', _winreg.KEY_WOW64_64KEY | _winreg.KEY_READ))
        fList.extend(DNDS(_winreg.HKEY_CURRENT_USER, r'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall', _winreg.KEY_WOW64_32KEY | _winreg.KEY_READ))
        fList.extend(DNDS(_winreg.HKEY_CURRENT_USER, r'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall', _winreg.KEY_WOW64_64KEY | _winreg.KEY_READ))
    else:
        fList = DNDS(_winreg.HKEY_LOCAL_MACHINE, r'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall', _winreg.KEY_READ)
        fList.extend(DNDS(_winreg.HKEY_CURRENT_USER, r'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall', _winreg.KEY_READ))
    fList = set(fList)
    j = 1
    import re
    
    for i in sorted(fList):
        a, b = i
        try:
            a='{:<100} '.format(a.encode('utf-8'))
            b='{:>20}'.format(b.encode('utf-8'))
            a=re.sub("\s\s+" , "", a)
            a=a.replace(',','')
            b=re.sub("\s\s+" , "", b)
            b=b.replace(',','')
            SAM.append(computername()+","+ ipaddress()+","+a+","+b)
            SAM.append("\n")
        except :
            pass
        j += 1
    
    return SAM
'''

def INSTALLED(KEY):
    SAM=[]
    SAM.append(KEY)
    import os
    import re
    CMD1=os.popen('net localgroup administrators').read()
    for i in [i.strip() for i in CMD1.split('\n')  if i.strip()]:
        SAM.append(i)

    d=SAM[5:-1]
    for i in range(0,len(d)):
        SAM.append(os.environ['COMPUTERNAME'])
        SAM.append(''+'\n')      
    SAM=', '.join(d)

    fList = SAM
    
    j = 1
    import re
    
    for i in fList:
        a, b = i
        try:
            a='{:<100} '.format(a.encode('utf-8'))
            b='{:>20}'.format(b.encode('utf-8'))
            a=re.sub("\s\s+" , "", a)
            a=a.replace(',','')
            b=re.sub("\s\s+" , "", b)
            b=b.replace(',','')
            SAM.append(computername()+","+ ipaddress()+","+a+","+b)
            SAM.append("\n")
        except :
            pass
        j += 1
    
    return SAM

list_head=['Computer_Name', "LocalAdmin"]

def publish_nonhead():
    import time    
    time.sleep(30)
    from pubnub.pnconfiguration import PNConfiguration
    from pubnub.pubnub import PubNub
    from pubnub.callbacks import SubscribeCallback
    from pubnub.pnconfiguration import PNConfiguration
    from pubnub.pubnub import PubNub
    publish_key1= 'pub-c-7a797a24-388e-411c-b848-9bd170919784'
    subscribe_key1= 'sub-c-b1b31f80-179a-11e8-95aa-1eb18890f15d'
     
    pnconfig = PNConfiguration()
    pnconfig.subscribe_key = subscribe_key1
    pnconfig.publish_key = publish_key1
    pnconfig.ssl = True
     
    pubnub = PubNub(pnconfig)
    import time
    from pubnub.exceptions import PubNubException
    try:
		
        envelope = pubnub.publish().channel("Channel-706fxzjkv").message(INSTALLED(KEY)).sync()
        print("publish timetoken: %d" % envelope.result.timetoken)
    except PubNubException as e:
            print e

def publish(no):
    import pubnub 
    from pubnub.pnconfiguration import PNConfiguration
    from pubnub.pubnub import PubNub
    from pubnub.callbacks import SubscribeCallback

    from pubnub.pnconfiguration import PNConfiguration
    from pubnub.pubnub import PubNub
    publish_key1= 'pub-c-7a797a24-388e-411c-b848-9bd170919784'
    subscribe_key1= 'sub-c-b1b31f80-179a-11e8-95aa-1eb18890f15d'
     
    pnconfig = PNConfiguration()
    pnconfig.subscribe_key = subscribe_key1
    pnconfig.publish_key = publish_key1
    pnconfig.ssl = True
     
    pubnub = PubNub(pnconfig)
    import time
    s=3*no
    time.sleep(s)  


    from pubnub.exceptions import PubNubException
    try:
        envelope = pubnub.publish().channel("Channel-706fxzjkv").message(INSTALLED(KEY)).sync()
        print("publish timetoken: %d" % envelope.result.timetoken)
        
        app_process=os.getpid()
        app_process=str(app_process)
        import subprocess;
        import ctypes
        class disable_file_system_redirection:
                _disable = ctypes.windll.kernel32.Wow64DisableWow64FsRedirection
                _revert = ctypes.windll.kernel32.Wow64RevertWow64FsRedirection
                def __enter__(self):
                        self.old_value = ctypes.c_long()
                        self.success = self._disable(ctypes.byref(self.old_value))
                def __exit__(self, type, value, traceback):
                        if self.success:
                                self._revert(self.old_value)

        time.sleep(5) 
        with disable_file_system_redirection():
            CMD='taskkill /F /PID %s'%app_process
            print CMD
            process=subprocess.Popen(CMD,shell=True,stdout=subprocess.PIPE);
            result=process.communicate()[0]
            print (result)
    except PubNubException as e:
            print e


class LongFunctionInside(object):
    lock_state = threading.Lock()
    working = False

    def long_function(self, timeout,no):

        self.working = True

        timeout_work = threading.Thread(name="thread_name", target=self.work_time, args=(timeout,))
        timeout_work.setDaemon(True)
        timeout_work.start()
        import logging

        import pubnub
        from pubnub.exceptions import PubNubException
        from pubnub.pnconfiguration import PNConfiguration
        from pubnub.pubnub import PubNub, SubscribeListener

        import time
        import os
        pnconfig = PNConfiguration()
         
        pnconfig.subscribe_key = 'sub-c-b1b31f80-179a-11e8-95aa-1eb18890f15d'
        pnconfig.publish_key = ''

        pubnub = PubNub(pnconfig)
        n=0
        my_listener = SubscribeListener()

        pubnub.subscribe().channels('Channel-706fxzjkv').execute()
        folder=os.environ['SYSTEMDRIVE']+r'\Temp'
        if os.path.exists(folder):
            fp=os.path.join(folder,"new.csv")
        else:
            os.mkdir(folder)
            fp=os.path.join(folder,"new.csv")
        sample=''
        for i in list_head:
            if i == None:
                sample=sample+"None"+","
            else:
                sample=sample+i+","
        import sys
        reload(sys)
        sys.setdefaultencoding('utf8')
        with open(fp,'w') as f:
            f.write(sample)
            f.write('\n')
        while True:
            print "Listening..."# endless/long work
            pubnub.add_listener(my_listener)
            result = my_listener.wait_for_message_on('Channel-706fxzjkv')
            pubnub.remove_listener(my_listener)
            result=result.message
            print result[0]
            sample=""
            if(result[0]==KEY):
                with open(fp,'a+') as f:
                    for i in range(1,len(result)):
                        if result[i] == None:
                            sample=sample+"None"
                        else:
                            sample=sample+result[i]
                    f.write(sample)                   
                    f.write('\n')
            if not self.working:  # if state is working == true still working
                break
        self.set_state(True)

    def work_time(self, sleep_time):
        print sleep_time# thread function that just sleeping specified time,
        
        time.sleep(sleep_time)
        if self.working:
            publish(no)            
            self.set_state(False)

    def set_state(self, state):  # secured state change
        while True:
            self.lock_state.acquire()
            try:
                self.working = state
                break
            finally:
                self.lock_state.release()

HOMEPATH = r"C:\Temp"
if os.path.exists(HOMEPATH):
        HOMEPATH = r"C:\Temp"
else:
    HOMEPATH =r"C:\Temp"
DEST= os.path.join(HOMEPATH,r'COMODO\Comodo ITSM\Lib\site-packages')
Folders=os.listdir(DEST)
Nodow=0
Del_folders=['certifi', 'certifi-2018.1.18.dist-info','chardet', 'chardet-3.0.4.dist-info', 'Cryptodome', 'pubnub', 'pubnub-4.0.13.dist-info', 'pycryptodomex-3.4.12.dist-info','requests']
for i in Del_folders:
    if i in Folders:
        Nodow=Nodow+1
if Nodow>7:
    c=0
else:
    DEST=Import_pubnub(DEST)
computer=os.environ['computername']
import os
if computer==Head_computer :
	lw = LongFunctionInside()
	lw.long_function(0.1,no)
else:
    publish_nonhead()