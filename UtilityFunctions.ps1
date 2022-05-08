<#

Auteur : Martin Guigot
Date : 01/04/2022
Version : 1.0
Description : Script intéractif de création d'utilisateurs de l'Active Directory et de leur dossier personnel.

# >

function Write-Test{
Write-Host '123'}


# Appel du script contenant les fonctions utilis�es. 
.\UtilityFunctions.ps1


function Test-User($Username) {
try
  {
  New-ADUser -Name $Name -GivenName $FirstName -Surname $LastName -SamAccountName $Username -UserPrincipalName $Username@axeplane.loc -Type iNetOrgPerson -AccountPassword (ConvertTo-SecureString -AsPlainText $Password -Force) -ChangePasswordAtLogon $false -PasswordNeverExpires $true -CannotChangePassword $false -Enabled $true | Out-Host 
  $CreateNewUSer = True
  }
catch
  {
  $CreateNewUSer = False
  }
  }
  
function Test-Path($Path) {
  try
  {
  New-Item -Name $Name -ItemType Directory -Path $Path | Out-Null 
  $CreateNewPersonnalFile = True
  }
catch
  {
  $CreateNewPersonnalFile = False
  }
}

function Test-Share($Name) {  
try
  {
  New-SmbShare -Name $Name -Path E:\Sauvegardes\$Name -FullAccess $Username | Out-Null
  $CreatePersonnalFileShare = True
  }
catch
  {
  $CreatePersonnalFileShare = False
  }
  }

<#





< #
Auteur : Martin Guigot
Date : 01/04/2022
Version : 1.0
Description : Bibliothèque de fonction
function Test-User {
try
            {
            Get-ADUser $Username | Out-Null
            Write-Warning "L'identifiant existe déjà."
            $Username = ''
            }
        catch
            {
            Switch($Username)
                {
                '*'
                    {
                    Write-Host "L'identifiant est disponible."
                    }
                ''
                    {
                    Write-Warning "Veuillez saisir un identifiant."
                    }
                }
            }
}
$DirPersonnalFolder = E:\Dossiers Personnels
$DirPersonnalFolderUser = E:\Dossiers Personnels\$Name
function Create-User {
                New-ADUser -Name $Name -GivenName $FirstName -Surname $LastName -SamAccountName $Username -UserPrincipalName $Username@axeplane.loc -Type iNetOrgPerson -AccountPassword (ConvertTo-SecureString -AsPlainText $Password -Force) -ChangePasswordAtLogon $false -PasswordNeverExpires $true -CannotChangePassword $false -Enabled $true | Out-Host    
                New-Item -Name $Name -ItemType Directory -Path $DirPersonnalFolder | Out-Null
                New-SmbShare -Name $Name -Path $DirPersonnalFolderUser -FullAccess $Username | Out-Null
                Write-Host "L'utilisateur a été créé" -ForegroundColor Green
                Write-Host "Le dossier personnel de l'utilisateur a été créé et configuré" -ForegroundColor Green
}
function Test-CreaUser {
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
  
  function Test-CreaUser {
try
  {
  New-ADUser -Name $Name -GivenName $FirstName -Surname $LastName -SamAccountName $Username -UserPrincipalName $Username@axeplane.loc -Type iNetOrgPerson -AccountPassword (ConvertTo-SecureString -AsPlainText $Password -Force) -ChangePasswordAtLogon $false -PasswordNeverExpires $true -CannotChangePassword $false -Enabled $true | Out-Host 
  New-Item -Name $Name -ItemType Directory -Path E:\Sauvegardes | Out-Null 
  New-SmbShare -Name $Name -Path E:\Sauvegardes\$Name -FullAccess $Username | Out-Null
  $Test-CreaUser = True
  }
catch
  {
  $Test-CreaUser = False
  }
  

  

 function Test-CreaUser{
try
  {
  New-ADUser -Name $Name -GivenName $FirstName -Surname $LastName -SamAccountName $Username -UserPrincipalName $Username@axeplane.loc -Type iNetOrgPerson -AccountPassword (ConvertTo-SecureString -AsPlainText $Password -Force) -ChangePasswordAtLogon $false -PasswordNeverExpires $true -CannotChangePassword $false -Enabled $true | Out-Host 
  New-Item -Name $Name -ItemType Directory -Path $Path | Out-Null 
  New-SmbShare -Name $Name -Path E:\Sauvegardes\$Name -FullAccess $Username | Out-Null
  $CreateNewUser = Fromage
  }
catch
  {
  $CreateNewUser = False
  }
  }
  #>