<#

Auteur : Martin Guigot
Date : 01/04/2022
Version : 1.0
Description : Script intéractif de consultation et d'export des groupes d'un utilisateur de l'Active Directory.

#>

    # Définition de variables.
$Answer = ''
$ValidAnswer = @(
    'n'
    'o'
    )
cls
Write-Host "Ce script permet de lister les groupes d'un utilisateur de l'Active Directory" -ForegroundColor Green -BackgroundColor Red
pause

# Bloc Do-Until pour réitérer la recherche jusqu'à refus d'une nouvelle recherche ($Answer = 'n').
do
    {
    cls

    # Demande interactive de l'identifiant de l'utilisateur à rechercher.
    $username = Read-Host "Identifiant de l'Utilisateur"

    # Tentative de correspondance entre le $username et les utilisateurs existants.
    try

        # Affiche le nom des groupes dont l'utilisateur correspondant à $username est membre.
        {
        Get-ADUser $username | Out-Null
        $GroupList = Get-ADPrincipalGroupMembership $username | select name
        foreach ($u in $GroupList)
            {
            $u.name
            }

        <#
        Interaction de demande d'export.
            Avertissement de l'erreur et réitération de la demande en cas de réponse invalide (autre que "o" (oui) et "n" (non)).
            Export de la liste des groupes de $username dans le fichier Export + message en cas de réponse positive.
            Message en cas de réponse négative.
        #>
        while ([String]::IsNullOrEmpty($Answer))
            {
            $Answer = Read-Host "Exporter les résultats ? (O/N)"
            if ($Answer -notin $ValidAnswer)
                {
                Write-Warning 'Réponse non valide. Répondre par "o" pour oui ou "n" pour non'
                $Answer = ''
                }
            }
        switch ($Answer)
            {
            'o'
                {
                Get-ADPrincipalGroupMembership $username | select name | Export-Csv C:\Users\Administrateur\Documents\Export\$username.txt
                Write-Host "La liste des groupes de l'utilisateur $username a été exporté dans le dossier Export"
                $Answer = ''
                }
            'n'
                {
                Write-Host "La liste des groupes de l'utilisateur $username n'a pas été exporté"
                $Answer = ''
                }
            }
        }

    # Message à afficher en cas d'échec dans le bloc try.
    catch
        {
        Write-Warning "L'utilisateur $username n'existe pas."
        }

    <#
    Interaction de nouvelle de recherche.
            Avertissement de l'erreur et réitération de la demande en cas de réponse invalide (autre que "o" (oui) et "n" (non)).
            Retour au bloc Try l.25 en cas de réponse positive.
    #>
    while ([String]::IsNullOrEmpty($Answer))
        {
        $Answer = Read-Host "Chercher un autre utilisateur ? (O/N)"
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
until($Answer -like 'n')