import os 
import sys 
import _winreg 

def alert(arg): 
   sys.stderr.write("%d%d%d" % (arg, arg, arg)) 

def subkeys(key):
    i = 0
    while True:
        try:
            subkey = _winreg.EnumKey(key, i)
            yield subkey
            i+=1
        except WindowsError as e:
            break

def enumValues(subKey):
    i = 0
    while True:
        try:
            value = _winreg.EnumValue(subKey, i)
            yield value
            i += 1
        except WindowsError as e:
            break

def values(key):
    global keypath 
    i = 0
    values = dict()
    for subkeyName in subkeys(key):
        try:
            valueName = r'\\'.join([keypath, subkeyName])
            with _winreg.OpenKey(_winreg.HKEY_LOCAL_MACHINE, valueName, 0, _winreg.KEY_READ) as subkey:
                for v in enumValues(subkey):
                    values[v[0]] = v[1]
                yield (valueName, values)
        except WindowsError as e:
            break

def traverse_registry_tree(hkey, keypath, tabs=0):
    reg_dict = {}
    found = 0
    key = _winreg.OpenKey(hkey, keypath, 0, _winreg.KEY_READ)
    for value in values(key):
        for k, v in value[1].iteritems():
            if v =="COMODO Client - Security":
                name = v
                for k, v in value[1].iteritems():
                    if v == "10.8.0.7053":
                        found = 1
    if 0 == found:
        return 0
    else:
        return 1

keypath = r"SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
found = traverse_registry_tree(_winreg.HKEY_LOCAL_MACHINE, keypath)

if found ==1:
    alert(1)
    print ("Found COMODO Client - Security 10.8.0.7053")
else:
    alert(0)
    print ("NOT FOUND - COMODO Client - Security 10.8.0.7053")
