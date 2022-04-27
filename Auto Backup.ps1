#Action
$ScriptBackUp = C:\Save_User.ps1

$Action = New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument "-NonInteractive -NoLogo -NoProfile -File '$ScriptBackUp'"


#Trigger

$Trigger = New-ScheduledTaskTrigger -AtLogOn
$Trigger.delay = "PT4H"


#Task Trigger>Action

$Task = New-ScheduledTask -Action $Action -Trigger $Trigger -Settings (New-ScheduledTaskSettingsSet)


#Task PC

$Task | Register-ScheduledTask -TaskName 'BackUp Automation' 

# apply PC 1 time