<#

Auteur : Martin Guigot
Date : 17/05/2022
Version : 1.2
Description : Script de sauvegarde des données utilisateurs (C:\Users de chaque PC) dans le serveur (E:\Sauvegarde)

#>



# Définition des variables.
$DirBackUp = "\\SRVFRANCISCA\Sauvegarde$\$env:USERNAME" 
$DirFiles = "C:\Users\$env:USERNAME\*"

New-Item -ItemType Directory -Path $DirBackUp | Out-Null


# Compression des données à sauvegarder dans le dossier de sauvegarde dans une archive au nom du poste. 
Compress-Archive -Path $DirFiles -Destination $DirBackUp\$env:COMPUTERNAME -force
