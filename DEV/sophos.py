from _winreg import *
import subprocess
import os, sys
import ctypes
import time
import os

keyval=r'SOFTWARE\WOW6432Node\Sophos\SAVService\TamperProtection'
if not os.path.exists("keyval"):
    key = CreateKey(HKEY_LOCAL_MACHINE,keyval)
Registrykey= OpenKey(HKEY_LOCAL_MACHINE, keyval, 0,KEY_WRITE)
SetValueEx(Registrykey,"Enabled",0,REG_DWORD, 0)
CloseKey(Registrykey)

class disable_file_system_redirection:
    _disable = ctypes.windll.kernel32.Wow64DisableWow64FsRedirection
    _revert = ctypes.windll.kernel32.Wow64RevertWow64FsRedirection
    def __enter__(self):
        self.old_value = ctypes.c_long()
        self.success = self._disable(ctypes.byref(self.old_value))
    def __exit__(self, type, value, traceback):
        if self.success:
            self._revert(self.old_value)

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
        OBJ.wait()
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

ExecuteCMD('net stop "savservice"')
ExecuteCMD('net stop "Sophos AutoUpdate Service"')
ExecuteCMD('net stop "Sophos Anti-Virus status reporter"')
ExecuteCMD('net stop "Sophos AutoUpdate Service"')
ExecuteCMD('net stop "Sophos Certification Manager"')
ExecuteCMD('net stop "Sophos Clean Service"')
ExecuteCMD('net stop "Sophos Client Firewall"')
ExecuteCMD('net stop "Sophos Anti-Virus"')
ExecuteCMD('net stop "Sophos Client Firewall Manager"')
ExecuteCMD('net stop "Sophos Agent"')
ExecuteCMD('net stop "Sophos Network Threat Protection"')
ExecuteCMD('net stop "Sophos Patch Agent"')
ExecuteCMD('net stop "Sophos System Protection Service"')
ExecuteCMD('net stop "Sophos Management Service"')
ExecuteCMD('net stop "Sophos Message Router"')
ExecuteCMD('net stop "Sophos Policy Evaluation Service"')
ExecuteCMD('net stop "Sophos Web Control Service"')
ExecuteCMD('net stop "Sophos Management Host"')
ExecuteCMD('net stop "Sophos Patch Endpoint Communicator"')
ExecuteCMD('net stop "Sophos Patch Endpoint Orchestrator"')
ExecuteCMD('net stop "Sophos Patch Server Communicator"')
ExecuteCMD('net stop "Sophos Update Manager"')
ExecuteCMD('net stop "Sophos Web Intelligence Service"')
ExecuteCMD('net stop "Sophos Web Intelligence Update"')
ExecuteCMD('"C:\Program Files\Sophos\Sophos Endpoint Agent\uninstallcli.exe"')


