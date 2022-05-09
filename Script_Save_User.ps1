<#

Auteur : Martin Guigot
Date : 09/05/2022
Version : 1.1
Description : Script de sauvegarde des données utilisateurs (C:\Users de chaque PC) dans le serveur (E:\Sauvegardes)

#>

# Définition des variables.
$DirBackUp = '\\SRVFRANCISCA\Sauvegardes'
$DirFiles = 'C:\Users'
$DirLog = 'C:\Users\Administrateur\documents\log.txt'
$Computer = HOSTNAME.EXE
 
# Compression des données à sauvegarder sur dans le dossier de sauvegarde de l'utilisateur de chacun des PC.
 Compress-Archive -Path $DirFiles -Destination $DirBackUp\$env:USERNAME\$Computer >$DirLog

