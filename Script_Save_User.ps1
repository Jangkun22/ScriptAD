<#

Auteur : Martin Guigot
Date : 09/05/2022
Version : 1.1
Description : Script de sauvegarde des données utilisateurs (C:\Users de chaque PC) dans le serveur (E:\Sauvegarde)

#>

# Définition des variables.
$DirBackUp = '\\SRVFRANCISCA\E$\Sauvegarde' 
$DirFiles = 'C:\Users\*'

# Compression des données à sauvegarder dans le dossier de sauvegarde dans une archive au nom du poste. 
Compress-Archive -Path $DirFiles -Destination $DirBackUp\$env:COMPUTERNAME -force


