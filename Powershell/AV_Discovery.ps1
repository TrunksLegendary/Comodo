$export_Path = "$env:PUBLIC"

#Installed McAfee and Kapersky Products
$MacAfeeKapersky = (Get-WmiObject -Class Win32_Product |`
     Where-Object { $_.Name -like "*office*" -or $_.name -like "*comodo*"} |`
     Select Name, IdentifyingNumber, Version, InstallLocation) 
$MacAfeeKapersky | Export-Csv -Path ($export_Path + "\InstalledProgs.csv") -NoTypeInformation

#UnInstall Stringsfor  McAfee and Kapersky Products
$UninstallInfo = (Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |
    Select-Object DisplayName, UninstallString | `
    Where-Object { $_.Name -like "*office*" -or $_.name -like "*comodo*"})
$UninstallInfo | Export-Csv -Path ($export_Path + "\InstalledProgs.csv")  -Append -NoTypeInformation

# The output file is located in C:\Users\Public\InstalledProgs.csv