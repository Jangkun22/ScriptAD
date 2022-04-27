<#

Auteur : Martin Guigot
Date : 01/04/2022
Version : 1.0
Description : Script de sauvegarde des données utilisateurs (C:\Users de chaque PC) dans le serveur (E:\Sauvegardes)

#>

#$BackUp = \\SRVFRANCISCA\Sauvegardes\$[computer name]
#$Files = C:\Users\$[computer name]

#Copy-Item -Path $Files -Destination $BackUp -Recurse -ErrorAction SilentlyContinue >c:\documents\log.txt
  
 Copy-Item -Path C:\Users\Administrateur -Destination e:\temp -Recurse -ErrorAction SilentlyContinue >C:\Users\Administrateur\documents\log.txt


  