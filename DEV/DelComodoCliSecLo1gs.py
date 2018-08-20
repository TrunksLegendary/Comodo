import os, sys
drive = os.popen("echo %SYSTEMDRIVE%").readline().strip()
x = (drive + '\ProgramData\DeleteMe.txt')
print x
#os.remove(drive + '\ProgramData\DeleteMe.txt')
os.remove(x)
    