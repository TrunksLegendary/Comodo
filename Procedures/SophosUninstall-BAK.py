import os
import subprocess
import _winreg 

keyval=r'SOFTWARE\WOW6432Node\Sophos\SAVService\TamperProtection'
if not os.path.exists("keyval"):
    key = CreateKey(HKEY_LOCAL_MACHINE,keyval)
Registrykey= OpenKey(HKEY_LOCAL_MACHINE, keyval, 0,KEY_WRITE)
SetValueEx(Registrykey,"Enabled",0,REG_DWORD, 0)
CloseKey(Registrykey)

keyval=r'SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce'
if not os.path.exists("keyval"):
    key = CreateKey(HKEY_LOCAL_MACHINE,keyval)www
Registrykey= OpenKey(HKEY_LOCAL_MACHINE, keyval, 0,KEY_WRITE)
SetValueEx(Registrykey,"SophosRemove",0,REG_SZ,"C:\Windows\Temp\Comodo\Procedures\SophosUninstall.ps1")
CloseKey(Registrykey)

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

CMD = []
NAM = []
NAM.append('Sophos Patch Agent') 
CMD.append('MsiExec.exe /X{5565E71F-091B-42B8-8514-7E8944860BFD} /qn /norestart /L*V "c:\Windows\Temp\Comodo\Log\Uninstall_SophosPatchAgent.log"')
NAM.append('Sophos Network Threat Protection') 
CMD.append('MsiExec.exe /X{66967E5F-43E8-4402-87A4-04685EE5C2CB} /qn /norestart /L*V "c:\Windows\Temp\Comodo\Log\Uninstall_Sophos NetworkThreatProtection.log"') 
NAM.append('Sophos Client Firewall')
CMD.append('MsiExec.exe /X{A805FB2A-A844-4cba-8088-CA64087D59E1} /qn /norestart /L*V "c:\Windows\Temp\Comodo\Log\Uninstall_SophosClientFirewall.log"') 
NAM.append('Sophos Update Manager)
CMD.append('MsiExec.exe /X{2C7A82DB-69BC-4198-AC26-BB862F1BE4D0} /qn /norestart /L*V "c:\Windows\Temp\Comodo\Log\Uninstall_SophosUpdateManager.log"') 
NAM.append('Sophos System Protection') 
CMD.append('MsiExec.exe /X{1093B57D-A613-47F3-90CF-0FD5C5DCFFE6} /qn /norestart /L*V "c:\Windows\Temp\Comodo\Log\Uninstall_SophosSystemProtection.log"') 
NAM.append('Sophos Anti-Virus')
CMD.append('MsiExec.exe /X{6654537D-935E-41C0-A18A-C55C2BF77B7E} /qn /norestart /L*V "c:\Windows\Temp\Comodo\Log\Uninstall_SophosAnti-Virus.log"') 
NAM.append('Sophos Remote Management System') 
CMD.append('MsiExec.exe /X{FED1005D-CBC8-45D5-A288-FFC7BB304121} /qn /norestart /L*V "c:\Windows\Temp\Comodo\Log\Uninstall_SophosRemoteManagementSystem.log"')
NAM.append('Sophos AutoUpdate')
CMD.append('MsiExec.exe /X{AFBCA1B9-496C-4AE6-98AE-3EA1CFF65C54} /qn /norestart /L*V "c:\Windows\Temp\Comodo\Log\Uninstall_SophosAutoUpdate.log"') 

x=0
for i in CMD:
    print "Uninstallting " + NAM[x]
    process = ExecuteCMD(i)
    if process :
        print "Uninstallation  Successfull"
    else:
        print "Sophos need to restart your  system and run the script Again"
    print NAM[x] + " is not installed"
    x+=1