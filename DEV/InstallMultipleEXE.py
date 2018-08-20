import os
import subprocess

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

    from subprocess import PIPE, Popen
    with disable_file_system_redirection():
        OBJ = Popen(CMD, shell = True, stdout = PIPE, stderr = PIPE)
    out, err = OBJ.communicate()
    print out
    print err
    RET = OBJ.returncode
    if RET == 0:
        if RES == True:
            if out:
                return out.strip()
            else:
                return True
        else:
            return True
    else:
        if RES == True:
            if err:
                return err.strip()
            else:
                return False
        else:
            return False

############################################################
# Below enter paths to your executables
#
############################################################

CMD = []
CMD.append("path and filename of executable 1")
CMD.append("path and filename of executable 2")
CMD.append("path and filename of executable 3")
# EXAMPLE1: CMD.append('MsiExec.exe \\server\path\path2\myMSI.msi /qn REBOOT=ReallySuppress  /L*V "c:\\windows\\temp\\LogFile.log"')
# EXAMPLE2: CMD.append('\\server\path\path2\myEXE.exe /myswitches')

x=0
for i in CMD:
    process = ExecuteCMD(i)
    if process :
        print "Installation  Successfull"
    else:
        print "Setup Needs to restart your system and run the script Again"
    x+=1
