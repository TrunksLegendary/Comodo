#To define a particular parameter, replace the 'parameterName' inside itsm.getParameter('parameterName') with that parameter's name
#############################################################################
##### PARAMETERS TO BE EDITED #####
#
## Network_path:
#Type: String
#ITSM Label: Any name
#Default value: path
#
## UserName:
#Type: String
#ITSM Label: Any name
#Default value: UserName
#
## Password:
#Type: String
#ITSM Label: Any name
#Default value: Password
#
############################################################################
Network_path=itsm.getParameter('Network_Path') #Provide the network share file path
share_user=itsm.getParameter('UserName') # Provide the user name for the shared system
share_pass=itsm.getParameter('Password') # Provide the password for the shared system
import os
import shutil
import ctypes
import subprocess
import socket
import time
from shutil import copyfile
v=socket.gethostname()
share_path=os.path.join(Network_path,v+'.xml')
path=r"C:\Settings.xml"

def ExecuteCMD(CMD, RES = False):
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
               
x = ('"C:\Program Files\COMODO\COMODO Internet Security\cfpconfg.exe" --xcfgExport="C:\Settings.xml" --filter=')
print (x)
y = ExecuteCMD(x)

print (y) 


class disable_file_system_redirection:
    _disable = ctypes.windll.kernel32.Wow64DisableWow64FsRedirection
    _revert = ctypes.windll.kernel32.Wow64RevertWow64FsRedirection
    def __enter__(self):
        self.old_value = ctypes.c_long()
        self.success = self._disable(ctypes.byref(self.old_value))
    def __exit__(self, type, value, traceback):
        if self.success:
            self._revert(self.old_value)  

def login(cmd,Filepath,path):    
    with disable_file_system_redirection():        
        print 'Login to Network share'
        print os.popen(cmd).read()
        print 'Copying files to Network share....'
        if os.path.isfile(path):
            copyfile(path,Filepath)
            print "\nFile with Device name Successfully transfered to Network Share\n"
        

if os.path.isfile(path):
    print "File exist : "+path
    cmd= 'NET USE "'+Network_path+'" /USER:'+share_user+'  "'+share_pass+'"'
    login(cmd,share_path,path)
else:
    print "File not exist : "+path