<#

Auteur : Martin Guigot
Date : 01/04/2022
Version : 1.0
Description : Script de sauvegarde des données utilisateurs (C:\Users de chaque PC) dans le serveur (E:\Sauvegardes)

#>

$Users = Get-ADUser -filter * | select name

foreach($u in Users) {
$name = $u.name
Copy-Item -Path C:\Users\$name -Destination \\SRVFRANCISCA\Sauvegardes\$name -Recurse -ErrorAction SilentlyContinue
}
