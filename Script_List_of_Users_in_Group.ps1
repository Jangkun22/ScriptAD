<#

Auteur : Martin Guigot
Date : 01/04/2022
Version : 1.0
Description : Script intéractif de consultation et d'export des membres d'un groupe de l'Active Directory.

#>

# Définition de variables.
$Answer = ''
$ValidAnswer = @(
    'n'
    'o'
    )
cls
Write-Host "Ce script permet de lister les membres d'un groupe de l'Active Directory" -ForegroundColor Green -BackgroundColor Red
pause

# Bloc Do-Until pour réitérer la recherche jusqu'à refus d'une nouvelle recherche ($Answer = 'n').
do
    {
    cls

    # Demande interactive du nom du groupe à rechercher.
    $Group = Read-Host "Nom du Groupe"

    # Tentative de correspondance entre le $Group et les groupes existants.
    try

        # Affiche le nom des utilisateurs membres du groupe correspondant à $Group.
        {
        Get-ADGroup $Group | Out-Null
        $UserList = Get-ADGroupMember $Group | Select-Object name
        foreach ($u in $UserList)
            {
            $u.name
            }

        <#
        Interaction de demande d'export.
            Avertissement de l'erreur et réitération de la demande en cas de réponse invalide (autre que "o" (oui) et "n" (non)).
            Export de la liste des utilisateurs du $Group dans le fichier Export + message en cas de réponse positive.
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
                $DirExportGroup = 'C:\Users\Administrateur\Documents\Export\$Group.txt'
                Get-ADGroupMember $Group | Select-Object name | Export-Csv $DirExportGroup
                Write-Host "La liste des membres du groupe $Group a été exporté dans le dossier Export"
                $Answer = ''
                }
            'n'
                {
                Write-Host "La liste des membres du groupe $Group n'a pas été exporté"
                $Answer = ''
                }
            }
        }

    # Message à afficher en cas d'échec dans le bloc try.
    catch
        {
        Write-Warning "Le groupe $Group n'existe pas."
        }

    <#
    Interaction de nouvelle de recherche.
            Avertissement de l'erreur et réitération de la demande en cas de réponse invalide (autre que "o" (oui) et "n" (non)).
            Retour au bloc Try l.25 en cas de réponse positive.
    #>
    while ([String]::IsNullOrEmpty($Answer))
        {
        $Answer = Read-Host "Chercher un autre groupe ? (O/N)"
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