CMD = []
NAM = []
NAM.append('Sophos Patch Agent') 
CMD.append('MsiExec.exe /X{5565E71F-091B-42B8-8514-7E8944860BFD} /qn /norestart /L*V "c:\Windows\Temp\Uninstall_SophosPatchAgent.log"')
NAM.append('Sophos Network Threat Protection') 
CMD.append('MsiExec.exe /X{66967E5F-43E8-4402-87A4-04685EE5C2CB} /qn /norestart /L*V "c:\Windows\Temp\Uninstall_Sophos NetworkThreatProtection.log"') 
NAM.append('Sophos Client Firewall')
CMD.append('MsiExec.exe /X{A805FB2A-A844-4cba-8088-CA64087D59E1} /qn /norestart /L*V "c:\Windows\Temp\Uninstall_SophosClientFirewall.log"') 
NAM.append('Sophos Update Manager')
CMD.append('MsiExec.exe /X{2C7A82DB-69BC-4198-AC26-BB862F1BE4D0} /qn /norestart /L*V "c:\Windows\Temp\Uninstall_SophosUpdateManager.log"') 
NAM.append('Sophos System Protection') 
CMD.append('MsiExec.exe /X{1093B57D-A613-47F3-90CF-0FD5C5DCFFE6} /qn /norestart /L*V "c:\Windows\Temp\Uninstall_SophosSystemProtection.log"') 
NAM.append('Sophos Anti-Virus')
CMD.append('MsiExec.exe /X{6654537D-935E-41C0-A18A-C55C2BF77B7E} /qn /norestart /L*V "c:\Windows\Temp\Uninstall_SophosAnti-Virus.log"') 
NAM.append('Sophos Remote Management System') 
CMD.append('MsiExec.exe /X{FED1005D-CBC8-45D5-A288-FFC7BB304121} /qn /norestart /L*V "c:\Windows\Temp\Uninstall_SophosRemoteManagementSystem.log"')
NAM.append('Sophos AutoUpdate')
CMD.append('MsiExec.exe /X{AFBCA1B9-496C-4AE6-98AE-3EA1CFF65C54} /qn /norestart /L*V "c:\Windows\Temp\Uninstall_SophosAutoUpdate.log"') 
NAM.append('SophosAutoUpdate1')
CMD.append('MsiExec.exe /X{7CD26A0C-9B59-4E84-B5EE-B386B2F7AA16} /qn /norestart /L*V "c:\Windows\Temp\Uninstall_SophosAutoUpdate1')
NAM.append('SophosAutoUpdate2')
CMD.append('MsiExec.exe /X{BCF53039-A7FC-4C79-A3E3-437AE28FD918} /qn /norestart /L*V "c:\Windows\Temp\Uninstall_SophosAutoUpdate2')
NAM.append('SophosAutoUpdate3')
CMD.append('MsiExec.exe /X{9D1B8594-5DD2-4CDC-A5BD-98E7E9D75520} /qn /norestart /L*V "c:\Windows\Temp\Uninstall_SophosAutoUpdate3')
NAM.append('SophosAutoUpdate4')
CMD.append('MsiExec.exe /X{AFBCA1B9-496C-4AE6-98AE-3EA1CFF65C54} /qn /norestart /L*V "c:\Windows\Temp\Uninstall_SophosAutoUpdate4')
NAM.append('SophosAutoUpdate5')
CMD.append('MsiExec.exe /X{E82DD0A8-0E5C-4D72-8DDE-41BB0FC06B3E} /qn /norestart /L*V "c:\Windows\Temp\Uninstall_SophosAutoUpdate5')
NAM.append('SophosAutoUpdate6)
CMD.append('MsiExec.exe /X{72E136F7-3751-422E-AC7A-1B2E46391909} /qn /norestart /L*V "c:\Windows\Temp\Uninstall_SophosAutoUpdate6')
NAM.append('SophosAntiVirusEndpoint1')
CMD.append('MsiExec.exe /X{6654537D-935E-41C0-A18A-C55C2BF77B7E} /qn /norestart /L*V "c:\Windows\Temp\Uninstall_SophosAntiVirusEndpoint1')
NAM.append('SophosAntiVirusEndpoint2')
CMD.append('MsiExec.exe /X{8123193C-9000-4EEB-B28A-E74E779759FA} /qn /norestart /L*V "c:\Windows\Temp\Uninstall_SophosAntiVirusEndpoint2')
NAM.append('SophosAntiVirusEndpoint3')
CMD.append('MsiExec.exe /X{36333618-1CE1-4EF2-8FFD-7F17394891CE} /qn /norestart /L*V "c:\Windows\Temp\Uninstall_SophosAntiVirusEndpoint3')
NAM.append('SophosAntiVirusEndpoint4')
CMD.append('MsiExec.exe /X{DFDA2077-95D0-4C5F-ACE7-41DA16639255} /qn /norestart /L*V "c:\Windows\Temp\Uninstall_SophosAntiVirusEndpoint4')
NAM.append('SophosAntiVirusEndpoint5')
CMD.append('MsiExec.exe /X{CA3CE456-B2D9-4812-8C69-17D6980432EF} /qn /norestart /L*V "c:\Windows\Temp\Uninstall_SophosAntiVirusEndpoint5')
NAM.append('SophosAntiVirusEndpoint6')
CMD.append('MsiExec.exe /X{CA524364-D9C5-4804-92DE-2800BDAC1AA4} /qn /norestart /L*V "c:\Windows\Temp\Uninstall_SophosAntiVirusEndpoint6')
NAM.append('SophosAntiVirusEndpoint7')
CMD.append('MsiExec.exe /X{3B998572-90A5-4D61-9022-00B288DD755D} /qn /norestart /L*V "c:\Windows\Temp\Uninstall_SophosAntiVirusEndpoint7')
NAM.append('SophosAntiVirusEndpoint8')
CMD.append('MsiExec.exe /X{4BAF6F55-FFE4-4A3A-8367-CC2EBB0F11C3} /qn /norestart /L*V "c:\Windows\Temp\Uninstall_SophosAntiVirusEndpoint8')
NAM.append('SophosAntiVirusServer1')
CMD.append('MsiExec.exe /X{72E30858-FC95-4C87-A697-670081EBF065} /qn /norestart /L*V "c:\Windows\Temp\Uninstall_SophosAntiVirusServer1')
NAM.append('SophosAntiVirusServer2')
CMD.append('MsiExec.exe /X{66967E5F-43E8-4402-87A4-04685EE5C2CB} /qn /norestart /L*V "c:\Windows\Temp\Uninstall_SophosAntiVirusServer2')
NAM.append('SophosAntiVirusServer3')
CMD.append('MsiExec.exe /X{2519A41E-5D7C-429B-B2DB-1E943927CB3D} /qn /norestart /L*V "c:\Windows\Temp\Uninstall_SophosAntiVirusServer3')
NAM.append('SophosSystemProtection1')
CMD.append('MsiExec.exe /X{934BEF80-B9D1-4A86-8B42-D8A6716A8D27} /qn /norestart /L*V "c:\Windows\Temp\Uninstall_SophosSystemProtection1')
NAM.append('SophosSystemProtection2')
CMD.append('MsiExec.exe /X{1093B57D-A613-47F3-90CF-0FD5C5DCFFE6} /qn /norestart /L*V "c:\Windows\Temp\Uninstall_SophosSystemProtection2')
NAM.append('SophosNetworkThreatProtection')
CMD.append('MsiExec.exe /X{604350BF-BE9A-4F79-B0EB-B1C22D889E2D} /qn /norestart /L*V "c:\Windows\Temp\Uninstall_SophosNetworkThreatProtection')
NAM.append('SophosHealth1')
CMD.append('MsiExec.exe /X{A5CCEEF1-B6A7-4EB4-A826-267996A62A9E} /qn /norestart /L*V "c:\Windows\Temp\Uninstall_SophosHealth1')
NAM.append('SophosHealth2')
CMD.append('MsiExec.exe /X{D5BC54B8-1DA1-44F4-AE6F-86E05CDB0B44} /qn /norestart /L*V "c:\Windows\Temp\Uninstall_SophosHealth2')
NAM.append('SophosHealth3')
CMD.append('MsiExec.exe /X{E44AF5E6-7D11-4BDF-BEA8-AA7AE5FE6745} /qn /norestart /L*V "c:\Windows\Temp\Uninstall_SophosHealth3')
NAM.append('SDU')
CMD.append('MsiExec.exe /X{4627F5A1-E85A-4394-9DB3-875DF83AF6C2} /qn /norestart /L*V "c:\Windows\Temp\Uninstall_SDU')
NAM.append('Heartbeat')
CMD.append('MsiExec.exe /X{DFFA9361-3625-4219-82C2-9EF011E433B1} /qn /norestart /L*V "c:\Windows\Temp\Uninstall_Heartbeat')
NAM.append('SophosManagementCommunicationsSystem1')
CMD.append('MsiExec.exe /X{A1DC5EF8-DD20-45E8-ABBD-F529A24D477B} /qn /norestart /L*V "c:\Windows\Temp\Uninstall_SophosManagementCommunicationsSystem1')
NAM.append('SophosManagementCommunicationsSystem2')
CMD.append('MsiExec.exe /X{1FFD3F20-5D24-4C9A-B9F6-A207A53CF179} /qn /norestart /L*V "c:\Windows\Temp\Uninstall_SophosManagementCommunicationsSystem2')
NAM.append('SophosManagementCommunicationsSystem3')
CMD.append('MsiExec.exe /X{D875F30C-B469-4998-9A08-FE145DD5DC1A} /qn /norestart /L*V "c:\Windows\Temp\Uninstall_SophosManagementCommunicationsSystem3')
NAM.append('SophosManagementCommunicationsSystem4')
CMD.append('MsiExec.exe /X{2C14E1A2-C4EB-466E-8374-81286D723D3A} /qn /norestart /L*V "c:\Windows\Temp\Uninstall_SophosManagementCommunicationsSystem4')
NAM.append('UI')
CMD.append('MsiExec.exe /X{D29542AE-287C-42E4-AB28-3858E13C1A3E} /qn /norestart /L*V "c:\Windows\Temp\Uninstall_UI')
NAM.append('SophosEndpointFirewall')
CMD.append('MsiExec.exe /X{2831282D-8519-4910-B339-2302840ABEF3} /qn /norestart /L*V "c:\Windows\Temp\Uninstall_SophosEndpointFirewall')
NAM.append('SophosEndpointSelfHelp')
CMD.append('MsiExec.exe /X{4EFCDD15-24A2-4D89-84A4-857D1BF68FA8} /qn /norestart /L*V "c:\Windows\Temp\Uninstall_SophosEndpointSelfHelp1')
NAM.append('SophosEndpointSelfHelp2')
CMD.append('MsiExec.exe /X{BB36D9C2-6AE5-4AB2-BC91-ECD247092BD8} /qn /norestart /L*V "c:\Windows\Temp\Uninstall_SophosEndpointSelfHelp2')
NAM.append('SophosLockdown')
CMD.append('MsiExec.exe /X{77F92E90-ED4F-4CFF-8F60-3E3E4AEB705C} /qn /norestart /L*V "c:\Windows\Temp\Uninstall_SophosLockdown')


x=0
for i in CMD:
    print "Uninstallting " + NAM[x] + CMD[x]
    process = ExecuteCMD(i)
    if process :
        print "Uninstallation  Successfull" +  NAM[x] + CMD[x]
    else:
        print "Please run this script Again"
	x+=1


from subprocess import PIPE, Popen
class disable_file_system_redirection:
    _disable = ctypes.windll.kernel32.Wow64DisableWow64FsRedirection
    _revert = ctypes.windll.kernel32.Wow64RevertWow64FsRedirection
    def __enter__(self):
        self.old_value = ctypes.c_long()
        self.success = self._disable(ctypes.byref(self.old_value))
    def __exit__(self, type, value, traceback):
        if self.success:
            self._revert(self.old_value)

with disable_file_system_redirection():
    Popen('c:\Program Files\Sophos\Endpoint Defense\uninstall.exe', shell = True, stdout = PIPE, stderr = PIPE)
    time.sleep(2)
    Popen('rmdir "c:\Program Files\Sophos" /s /q', shell = True, stdout = PIPE, stderr = PIPE)
    time.sleep(2)
    Popen('rmdir "c:\ProgramData\Sophos" /s /q', shell = True, stdout = PIPE, stderr = PIPE)
    time.sleep(2)
    Popen('rmdir "c:\Program Files (x86)\Sophos" /s /q', shell = True, stdout = PIPE, stderr = PIPE)