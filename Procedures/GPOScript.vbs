'------------------------------Configuration-Section--------------------------------
'-----------------------------------------------------------------------------------
InstallCCC = "yes"
InstallCCCFromComodoServers = "no"
'If InstallCCCFromComodoServers = "yes" please provide Host and Token
Host = "xxxx.cmdm.comodo.com"
Port = "443"
Token = "xxxxxxxx"
'If InstallCCCFromComodoServers = "no", please provide Shared Folder Path and File Names
SharedFolderCCC = "\\xxxx\xxxx"
CCCUseToken = "no"
'if CCCUseToken = "yes" the enrollment will use the token from the file name
UseHybridPackageT = "no"
'UseHybridPackageT = "no" please provide the 32 and 64 file names
FileNameCCC32T = "itsm_xxxx_installer.msi"
FileNameCCC64T = "itsm_xxxx_installer.msi"
'UseHybridPackageT = "yes" please provide the package name
FileNameCCC32and64T = "itsm_0pB0I7QL_installer.msi"
'if CCCUseToken = "no" the enrollment will use the Token = "xxxx" value
UseHybridPackage = "yes"
'UseHybridPackage = "no" please provide the 32 and 64 file names
FileNameCCC32 = "xxxx.msi"
FileNameCCC64 = "xxxx.msi"
'UseHybridPackage = "yes" please provide the package name
FileNameCCC32and64 = "xxxx.msi"
UseProxy = "yes"
UseMST = "yes"
'if UseProxy = "yes" and UseMST = "no", please provide Proxy Host, Proxy Port, Proxy Login and Proxy Password
ProxyHost = ""
ProxyPort = ""
ProxyUseAuth = "no"
ProxyLogin = ""
ProxyPassword = ""
'if UseProxy = "yes" and UseMST = "yes", please provide Shared Folder Path and File Name
SharedFolderMST = "\\xxxx\xxxx"
FileNameMST = "itsm_agent_xxxx_option_installer.mst"
InstallCCS = "yes"
InstallCCSFromComodoServers = "no"
'If InstallCCSFromComodoServers = "yes" the package will be downloaded from:
'https://download.comodo.com/itsm/CIS_x64.msi
'https://download.comodo.com/itsm/CIS_x86.msi
'If InstallCCSFromComodoServers = "no" please provide the shared folder path and the .msi names:
SharedFolderCCS = "\\xxxx\xxxx"
FileNameCCS32 = "xxxx.msi"
FileNameCCS64 = "xxxx.msi"
'Please choose what to be installed before the profile is applied.
'You can use "yes" or "no"
'--------------------------
'DO NOT modify this section, unless instructed by Comodo
Containment = "yes"
Antivirus = "yes"
Firewall = "yes"
'--------------------------
'If Antivirus = "yes" do you want to download the initial Database from a shared folder ?
'( Database is automatically updated from Comodo servers after 1 hour as default or after a reboot )
Database = "yes"
'If Database = "yes" you can download the latest databse from this link and place it on shared folder:
'https://www.comodo.com/home/internet-security/updates/vdp/database.php
SharedFolderPathCAV = "\\xxxx\xxxx"
FileNameCAV = "xxxx.cav"
'After CCS is installed do you want to supress the reboot on the endpoint?
SuppressReboot = "no"
'If reboot = "no" by default you have 5 minutes with a comment "Your device will reboot in 5 minutes because it's required by your administrator"
RebootTime = "300"
t = CInt(RebootTime)
t1 = t / 60
RebootComment = "Your device will reboot in " & t1 & " minutes because it's required by your administrator"
'-----------------------------------------------------------------------------------
Dim fso    
Set fso = CreateObject("Scripting.FileSystemObject")
Dim wshShell
Set wshShell = CreateObject( "WScript.Shell" )
ProgramDataFolder = wshShell.ExpandEnvironmentStrings("%PROGRAMDATA%")
SystemType = wshShell.ExpandEnvironmentStrings("%SystemDrive%")
CCCAgentPath32 = SystemType & "\Program Files\COMODO\Comodo ITSM\ITSMAgent.exe"
CCCAgentPath64 = SystemType & "\Program Files (x86)\COMODO\Comodo ITSM\ITSMAgent.exe"
CCSPath3264 = SystemType & "\Program Files\COMODO\COMODO Internet Security\cis.exe"
If (InstallCCC = "yes") Then
	'WScript.Echo("InstallCCC = yes")
	If (InstallCCCFromComodoServers = "yes") Then
		'WScript.Echo("InstallCCCFromComodoServers = yes")
		If (fso.FolderExists(SystemType & "\Program Files (x86)" )) Then
			'WScript.Echo("System Type 64 - bit")
			If NOT fso.FileExists(CCCAgentPath64) Then
				'WScript.Echo("CCC is not present")
				If NOT (fso.FolderExists(ProgramDataFolder & "\Comodo" )) Then
					'WScript.Echo("File DO NOT exists!" & ProgramDataFolder & "\Comodo" )
					fso.CreateFolder(ProgramDataFolder & "\Comodo")
				End If
				If fso.FileExists(ProgramDataFolder & "\Comodo\COCC.msi") Then
					'WScript.Echo("Delete previous download" )
					fso.DeleteFile(ProgramDataFolder & "\Comodo\COCC.msi")
				End If
				'dim xHttp: Set xHttp = createobject("Microsoft.XMLHTTP")
				dim xHttp: Set xHttp = createobject("MSXML2.ServerXMLHTTP")
				dim bStrm: Set bStrm = createobject("Adodb.Stream")
				CCCurl = "https://download.comodo.com/itsm/COCC.msi"
				CCCDefaultName = "COCC.msi"
				xHttp.Open "GET", CCCurl, False
				xHttp.Send
				with bStrm
					.type = 1 '//binary
					.open
					.write xHttp.responseBody
					.savetofile(ProgramDataFolder & "\Comodo\" & CCCDefaultName ), 2
				end with
				If NOT (fso.FolderExists(SystemType & "\Program Files (x86)\COMODO")) Then
					'WScript.Echo("File DO NOT exists!" & SystemType & "\Program Files (x86)\COMODO" )
					fso.CreateFolder(SystemType & "\Program Files (x86)\COMODO")
				End If
				If NOT (fso.FolderExists(SystemType & "\Program Files (x86)\COMODO\Comodo ITSM")) Then
					'WScript.Echo("File DO NOT exists!" & SystemType & "\Program Files (x86)\COMODO" )
					fso.CreateFolder(SystemType & "\Program Files (x86)\COMODO\Comodo ITSM")
				End If
				If fso.FileExists(SystemType & "\Program Files (x86)\COMODO\Comodo ITSM\enrollment_config.ini") Then
					fso.DeleteFile(SystemType & "\Program Files (x86)\COMODO\Comodo ITSM\enrollment_config.ini")
				End If
				outFile = SystemType & "\Program Files (x86)\COMODO\Comodo ITSM\enrollment_config.ini"
				Set objFile = fso.CreateTextFile(outFile,True)
				objFile.WriteLine "[General]"
				objFile.WriteLine "host = " & Chr(34) & Host & Chr(34)
				objFile.WriteLine "port = " & Chr(34) & Port & Chr(34)
				objFile.WriteLine "remove_third_party = " & Chr(34) & "false" & Chr(34)
				objFile.WriteLine "suite = 4"
				objFile.WriteLine "token = " & Chr(34) & Token & Chr(34)
				objFile.Close
				If (UseProxy = "yes") Then
					If (UseMST = "no") Then
						If fso.FileExists(SystemType & "\Program Files (x86)\COMODO\Comodo ITSM\proxy_settings.ini") Then
							fso.DeleteFile(SystemType & "\Program Files (x86)\COMODO\Comodo ITSM\proxy_settings.ini")
						End If
						outFile1 = SystemType & "\Program Files (x86)\COMODO\Comodo ITSM\proxy_settings.ini"
						Set objFile1 = fso.CreateTextFile(outFile1,True)
						objFile1.WriteLine "[General]"
						objFile1.WriteLine "proxy_use = " & Chr(34) & "true" & Chr(34)
						objFile1.WriteLine "proxy_host = " & Chr(34) & ProxyHost & Chr(34)
						objFile1.WriteLine "proxy_port = " & Chr(34) & ProxyPort & Chr(34)
						If (ProxyUseAuth = "yes") Then
							objFile1.WriteLine "proxy_use_auth = " & Chr(34) & "true" & Chr(34)
							objFile1.WriteLine "proxy_user = " & Chr(34) & ProxyLogin & Chr(34)
							objFile1.WriteLine "proxy_password = " & Chr(34) & ProxyPassword & Chr(34)
						Else
							objFile1.WriteLine "proxy_use_auth = " & Chr(34) & "false" & Chr(34)
							objFile1.WriteLine "proxy_user = "
							objFile1.WriteLine "proxy_password = "
						End If
					End If
				End If
				install64msipath = "msiexec.exe" & " /I " & ProgramDataFolder & "\Comodo\" & CCCDefaultName & " /quiet"
				wshShell.Run install64msipath,0,true
				If fso.FileExists(ProgramDataFolder & "\Comodo\COCC.msi") Then
					'WScript.Echo("Delete previous download" )
					fso.DeleteFile(ProgramDataFolder & "\Comodo\COCC.msi")
				End If
			Else
				'WScript.Echo("CCC is present")
			End If
		Else
			'WScript.Echo("System Type 32 - bit")
			If NOT fso.FileExists(CCCAgentPath32) Then
				'WScript.Echo("CCC is not present")
				If NOT (fso.FolderExists(ProgramDataFolder & "\Comodo" )) Then
					'WScript.Echo("File DO NOT exists!" & ProgramDataFolder & "\Comodo" )
					fso.CreateFolder(ProgramDataFolder & "\Comodo")
				End If
				If fso.FileExists(ProgramDataFolder & "\Comodo\COCC.msi") Then
					'WScript.Echo("Delete previous download" )
					fso.DeleteFile(ProgramDataFolder & "\Comodo\COCC.msi")
				End If
				'dim xHttp1: Set xHttp1 = createobject("Microsoft.XMLHTTP")
				dim xHttp1: Set xHttp1 = createobject("MSXML2.ServerXMLHTTP")
				dim bStrm1: Set bStrm1 = createobject("Adodb.Stream")
				CCCurl = "https://download.comodo.com/itsm/COCC.msi"
				CCCDefaultName = "COCC.msi"
				xHttp1.Open "GET", CCCurl, False
				xHttp1.Send
				with bStrm1
					.type = 1 '//binary
					.open
					.write xHttp1.responseBody
					.savetofile(ProgramDataFolder & "\Comodo\" & CCCDefaultName ), 2
				end with
				If NOT (fso.FolderExists(SystemType & "\Program Files\COMODO")) Then
					'WScript.Echo("File DO NOT exists!" & SystemType & "\Program Files (x86)\COMODO" )
					fso.CreateFolder(SystemType & "\Program Files\COMODO")
				End If
				If NOT (fso.FolderExists(SystemType & "\Program Files\COMODO\Comodo ITSM")) Then
					'WScript.Echo("File DO NOT exists!" & SystemType & "\Program Files (x86)\COMODO" )
					fso.CreateFolder(SystemType & "\Program Files\COMODO\Comodo ITSM")
				End If
				If fso.FileExists(SystemType & "\Program Files\COMODO\Comodo ITSM\enrollment_config.ini") Then
					fso.DeleteFile(SystemType & "\Program Files\COMODO\Comodo ITSM\enrollment_config.ini")
				End If
				outFile = SystemType & "\Program Files\COMODO\Comodo ITSM\enrollment_config.ini"
				Set objFile = fso.CreateTextFile(outFile,True)
				objFile.WriteLine "[General]"
				objFile.WriteLine "host = " & Chr(34) & Host & Chr(34)
				objFile.WriteLine "port = " & Chr(34) & Port & Chr(34)
				objFile.WriteLine "remove_third_party = " & Chr(34) & "false" & Chr(34)
				objFile.WriteLine "suite = 4"
				objFile.WriteLine "token = " & Chr(34) & Token & Chr(34)
				objFile.Close
				If (UseProxy = "yes") Then
					If (UseMST = "no") Then
						If fso.FileExists(SystemType & "\Program Files\COMODO\Comodo ITSM\proxy_settings.ini") Then
							fso.DeleteFile(SystemType & "\Program Files\COMODO\Comodo ITSM\proxy_settings.ini")
						End If
						outFile1 = SystemType & "\Program Files\COMODO\Comodo ITSM\proxy_settings.ini"
						Set objFile1 = fso.CreateTextFile(outFile1,True)
						objFile1.WriteLine "[General]"
						objFile1.WriteLine "proxy_use = " & Chr(34) & "true" & Chr(34)
						objFile1.WriteLine "proxy_host = " & Chr(34) & ProxyHost & Chr(34)
						objFile1.WriteLine "proxy_port = " & Chr(34) & ProxyPort & Chr(34)
						If (ProxyUseAuth = "yes") Then
							objFile1.WriteLine "proxy_use_auth = " & Chr(34) & "true" & Chr(34)
							objFile1.WriteLine "proxy_user = " & Chr(34) & ProxyLogin & Chr(34)
							objFile1.WriteLine "proxy_password = " & Chr(34) & ProxyPassword & Chr(34)
						Else
							objFile1.WriteLine "proxy_use_auth = " & Chr(34) & "false" & Chr(34)
							objFile1.WriteLine "proxy_user = "
							objFile1.WriteLine "proxy_password = "
						End If
					End If
				End If
				install32msipath = "msiexec.exe" & " /I " & ProgramDataFolder & "\Comodo\" & CCCDefaultName & " /quiet"
				wshShell.Run install32msipath,0,true
				If fso.FileExists(ProgramDataFolder & "\Comodo\COCC.msi") Then
					'WScript.Echo("Delete previous download" )
					fso.DeleteFile(ProgramDataFolder & "\Comodo\COCC.msi")
				End If
			Else
				'WScript.Echo("CCC is present")
			End If
		End If
	Else
		'WScript.Echo("InstallCCCFromComodoServers = no")
		If (CCCUseToken = "yes") Then
			'WScript.Echo("CCCUseToken = yes")
			If (fso.FolderExists(SystemType & "\Program Files (x86)" )) Then
				'WScript.Echo("System Type 64 - bit")
				If NOT fso.FileExists(CCCAgentPath64) Then
					'WScript.Echo("CCC is not present")
					If NOT (fso.FolderExists(ProgramDataFolder & "\Comodo" )) Then
						'WScript.Echo("File DO NOT exists!" & ProgramDataFolder & "\Comodo" )
						fso.CreateFolder(ProgramDataFolder & "\Comodo")
					End If
					If (UseHybridPackageT = "yes") Then
						'WScript.Echo("UseHybridPackageT = yes")
						Set MyFile = fso.GetFile(SharedFolderCCC & "\" & FileNameCCC32and64T)
						MyFile.Copy (ProgramDataFolder & "\Comodo\" & FileNameCCC32and64T)
						'fso.CopyFile SharedFolderCCC & "\" & FileNameCCC32and64T, ProgramDataFolder & "\Comodo", True
					Else
						'WScript.Echo("UseHybridPackageT = no")
						Set MyFile = fso.GetFile(SharedFolderCCC & "\" & FileNameCCC64T)
						MyFile.Copy (ProgramDataFolder & "\Comodo\" & FileNameCCC64T)
						'fso.CopyFile SharedFolderCCC & "\" & FileNameCCC64T, ProgramDataFolder & "\Comodo", True
					End If
					If (UseProxy = "yes") Then
						If (UseMST = "no") Then
							If NOT (fso.FolderExists(SystemType & "\Program Files (x86)\COMODO")) Then
								'WScript.Echo("File DO NOT exists!" & SystemType & "\Program Files (x86)\COMODO" )
								fso.CreateFolder(SystemType & "\Program Files (x86)\COMODO")
							End If
							If NOT (fso.FolderExists(SystemType & "\Program Files (x86)\COMODO\Comodo ITSM")) Then
								'WScript.Echo("File DO NOT exists!" & SystemType & "\Program Files (x86)\COMODO" )
								fso.CreateFolder(SystemType & "\Program Files (x86)\COMODO\Comodo ITSM")
							End If
							If fso.FileExists(SystemType & "\Program Files (x86)\COMODO\Comodo ITSM\proxy_settings.ini") Then
								fso.DeleteFile(SystemType & "\Program Files (x86)\COMODO\Comodo ITSM\proxy_settings.ini")
							End If
							outFile1 = SystemType & "\Program Files (x86)\COMODO\Comodo ITSM\proxy_settings.ini"
							Set objFile1 = fso.CreateTextFile(outFile1,True)
							objFile1.WriteLine "[General]"
							objFile1.WriteLine "proxy_use = " & Chr(34) & "true" & Chr(34)
							objFile1.WriteLine "proxy_host = " & Chr(34) & ProxyHost & Chr(34)
							objFile1.WriteLine "proxy_port = " & Chr(34) & ProxyPort & Chr(34)
							If (ProxyUseAuth = "yes") Then
								objFile1.WriteLine "proxy_use_auth = " & Chr(34) & "true" & Chr(34)
								objFile1.WriteLine "proxy_user = " & Chr(34) & ProxyLogin & Chr(34)
								objFile1.WriteLine "proxy_password = " & Chr(34) & ProxyPassword & Chr(34)
							Else
								objFile1.WriteLine "proxy_use_auth = " & Chr(34) & "false" & Chr(34)
								objFile1.WriteLine "proxy_user = "
								objFile1.WriteLine "proxy_password = "
							End If
						Else
							'fso.CopyFile SharedFolderMST & "\" & FileNameMST, ProgramDataFolder & "\Comodo", True
							Set MyFile = fso.GetFile(SharedFolderCCC & "\" & FileNameMST)
							MyFile.Copy (ProgramDataFolder & "\Comodo\" & FileNameMST)
						End If
					End If
					If (UseHybridPackageT = "yes") Then
						If (UseMST = "no") Then
							install64msipath = "msiexec.exe" & " /I " & ProgramDataFolder & "\Comodo\" & FileNameCCC32and64T & " /quiet"
							wshShell.Run install64msipath,0,true
						Else
							install64msipath = "msiexec.exe" & " /I " & ProgramDataFolder & "\Comodo\" & FileNameCCC32and64T & " /quiet TRANSFORMS=" & ProgramDataFolder & "\Comodo\" & FileNameMST
							wshShell.Run install64msipath,0,true
						End If
					Else
						If (UseMST = "no") Then
							install64msipath = "msiexec.exe" & " /I " & ProgramDataFolder & "\Comodo\" & FileNameCCC64T & " /quiet"
							wshShell.Run install64msipath,0,true
						Else
							install64msipath = "msiexec.exe" & " /I " & ProgramDataFolder & "\Comodo\" & FileNameCCC64T & " /quiet TRANSFORMS=" & ProgramDataFolder & "\Comodo\" & FileNameMST
							wshShell.Run install64msipath,0,true
						End If
					End If
					If fso.FileExists(ProgramDataFolder & "\Comodo\" & FileNameCCC32and64T) Then
						'WScript.Echo("Delete previous download" )
						fso.DeleteFile(ProgramDataFolder & "\Comodo\" & FileNameCCC32and64T)
					End If
					If fso.FileExists(ProgramDataFolder & "\Comodo\" & FileNameCCC64T) Then
						'WScript.Echo("Delete previous download" )
						fso.DeleteFile(ProgramDataFolder & "\Comodo\" & FileNameCCC64T)
					End If
					If fso.FileExists(ProgramDataFolder & "\Comodo\" & FileNameMST) Then
						'WScript.Echo("Delete previous download" )
						fso.DeleteFile(ProgramDataFolder & "\Comodo\" & FileNameMST)
					End If
				End If
			Else
				'WScript.Echo("System Type 32 - bit")
				If NOT fso.FileExists(CCCAgentPath32) Then
					'WScript.Echo("CCC is not present")
					If NOT (fso.FolderExists(ProgramDataFolder & "\Comodo" )) Then
						'WScript.Echo("File DO NOT exists!" & ProgramDataFolder & "\Comodo" )
						fso.CreateFolder(ProgramDataFolder & "\Comodo")
					End If
					If (UseHybridPackageT = "yes") Then
						'WScript.Echo("UseHybridPackageT = yes")
						Set MyFile = fso.GetFile(SharedFolderCCC & "\" & FileNameCCC32and64T)
						MyFile.Copy (ProgramDataFolder & "\Comodo\" & FileNameCCC32and64T)
						'fso.CopyFile SharedFolderCCC & "\" & FileNameCCC32and64T, ProgramDataFolder & "\Comodo", True
					Else
						'WScript.Echo("UseHybridPackageT = no")
						Set MyFile = fso.GetFile(SharedFolderCCC & "\" & FileNameCCC32T)
						MyFile.Copy (ProgramDataFolder & "\Comodo\" & FileNameCCC32T)
						'fso.CopyFile SharedFolderCCC & "\" & FileNameCCC32T, ProgramDataFolder & "\Comodo", True
					End If
					If (UseProxy = "yes") Then
						If (UseMST = "no") Then
							If NOT (fso.FolderExists(SystemType & "\Program Files\COMODO")) Then
								'WScript.Echo("File DO NOT exists!" & SystemType & "\Program Files (x86)\COMODO" )
								fso.CreateFolder(SystemType & "\Program Files\COMODO")
							End If
							If NOT (fso.FolderExists(SystemType & "\Program Files\COMODO\Comodo ITSM")) Then
								'WScript.Echo("File DO NOT exists!" & SystemType & "\Program Files (x86)\COMODO" )
								fso.CreateFolder(SystemType & "\Program Files\COMODO\Comodo ITSM")
							End If
							If fso.FileExists(SystemType & "\Program Files\COMODO\Comodo ITSM\proxy_settings.ini") Then
								fso.DeleteFile(SystemType & "\Program Files\COMODO\Comodo ITSM\proxy_settings.ini")
							End If
							outFile1 = SystemType & "\Program Files\COMODO\Comodo ITSM\proxy_settings.ini"
							Set objFile1 = fso.CreateTextFile(outFile1,True)
							objFile1.WriteLine "[General]"
							objFile1.WriteLine "proxy_use = " & Chr(34) & "true" & Chr(34)
							objFile1.WriteLine "proxy_host = " & Chr(34) & ProxyHost & Chr(34)
							objFile1.WriteLine "proxy_port = " & Chr(34) & ProxyPort & Chr(34)
							If (ProxyUseAuth = "yes") Then
								objFile1.WriteLine "proxy_use_auth = " & Chr(34) & "true" & Chr(34)
								objFile1.WriteLine "proxy_user = " & Chr(34) & ProxyLogin & Chr(34)
								objFile1.WriteLine "proxy_password = " & Chr(34) & ProxyPassword & Chr(34)
							Else
								objFile1.WriteLine "proxy_use_auth = " & Chr(34) & "false" & Chr(34)
								objFile1.WriteLine "proxy_user = "
								objFile1.WriteLine "proxy_password = "
							End If
						Else
							'fso.CopyFile SharedFolderMST & "\" & FileNameMST, ProgramDataFolder & "\Comodo" & FileNameMST, True
							Set MyFile = fso.GetFile(SharedFolderCCC & "\" & FileNameMST)
							MyFile.Copy (ProgramDataFolder & "\Comodo\" & FileNameMST)
						End If
					End If
					If (UseHybridPackageT = "yes") Then
						If (UseMST = "no") Then
							install32msipath = "msiexec.exe" & " /I " & ProgramDataFolder & "\Comodo\" & FileNameCCC32and64T & " /quiet"
							wshShell.Run install32msipath,0,true
						Else
							install32msipath = "msiexec.exe" & " /I " & ProgramDataFolder & "\Comodo\" & FileNameCCC32and64T & " /quiet TRANSFORMS=" & ProgramDataFolder & "\Comodo\" & FileNameMST
							wshShell.Run install32msipath,0,true
						End If
					Else
						If (UseMST = "no") Then
							install32msipath = "msiexec.exe" & " /I " & ProgramDataFolder & "\Comodo\" & FileNameCCC32T & " /quiet"
							wshShell.Run install32msipath,0,true
						Else
							install32msipath = "msiexec.exe" & " /I " & ProgramDataFolder & "\Comodo\" & FileNameCCC32T & " /quiet TRANSFORMS=" & ProgramDataFolder & "\Comodo\" & FileNameMST
							wshShell.Run install32msipath,0,true
						End If
					End If
					If fso.FileExists(ProgramDataFolder & "\Comodo\" & FileNameCCC32and64T) Then
						'WScript.Echo("Delete previous download" )
						fso.DeleteFile(ProgramDataFolder & "\Comodo\" & FileNameCCC32and64T)
					End If
					If fso.FileExists(ProgramDataFolder & "\Comodo\" & FileNameCCC32T) Then
						'WScript.Echo("Delete previous download" )
						fso.DeleteFile(ProgramDataFolder & "\Comodo\" & FileNameCCC32T)
					End If
					If fso.FileExists(ProgramDataFolder & "\Comodo\" & FileNameMST) Then
						'WScript.Echo("Delete previous download" )
						fso.DeleteFile(ProgramDataFolder & "\Comodo\" & FileNameMST)
					End If
				End If
			End If
		Else
			'WScript.Echo("CCCUseToken = no")
			If (fso.FolderExists(SystemType & "\Program Files (x86)" )) Then
				'WScript.Echo("System Type 64 - bit")
				If NOT fso.FileExists(CCCAgentPath64) Then
					'WScript.Echo("CCC is not present")
					If NOT (fso.FolderExists(ProgramDataFolder & "\Comodo" )) Then
						'WScript.Echo("File DO NOT exists!" & ProgramDataFolder & "\Comodo" )
						fso.CreateFolder(ProgramDataFolder & "\Comodo")
					End If
					If (UseHybridPackage = "yes") Then
						'WScript.Echo("UseHybridPackage = yes")
						Set MyFile = fso.GetFile(SharedFolderCCC & "\" & FileNameCCC32and64)
						MyFile.Copy (ProgramDataFolder & "\Comodo\" & FileNameCCC32and64)
						'fso.CopyFile SharedFolderCCC & "\" & FileNameCCC32and64, ProgramDataFolder & "\Comodo", True
					Else
						'WScript.Echo("UseHybridPackage = no")
						Set MyFile = fso.GetFile(SharedFolderCCC & "\" & FileNameCCC64)
						MyFile.Copy (ProgramDataFolder & "\Comodo\" & FileNameCCC64)
						'fso.CopyFile SharedFolderCCC & "\" & FileNameCCC64, ProgramDataFolder & "\Comodo", True
					End If
					If NOT (fso.FolderExists(SystemType & "\Program Files (x86)\COMODO")) Then
						'WScript.Echo("File DO NOT exists!" & SystemType & "\Program Files (x86)\COMODO" )
						fso.CreateFolder(SystemType & "\Program Files (x86)\COMODO")
					End If
					If NOT (fso.FolderExists(SystemType & "\Program Files (x86)\COMODO\Comodo ITSM")) Then
						'WScript.Echo("File DO NOT exists!" & SystemType & "\Program Files (x86)\COMODO" )
						fso.CreateFolder(SystemType & "\Program Files (x86)\COMODO\Comodo ITSM")
					End If
					If fso.FileExists(SystemType & "\Program Files (x86)\COMODO\Comodo ITSM\enrollment_config.ini") Then
						fso.DeleteFile(SystemType & "\Program Files (x86)\COMODO\Comodo ITSM\enrollment_config.ini")
					End If
					outFile = SystemType & "\Program Files (x86)\COMODO\Comodo ITSM\enrollment_config.ini"
					Set objFile = fso.CreateTextFile(outFile,True)
					objFile.WriteLine "[General]"
					objFile.WriteLine "host = " & Chr(34) & Host & Chr(34)
					objFile.WriteLine "port = " & Chr(34) & Port & Chr(34)
					objFile.WriteLine "remove_third_party = " & Chr(34) & "false" & Chr(34)
					objFile.WriteLine "suite = 4"
					objFile.WriteLine "token = " & Chr(34) & Token & Chr(34)
					objFile.Close
					If (UseProxy = "yes") Then
						If (UseMST = "no") Then
							If fso.FileExists(SystemType & "\Program Files (x86)\COMODO\Comodo ITSM\proxy_settings.ini") Then
								fso.DeleteFile(SystemType & "\Program Files (x86)\COMODO\Comodo ITSM\proxy_settings.ini")
							End If
							outFile1 = SystemType & "\Program Files (x86)\COMODO\Comodo ITSM\proxy_settings.ini"
							Set objFile1 = fso.CreateTextFile(outFile1,True)
							objFile1.WriteLine "[General]"
							objFile1.WriteLine "proxy_use = " & Chr(34) & "true" & Chr(34)
							objFile1.WriteLine "proxy_host = " & Chr(34) & ProxyHost & Chr(34)
							objFile1.WriteLine "proxy_port = " & Chr(34) & ProxyPort & Chr(34)
							If (ProxyUseAuth = "yes") Then
								objFile1.WriteLine "proxy_use_auth = " & Chr(34) & "true" & Chr(34)
								objFile1.WriteLine "proxy_user = " & Chr(34) & ProxyLogin & Chr(34)
								objFile1.WriteLine "proxy_password = " & Chr(34) & ProxyPassword & Chr(34)
							Else
								objFile1.WriteLine "proxy_use_auth = " & Chr(34) & "false" & Chr(34)
								objFile1.WriteLine "proxy_user = "
								objFile1.WriteLine "proxy_password = "
							End If
						Else
							'fso.CopyFile SharedFolderMST & "\" & FileNameMST, ProgramDataFolder & "\Comodo", True
							Set MyFile = fso.GetFile(SharedFolderCCC & "\" & FileNameMST)
							MyFile.Copy (ProgramDataFolder & "\Comodo\" & FileNameMST)
						End If
					End If
					If (UseHybridPackage = "yes") Then
						If (UseMST = "no") Then
							install64msipath = "msiexec.exe" & " /I " & ProgramDataFolder & "\Comodo\" & FileNameCCC32and64 & " /quiet"
							wshShell.Run install64msipath,0,true
						Else
							install64msipath = "msiexec.exe" & " /I " & ProgramDataFolder & "\Comodo\" & FileNameCCC32and64 & " /quiet TRANSFORMS=" & ProgramDataFolder & "\Comodo\" & FileNameMST
							wshShell.Run install64msipath,0,true
						End If
					Else
						If (UseMST = "no") Then
							install64msipath = "msiexec.exe" & " /I " & ProgramDataFolder & "\Comodo\" & FileNameCCC64 & " /quiet"
							wshShell.Run install64msipath,0,true
						Else
							install64msipath = "msiexec.exe" & " /I " & ProgramDataFolder & "\Comodo\" & FileNameCCC64 & " /quiet TRANSFORMS=" & ProgramDataFolder & "\Comodo\" & FileNameMST
							wshShell.Run install64msipath,0,true
						End If
					End If
					If fso.FileExists(ProgramDataFolder & "\Comodo\" & FileNameCCC32and64) Then
						'WScript.Echo("Delete previous download" )
						fso.DeleteFile(ProgramDataFolder & "\Comodo\" & FileNameCCC32and64)
					End If
					If fso.FileExists(ProgramDataFolder & "\Comodo\" & FileNameCCC64) Then
						'WScript.Echo("Delete previous download" )
						fso.DeleteFile(ProgramDataFolder & "\Comodo\" & FileNameCCC64)
					End If
					If fso.FileExists(ProgramDataFolder & "\Comodo\" & FileNameMST) Then
						'WScript.Echo("Delete previous download" )
						fso.DeleteFile(ProgramDataFolder & "\Comodo\" & FileNameMST)
					End If
				End If
			Else
				'WScript.Echo("System Type 32 - bit")
				If NOT fso.FileExists(CCCAgentPath32) Then
					'WScript.Echo("CCC is not present")
					If NOT (fso.FolderExists(ProgramDataFolder & "\Comodo" )) Then
						'WScript.Echo("File DO NOT exists!" & ProgramDataFolder & "\Comodo" )
						fso.CreateFolder(ProgramDataFolder & "\Comodo")
					End If
					If (UseHybridPackage = "yes") Then
						'WScript.Echo("UseHybridPackage = yes")
						Set MyFile = fso.GetFile(SharedFolderCCC & "\" & FileNameCCC32and64)
						MyFile.Copy (ProgramDataFolder & "\Comodo\" & FileNameCCC32and64)
						'fso.CopyFile SharedFolderCCC & "\" & FileNameCCC32and64, ProgramDataFolder & "\Comodo", True
					Else
						'WScript.Echo("UseHybridPackage = no")
						Set MyFile = fso.GetFile(SharedFolderCCC & "\" & FileNameCCC32)
						MyFile.Copy (ProgramDataFolder & "\Comodo\" & FileNameCCC32)
						'fso.CopyFile SharedFolderCCC & "\" & FileNameCCC32, ProgramDataFolder & "\Comodo", True
					End If
					If NOT (fso.FolderExists(SystemType & "\Program Files\COMODO")) Then
						'WScript.Echo("File DO NOT exists!" & SystemType & "\Program Files (x86)\COMODO" )
						fso.CreateFolder(SystemType & "\Program Files\COMODO")
					End If
					If NOT (fso.FolderExists(SystemType & "\Program Files\COMODO\Comodo ITSM")) Then
						'WScript.Echo("File DO NOT exists!" & SystemType & "\Program Files (x86)\COMODO" )
						fso.CreateFolder(SystemType & "\Program Files\COMODO\Comodo ITSM")
					End If
					If fso.FileExists(SystemType & "\Program Files\COMODO\Comodo ITSM\enrollment_config.ini") Then
						fso.DeleteFile(SystemType & "\Program Files\COMODO\Comodo ITSM\enrollment_config.ini")
					End If
					outFile = SystemType & "\Program Files\COMODO\Comodo ITSM\enrollment_config.ini"
					Set objFile = fso.CreateTextFile(outFile,True)
					objFile.WriteLine "[General]"
					objFile.WriteLine "host = " & Chr(34) & Host & Chr(34)
					objFile.WriteLine "port = " & Chr(34) & Port & Chr(34)
					objFile.WriteLine "remove_third_party = " & Chr(34) & "false" & Chr(34)
					objFile.WriteLine "suite = 4"
					objFile.WriteLine "token = " & Chr(34) & Token & Chr(34)
					objFile.Close
					If (UseProxy = "yes") Then
						If (UseMST = "no") Then
							If fso.FileExists(SystemType & "\Program Files\COMODO\Comodo ITSM\proxy_settings.ini") Then
								fso.DeleteFile(SystemType & "\Program Files\COMODO\Comodo ITSM\proxy_settings.ini")
							End If
							outFile1 = SystemType & "\Program Files\COMODO\Comodo ITSM\proxy_settings.ini"
							Set objFile1 = fso.CreateTextFile(outFile1,True)
							objFile1.WriteLine "[General]"
							objFile1.WriteLine "proxy_use = " & Chr(34) & "true" & Chr(34)
							objFile1.WriteLine "proxy_host = " & Chr(34) & ProxyHost & Chr(34)
							objFile1.WriteLine "proxy_port = " & Chr(34) & ProxyPort & Chr(34)
							If (ProxyUseAuth = "yes") Then
								objFile1.WriteLine "proxy_use_auth = " & Chr(34) & "true" & Chr(34)
								objFile1.WriteLine "proxy_user = " & Chr(34) & ProxyLogin & Chr(34)
								objFile1.WriteLine "proxy_password = " & Chr(34) & ProxyPassword & Chr(34)
							Else
								objFile1.WriteLine "proxy_use_auth = " & Chr(34) & "false" & Chr(34)
								objFile1.WriteLine "proxy_user = "
								objFile1.WriteLine "proxy_password = "
							End If
						Else
							'fso.CopyFile SharedFolderMST & "\" & FileNameMST, ProgramDataFolder & "\Comodo", True
							Set MyFile = fso.GetFile(SharedFolderCCC & "\" & FileNameMST)
							MyFile.Copy (ProgramDataFolder & "\Comodo\" & FileNameMST)
						End If
					End If
					If (UseHybridPackage = "yes") Then
						If (UseMST = "no") Then
							install32msipath = "msiexec.exe" & " /I " & ProgramDataFolder & "\Comodo\" & FileNameCCC32and64 & " /quiet"
							wshShell.Run install32msipath,0,true
						Else
							install32msipath = "msiexec.exe" & " /I " & ProgramDataFolder & "\Comodo\" & FileNameCCC32and64 & " /quiet TRANSFORMS=" & ProgramDataFolder & "\Comodo\" & FileNameMST
							wshShell.Run install32msipath,0,true
						End If
					Else
						If (UseMST = "no") Then
							install32msipath = "msiexec.exe" & " /I " & ProgramDataFolder & "\Comodo\" & FileNameCCC32 & " /quiet"
							wshShell.Run install32msipath,0,true
						Else
							install32msipath = "msiexec.exe" & " /I " & ProgramDataFolder & "\Comodo\" & FileNameCCC32 & " /quiet TRANSFORMS=" & ProgramDataFolder & "\Comodo\" & FileNameMST
							wshShell.Run install32msipath,0,true
						End If
					End If
					If fso.FileExists(ProgramDataFolder & "\Comodo\" & FileNameCCC32and64) Then
						'WScript.Echo("Delete previous download" )
						fso.DeleteFile(ProgramDataFolder & "\Comodo\" & FileNameCCC32and64)
					End If
					If fso.FileExists(ProgramDataFolder & "\Comodo\" & FileNameCCC32) Then
						'WScript.Echo("Delete previous download" )
						fso.DeleteFile(ProgramDataFolder & "\Comodo\" & FileNameCCC32)
					End If
					If fso.FileExists(ProgramDataFolder & "\Comodo\" & FileNameMST) Then
						'WScript.Echo("Delete previous download" )
						fso.DeleteFile(ProgramDataFolder & "\Comodo\" & FileNameMST)
					End If
				End If
			End If
		End If
	End If
Else
	'WScript.Echo("InstallCCC = no")
End If
If (InstallCCS = "yes") Then
	'WScript.Echo("InstallCCS = yes")
	If (InstallCCSFromComodoServers = "yes") Then
		'WScript.Echo("InstallCCSFromComodoServers = yes")
		If (fso.FolderExists(SystemType & "\Program Files (x86)" )) Then
			'WScript.Echo("System Type 64 - bit")
			If NOT fso.FileExists(CCSPath3264) Then
				'WScript.Echo("CCS is not present")
				If NOT (fso.FolderExists(ProgramDataFolder & "\Comodo" )) Then
					'WScript.Echo("File DO NOT exists!" & ProgramDataFolder & "\Comodo" )
					fso.CreateFolder(ProgramDataFolder & "\Comodo")
				End If
				If fso.FileExists(ProgramDataFolder & "\Comodo\CIS_x64.msi") Then
					'WScript.Echo("Delete previous download" )
					fso.DeleteFile(ProgramDataFolder & "\Comodo\CIS_x64.msi")
				End If
				'dim xHttp: Set xHttp = createobject("Microsoft.XMLHTTP")
				dim xHttp2: Set xHttp2 = createobject("MSXML2.ServerXMLHTTP")
				dim bStrm2: Set bStrm2 = createobject("Adodb.Stream")
				CCSurl = "https://download.comodo.com/itsm/CIS_x64.msi"
				CCSDefaultName = "CIS_x64.msi"
				xHttp2.Open "GET", CCSurl, False
				xHttp2.Send
				with bStrm2
					.type = 1 '//binary
					.open
					.write xHttp2.responseBody
					.savetofile(ProgramDataFolder & "\Comodo\" & CCSDefaultName ), 2
				end with
				c = "1"
				a = "1"
				f = "1"
				If (Containment = "yes") Then
					c = "1"
				Else
					c = "0"
				End If
				If (Antivirus = "yes") Then
					a = "1"
				Else
					a = "0"
				End If
				If (Firewall = "yes") Then
					f = "1"
				Else
					f = "0"
				End If
				install64msipath = "msiexec.exe" & " /I " & ProgramDataFolder & "\Comodo\" & CCSDefaultName & " /quiet REBOOT=ReallySuppress CESMCONTEXT=1 MAKE_CESM_DEFAULT_CONFIG=1 CES_SANDBOX=" & c & " CES_FIREWALL=1 CES_ANTIVIRUS=" & a & " INSTALLFIREWALL=" & f
				wshShell.Run install64msipath,0,true
				WScript.Sleep 300000
				If fso.FileExists(ProgramDataFolder & "\Comodo\CIS_x64.msi") Then
					'WScript.Echo("Delete previous download" )
					fso.DeleteFile(ProgramDataFolder & "\Comodo\CIS_x64.msi")
				End If
				If NOT (Database = "yes") Then
					If NOT (SuppressReboot = "yes") Then
						shutdownrestart = "shutdown.exe -r -t " & RebootTime & " /f /c " & Chr(34) & RebootComment & Chr(34)
						wshShell.Run shutdownrestart,0,true
					End If
				End If
			Else
				'WScript.Echo("CCS is present")
			End If
		Else
			'WScript.Echo("System Type 32 - bit")
			If NOT fso.FileExists(CCSPath3264) Then
				'WScript.Echo("CCS is not present")
				If NOT (fso.FolderExists(ProgramDataFolder & "\Comodo" )) Then
					'WScript.Echo("File DO NOT exists!" & ProgramDataFolder & "\Comodo" )
					fso.CreateFolder(ProgramDataFolder & "\Comodo")
				End If
				If fso.FileExists(ProgramDataFolder & "\Comodo\CIS_x86.msi") Then
					'WScript.Echo("Delete previous download" )
					fso.DeleteFile(ProgramDataFolder & "\Comodo\CIS_x86.msi")
				End If
				'dim xHttp1: Set xHttp1 = createobject("Microsoft.XMLHTTP")
				dim xHttp3: Set xHttp3 = createobject("MSXML2.ServerXMLHTTP")
				dim bStrm3: Set bStrm3 = createobject("Adodb.Stream")
				CCSurl = "https://download.comodo.com/itsm/CIS_x86.msi"
				CCSDefaultName = "CIS_x86.msi"
				xHttp3.Open "GET", CCSurl, False
				xHttp3.Send
				with bStrm3
					.type = 1 '//binary
					.open
					.write xHttp3.responseBody
					.savetofile(ProgramDataFolder & "\Comodo\" & CCSDefaultName ), 2
				end with
				c = "1"
				a = "1"
				f = "1"
				If (Containment = "yes") Then
					c = "1"
				Else
					c = "0"
				End If
				If (Antivirus = "yes") Then
					a = "1"
				Else
					a = "0"
				End If
				If (Firewall = "yes") Then
					f = "1"
				Else
					f = "0"
				End If
				install32msipath = "msiexec.exe" & " /I " & ProgramDataFolder & "\Comodo\" & CCSDefaultName & " /quiet REBOOT=ReallySuppress CESMCONTEXT=1 MAKE_CESM_DEFAULT_CONFIG=1 CES_SANDBOX=" & c & " CES_FIREWALL=1 CES_ANTIVIRUS=" & a & " INSTALLFIREWALL=" & f
				wshShell.Run install32msipath,0,true
				WScript.Sleep 300000
				If fso.FileExists(ProgramDataFolder & "\Comodo\CIS_x86.msi") Then
					'WScript.Echo("Delete previous download" )
					fso.DeleteFile(ProgramDataFolder & "\Comodo\CIS_x86.msi")
				End If
				If NOT (Database = "yes") Then
					If NOT (SuppressReboot = "yes") Then
						shutdownrestart = "shutdown.exe -r -t " & RebootTime & " /f /c " & Chr(34) & RebootComment & Chr(34)
						wshShell.Run shutdownrestart,0,true
					End If
				End If
			Else
				'WScript.Echo("CCS is present")
			End If
		End If
	Else
		'WScript.Echo("InstallCCSFromComodoServers = no")
		If (fso.FolderExists(SystemType & "\Program Files (x86)" )) Then
			'WScript.Echo("System Type 64 - bit")
			If NOT fso.FileExists(CCSPath3264) Then
				'WScript.Echo("CCS is not present")
				If NOT (fso.FolderExists(ProgramDataFolder & "\Comodo" )) Then
					'WScript.Echo("File DO NOT exists!" & ProgramDataFolder & "\Comodo" )
					fso.CreateFolder(ProgramDataFolder & "\Comodo")
				End If
				If fso.FileExists(ProgramDataFolder & "\Comodo\" & FileNameCCS64) Then
					'WScript.Echo("Delete previous download" )
					fso.DeleteFile(ProgramDataFolder & "\Comodo\" & FileNameCCS64)
				End If
				Set MyFile = fso.GetFile(SharedFolderCCS & "\" & FileNameCCS64)
				MyFile.Copy (ProgramDataFolder & "\Comodo\" & FileNameCCS64)
				c = "1"
				a = "1"
				f = "1"
				If (Containment = "yes") Then
					c = "1"
				Else
					c = "0"
				End If
				If (Antivirus = "yes") Then
					a = "1"
				Else
					a = "0"
				End If
				If (Firewall = "yes") Then
					f = "1"
				Else
					f = "0"
				End If
				install64msipath = "msiexec.exe" & " /I " & ProgramDataFolder & "\Comodo\" & FileNameCCS64 & " /quiet REBOOT=ReallySuppress CESMCONTEXT=1 MAKE_CESM_DEFAULT_CONFIG=1 CES_SANDBOX=" & c & " CES_FIREWALL=1 CES_ANTIVIRUS=" & a & " INSTALLFIREWALL=" & f
				wshShell.Run install64msipath,0,true
				WScript.Sleep 300000
				If fso.FileExists(ProgramDataFolder & "\Comodo\" & FileNameCCS64) Then
					'WScript.Echo("Delete previous download" )
					fso.DeleteFile(ProgramDataFolder & "\Comodo\" & FileNameCCS64)
				End If
				If NOT (Database = "yes") Then
					If NOT (SuppressReboot = "yes") Then
						shutdownrestart = "shutdown.exe -r -t " & RebootTime & " /f /c " & Chr(34) & RebootComment & Chr(34)
						wshShell.Run shutdownrestart,0,true
					End If
				End If
			Else
				'WScript.Echo("CCS is present")
			End If
		Else
			'WScript.Echo("System Type 32 - bit")
			If NOT fso.FileExists(CCSPath3264) Then
				'WScript.Echo("CCS is not present")
				If NOT (fso.FolderExists(ProgramDataFolder & "\Comodo" )) Then
					'WScript.Echo("File DO NOT exists!" & ProgramDataFolder & "\Comodo" )
					fso.CreateFolder(ProgramDataFolder & "\Comodo")
				End If
				If fso.FileExists(ProgramDataFolder & "\Comodo\" & FileNameCCS32) Then
					'WScript.Echo("Delete previous download" )
					fso.DeleteFile(ProgramDataFolder & "\Comodo\" & FileNameCCS32)
				End If
				Set MyFile = fso.GetFile(SharedFolderCCS & "\" & FileNameCCS32)
				MyFile.Copy (ProgramDataFolder & "\Comodo\" & FileNameCCS32)
				c = "1"
				a = "1"
				f = "1"
				If (Containment = "yes") Then
					c = "1"
				Else
					c = "0"
				End If
				If (Antivirus = "yes") Then
					a = "1"
				Else
					a = "0"
				End If
				If (Firewall = "yes") Then
					f = "1"
				Else
					f = "0"
				End If
				install32msipath = "msiexec.exe" & " /I " & ProgramDataFolder & "\Comodo\" & FileNameCCS32 & " /quiet REBOOT=ReallySuppress CESMCONTEXT=1 MAKE_CESM_DEFAULT_CONFIG=1 CES_SANDBOX=" & c & " CES_FIREWALL=1 CES_ANTIVIRUS=" & a & " INSTALLFIREWALL=" & f
				wshShell.Run install32msipath,0,true
				WScript.Sleep 300000
				If fso.FileExists(ProgramDataFolder & "\Comodo\" & FileNameCCS32) Then
					'WScript.Echo("Delete previous download" )
					fso.DeleteFile(ProgramDataFolder & "\Comodo\" & FileNameCCS32)
				End If
				If NOT (Database = "yes") Then
					If NOT (SuppressReboot = "yes") Then
						shutdownrestart = "shutdown.exe -r -t " & RebootTime & " /f /c " & Chr(34) & RebootComment & Chr(34)
						wshShell.Run shutdownrestart,0,true
					End If
				End If
			Else
				'WScript.Echo("CCS is present")
			End If
		End If
	End If
Else
	'WScript.Echo("InstallCCS = no")
End If
If (Database = "yes") Then
	'WScript.Echo("Database = yes")
	RegValue = wshShell.RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\COMODO\CIS\Data\AvDbVersion")
	If (regValue = "0" or regValue = "1") Then
		'WScript.Echo("Antivirus signature database out of date")
		If NOT (fso.FolderExists(ProgramDataFolder & "\Comodo" )) Then
			'WScript.Echo("File DO NOT exists!" & ProgramDataFolder & "\Comodo" )
			fso.CreateFolder(ProgramDataFolder & "\Comodo")
		End If
		If fso.FileExists(ProgramDataFolder & "\Comodo\" & FileNameCAV) Then
			'WScript.Echo("Delete previous download" )
			fso.DeleteFile(ProgramDataFolder & "\Comodo\" & FileNameCAV)
		End If
		Set MyFile = fso.GetFile(SharedFolderPathCAV & "\" & FileNameCAV)
		MyFile.Copy (ProgramDataFolder & "\Comodo\" & FileNameCAV)
		cavpath = Chr(34) & "C:\Program Files\COMODO\COMODO Internet Security\cfpconfg.exe" & Chr(34) & " --importAVDB " & ProgramDataFolder & "\Comodo\" & FileNameCAV
		wshShell.Run cavpath,0,true
		RegValue = wshShell.RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\COMODO\CIS\Data\AvDbVersion")
		WScript.Sleep 300000
		If (regValue = "0" or regValue = "1") Then
			wshShell.Run cavpath,0,true
			WScript.Sleep 300000
		End If
		RegValue = wshShell.RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\COMODO\CIS\Data\AvDbVersion")
		If (regValue = "0" or regValue = "1") Then
			wshShell.Run cavpath,0,true
			WScript.Sleep 300000
		End If
		RegValue = wshShell.RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\COMODO\CIS\Data\AvDbVersion")
		If (regValue = "0" or regValue = "1") Then
			wshShell.Run cavpath,0,true
			WScript.Sleep 300000
		End If
		RegValue = wshShell.RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\COMODO\CIS\Data\AvDbVersion")
		If (regValue = "0" or regValue = "1") Then
			wshShell.Run cavpath,0,true
			WScript.Sleep 300000
		End If
		RegValue = wshShell.RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\COMODO\CIS\Data\AvDbVersion")
		If (regValue = "0" or regValue = "1") Then
			wshShell.Run cavpath,0,true
			WScript.Sleep 300000
		End If
		If fso.FileExists(ProgramDataFolder & "\Comodo\" & FileNameCAV) Then
			'WScript.Echo("Delete previous download" )
			fso.DeleteFile(ProgramDataFolder & "\Comodo\" & FileNameCAV)
		End If
		If NOT (SuppressReboot = "yes") Then
			shutdownrestart = "shutdown.exe -r -t " & RebootTime & " /f /c " & Chr(34) & RebootComment & Chr(34)
			wshShell.Run shutdownrestart,0,true
		End If
	Else
		'WScript.Echo("Antivirus signature database up to date")
	End If
End If























