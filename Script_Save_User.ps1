<#

Auteur : Martin Guigot
Date : 17/05/2022
Version : 1.21
Description : Script de sauvegarde des données utilisateurs (C:\Users\[Utilisateur]\*) dans le serveur (E:\Sauvegarde\[Utilisateur])

#>

# Définition des variables.
$DirBackUp = "\\SRVFRANCISCA\Sauvegarde$\$env:USERNAME" 
$DirFiles = "C:\Users\$env:USERNAME\*"

# Création d'un dossier de sauvegarde s'il n'existe pas.
$TestDirBackUp = Test-Path -Path $DirBackUp
 switch ($TestDirBackUp) {
    False {New-Item -ItemType Directory -Path $DirBackUp | Out-Null}
    Default{}  
    }

# Compression des données à sauvegarder dans le dossier de sauvegarde dans une archive au nom du poste. 
Compress-Archive -Path $DirFiles -Destination $DirBackUp\$env:COMPUTERNAME -force
