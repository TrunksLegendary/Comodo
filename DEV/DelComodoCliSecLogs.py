import time
import os
import ctypes
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