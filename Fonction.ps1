<#

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
  
  
 
