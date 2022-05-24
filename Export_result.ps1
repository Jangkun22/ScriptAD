
Get-ADUser -filter * | Export-Csv e:\list_Users.txt
Get-ADGroup -filter * | Export-Csv e:\list_OU.txt
Get-WmiObject Win32_share | Export-Csv -Path E:\Share.txt
Get-Printer | Export-Csv -Path E:\Printer.txt
Get-GPOReport -All -ReportType Html -Path E:\GPO-All.html