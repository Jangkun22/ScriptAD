<#
Auteur : Martin Guigot
Date : 08/05/2022
Version : 1.12
Description : Script intéractif de création d'utilisateurs de l'Active Directory et de leur dossier personnel.
#>


# Définition de variables.
$Answer = ''
$ValidAnswer = @(
    'n'
    'o'
    )
$DirPerso = 'E:\Partages personnels'

# Effacement du texte à l'écran pour une vue plus dégagée et présentation du script.
cls
Write-Host "Ce script permet la création d'un utilisateur de l'Active Directory ainsi que son dossier personnel" -ForegroundColor Green -BackgroundColor Red
pause
cls

while ([String]::IsNullOrEmpty($Answer))
    {
    $LastName = '' 
    $FirstName = '' 
    $Username = ''
    $Password = ''
    $Name = ''

    while([String]::IsNullOrEmpty($LastName))
        {
        $LastName = Read-Host "Nom de l'utilisateur"
        if ([String]::IsNullOrEmpty($LastName))
            {
            Write-Warning "Veuillez saisir un nom d'utilisateur."
            }
        }
     while([String]::IsNullOrEmpty($FirstName))
        {
        $FirstName = Read-Host "Prénom de l'utilisateur"
        if ([String]::IsNullOrEmpty($FirstName))
            {
            Write-Warning "Veuillez saisir un prénom d'utilisateur."
            }
        }
    $Name = "$FirstName $LastName"
    while ([String]::IsNullOrEmpty($Username))
        {
        $Username = Read-Host "Identifiant de l'utilisateur"
        try
            {
            Get-ADUser $Username | Out-Null
            Write-Warning "L'identifiant existe déjà ."
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
                    Write-Warning 'Veuillez saisir un identifiant.'
                    }
                }
            }            
        }
    while([String]::IsNullOrEmpty($Password))
        {
        $Password = Read-Host "Mot de passe de l'utilisateur"
        if ([String]::IsNullOrEmpty($Password))
            {
            Write-Warning 'Veuillez saisir un mot de passe utilisateur.'
            }
        }
    pause
    do
        {
        cls
        Write-Host 'Récapitulatif des données utilisateur :'
        Write-Host "Nom : $LastName"
        Write-Host "Prénom : $FirstName"
        Write-Host "Identifiant : $Username"
        Write-Host "Mot de passe : $Password"
        while ([String]::IsNullOrEmpty($Answer))
            {
            $Answer = Read-Host 'Valider les informations ? (O/N)'
            if ($Answer -notin $ValidAnswer)
                {
                Write-Warning 'Réponse non valide. Répondre par "o" pour oui ou "n" pour non'
                $Answer = ''
                }
        }
    Switch($Answer)
        {
        'o'
            {
            try
                {
                New-ADUser -Name $Name -GivenName $FirstName -Surname $LastName -SamAccountName $Username -DisplayName $Name -UserPrincipalName $Username@axeplane.loc -Type iNetOrgPerson -AccountPassword (ConvertTo-SecureString -AsPlainText $Password -Force) -ChangePasswordAtLogon $false -PasswordNeverExpires $true -CannotChangePassword $false -Enabled $true | Out-Host 
                Write-Host "L'utilisateur a été créé" -ForegroundColor Green
                try
                    {
                    New-Item -Name $Name -ItemType Directory -Path $DirPerso | Out-Null 
                    Write-Host "Le dossier personnel de l'utilisateur a été créé" -ForegroundColor Green
                    try
                        {
                        New-SmbShare -Name $Username -Path $DirPerso\$Name -FullAccess $Username | Out-Null
                        Write-Host "Le partage du dossier personnel de l'utilisateur a été configuré" -ForegroundColor Green
                        }
                    catch
                        {
                        Write-Warning "Echec de la configuration du dossier personnel de l'utilisateur"
                        }
                    }
                catch
                    {
                    Write-Warning "Echec de la création du dossier personnel de l'utilisateur"
                    }
                }
            catch
                {
                Write-Warning "Erreur lors de la création de l'utilisateur"
                }
            }   
        'n'
            {
            $Answer = ''
            while ([String]::IsNullOrEmpty($Answer))
                {
                $Answer = Read-Host "Corriger le nom de l'utilisateur ? (O/N)"
                if ($Answer -notin $ValidAnswer)
                    {
                    Write-Warning 'Réponse non valide. Répondre par "o" pour oui ou "n" pour non'
                    $Answer = ''
                    }
                if($Answer -like 'o')
                    {
                    $LastName = ''
                    while([String]::IsNullOrEmpty($LastName))
                        {
                        $LastName = Read-Host "Nom de l'utilisateur"
                        if ([String]::IsNullOrEmpty($LastName))
                            {
                            Write-Warning "Veuillez saisir un nom d'utilisateur."
                            }
                        }
                    }
                }
            $Answer = ''
            while ([String]::IsNullOrEmpty($Answer))
                {
                $Answer = Read-Host "Corriger le prénom de l'utilisateur ? (O/N)"
                if ($Answer -notin $ValidAnswer)
                    {
                    Write-Warning 'Réponse non valide. Répondre par "o" pour oui ou "n" pour non'
                    $Answer = ''
                    }
                if($Answer -like 'o')
                    {
                    $FirstName = ''
                    while([String]::IsNullOrEmpty($FirstName))
                        {
                        $FirstName = Read-Host "Prénom de l'utilisateur"
                        if ([String]::IsNullOrEmpty($FirstName))
                            {
                            Write-Warning "Veuillez saisir un prénom d'utilisateur."
                            }
                        }
                    }
                }
            $Name = "$FirstName $LastName"
            $Answer = ''
            while ([String]::IsNullOrEmpty($Answer))
                {
                $Answer = Read-Host "Corriger l'identifiant de l'utilisateur ? (O/N)"
                if ($Answer -notin $ValidAnswer)
                    {
                    Write-Warning 'Réponse non valide. Répondre par "o" pour oui ou "n" pour non'
                    $Answer = ''
                    }
                if($Answer -like 'o')
                    {
                    $Username = ''
                    while ([String]::IsNullOrEmpty($Username))
                        {
                        $Username = Read-Host "Identifiant de l'utilisateur"
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
                                    Write-Warning 'Veuillez saisir un identifiant.'
                                    }
                                }
                            }
                        }
                    }
                }
            $Answer = ''
            while ([String]::IsNullOrEmpty($Answer))
                {
                $Answer = Read-Host "Corriger le mot de passe de l'utilisateur ? (O/N)"
                if ($Answer -notin $ValidAnswer)
                    {
                    Write-Warning 'Réponse non valide. Répondre par "o" pour oui ou "n" pour non'
                    $Answer = ''
                    }
                if($Answer -like 'o')
                    {
                    $Password = ''
                    while([String]::IsNullOrEmpty($Password))
                        {
                        $Password = Read-Host "Mot de passe de l'utilisateur"
                        if ([String]::IsNullOrEmpty($Password))
                            {
                            Write-Warning 'Veuillez saisir un mot de passe utilisateur.'
                            }
                        }
                    }
                }
            $Answer = ''
            }
        }
    }
    until($Answer -like 'o')
    $Answer = ''
    while ([String]::IsNullOrEmpty($Answer))
        {
        $Answer = Read-Host 'Créer un autre utilisateur ? (O/N)'
        if ($Answer -notin $ValidAnswer)
            {
            Write-Warning 'Réponse non valide. Répondre par "o" pour oui ou "n" pour non'
            $Answer = ''
            }
        }
    if ($Answer -like 'o')
        {
        $Answer = ''
        }
    }
