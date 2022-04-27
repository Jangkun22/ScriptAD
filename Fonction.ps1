<#

Auteur : Martin Guigot
Date : 01/04/2022
Version : 1.0
Description : Script intéractif de création d'utilisateurs de l'Active Directory et de leur dossier personnel.

#>

$Answer = ''
$ValidAnswer = @(
    'n'
    'o'
    )
$LastName = '' 
$FirstName = '' 
$Username = ''
$Password = ''
$Name = ''


try
  {
  New-ADUser -Name $Name -GivenName $FirstName -Surname $LastName -SamAccountName $Username -UserPrincipalName $Username@axeplane.loc -Type iNetOrgPerson -AccountPassword (ConvertTo-SecureString -AsPlainText $Password -Force) -ChangePasswordAtLogon $false -PasswordNeverExpires $true -CannotChangePassword $false -Enabled $true | Out-Host 
  $CreateNewUSer = True
  }
catch
  {
  $CreateNewUSer = False
  }
  
try
  {
  New-Item -Name $Name -ItemType Directory -Path E:\Sauvegardes | Out-Null 
  $CreateNewPersonnalFile = True
  }
catch
  {
  $CreateNewPersonnalFile = False
  }
  
try
  {
  New-SmbShare -Name $Name -Path E:\Sauvegardes\$Name -FullAccess $Username | Out-Null
  $CreatePersonnalFileShare = True
  }
catch
  {
  $CreatePersonnalFileShare = False
  }
