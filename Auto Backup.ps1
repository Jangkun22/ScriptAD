<#

Auteur : Martin Guigot
Date : 09/05/2022
Version : 1.0
Description : Script de création de tâche planifiée pour automatiser la sauvegarde utilisateur.

#>


<#
Action - Ce que fait la tâche.
Lance le script "Save_User.ps1".
#>

$ScriptBackUp = '\\SRVFRANCISCA\C$\Users\Administrateur\Documents\GitHub\ScriptAD\Script_Save_User.ps1'

$Action = New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument "-NonInteractive -NoLogo -NoProfile -File '$ScriptBackUp'"


<#
Trigger - Conditions de déclenchement de la tâche.
Se déclenche à l'ouverture de session +4h.
#>

$Trigger = New-ScheduledTaskTrigger -AtLogOn
#$Trigger.delay = "PT4H"


#Création de la tâche + configuration de l'Action et du Trigger.

$Task = New-ScheduledTask -Action $Action -Trigger $Trigger -Settings (New-ScheduledTaskSettingsSet)


#Enregistrement de la tâche.

$Task | Register-ScheduledTask -TaskName 'BackUp Automation' 

# apply PC 1 time