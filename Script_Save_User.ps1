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

# Test du chemin d'accès du dossier de sauvegarde du poste de l'utilisateur.
$TestDirUserComputer = Test-Path -Path $DirBackUp\$env:USERNAME\$Computer

# Test du chemin d'accès du dossier de sauvegarde de l'utilisateur.
$TestDirSaveUser = Test-Path -Path $DirBackUp\$env:USERNAME

# Création d'un dossier de sauvegarde du poste de l'utilisateur s'il n'existe pas et création d'un dossier de sauvegarde de l'utilisateur et de son poste si le dossier de sauvegarde de l'utilisateur n'existe pas.
switch ($TestDirUserComputer) {
    False { 
        switch ($TestDirSaveUser) {
            False { 
                New-Item -Name $env:USERNAME -ItemType Directory -Path $DirBackUp | Out-Null
                New-Item -Name $Computer -ItemType Directory -Path $DirBackUp\$env:USERNAME | Out-Null
                }
            True {New-Item -Name $Computer -ItemType Directory -Path $DirBackUp\$env:USERNAME | Out-Null}
        } 
    }
    Default {
        # Compression des données à sauvegarder sur dans le dossier de sauvegarde de l'utilisateur de chacun des PC.
        Compress-Archive -Path $DirFiles -Destination $DirBackUp\$env:USERNAME\$Computer >$DirLog
    }
}
 


