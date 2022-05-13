<#

Auteur : Martin Guigot
Date : 09/05/2022
Version : 1.1
Description : Script de sauvegarde des données utilisateurs (C:\Users de chaque PC) dans le serveur (E:\Sauvegardes)

#>

# Définition des variables.
$DirBackUp = 'E:\Sauvegarde'
$DirFiles = "C:\Users\$env:USERNAME\Downloads"

# Compression des données à sauvegarder dans le dossier de sauvegarde de l'utilisateur dans une archive au nom du poste sur lequel il se connecte.


# Test du chemin d'accès du dossier de sauvegarde de l'utilisateur.
$TestDirSaveUser = Test-Path -Path $DirBackUp\$env:USERNAME

# Création d'un dossier de sauvegarde de l'utilisateur s'il n'existe pas.
switch ($TestDirSaveUser) {
    False {New-Item -Name $env:USERNAME -ItemType Directory -Path $DirBackUp | Out-Null}
    Default{}    
    } 

       
Compress-Archive -Path $DirFiles -Destination $DirBackUp\$env:USERNAME\$env:COMPUTERNAME -force
# Copy-Item -Path $DirFiles -Destination "$DirBackUp\$env:USERNAME\$env:COMPUTERNAME\"

