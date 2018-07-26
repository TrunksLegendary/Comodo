
# this will copy file and subfolders from my oneDrive folder to a backup location
# I run a task scheudaler set to every 30 minutes 
# files are overwritten

SET _datetime=%DATE:~7,2%-%DATE:~4,2%-%DATE:~10,4%
if not exist "C:\Users\Public\Comodo-Backup\" (mkdir "C:\Users\Public\Comodo-Backup")
robocopy "C:\Users\hirenp\OneDrive - Nurd" "C:\Users\Public\Comodo-Backup\OneDrive - Nurd" /E /R:1 /LOG+:C:\Users\Public\Comodo-Backup\RoboSync_%_DATETIME%.log /V

