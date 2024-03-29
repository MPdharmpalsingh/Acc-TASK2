# Set the minimum disk utilization threshold (e.g., 30%)
$DiskUtilization = 30

# Check disk utilization
$diskInfo = Get-WmiObject -Class Win32_LogicalDisk | Where-Object { $_.DriveType -eq 3 }
foreach ($disk in $diskInfo) {
    $freespace = [math]::Round(($disk.FreeSpace / $disk.Size) * 100, 2)
    Write-Host "disk free space is : "$freespace
    $storedspace=(100-$freespace)
    write-Host "full storage % is :" $storedspace
    if ($storedspace -gt $DiskUtilization) {
    Write-Host "WARNING : you need to delete some items from disk"
    }else{
    Write-Host "you can fill more items in disk"
    }

    #email send code 
   $EmailFrom = “dharmpal.singh33261@outlook.com”

   $EmailTo = “dharmpals47@gmail.com”

   $Subject = “Alert : Disk utilization Notification”

    $Body = "kindly check your disk"

    $SMTPServer = “smtp.outlook.com”

    $SMTPClient = New-Object Net.Mail.SmtpClient($SmtpServer, 587)

    $SMTPClient.EnableSsl = $true

    $SMTPClient.Credentials = New-Object System.Net.NetworkCredential(“dharmpal.singh33261@outlook.com”, “XXXXXX”);
    $SMTPClient.Send($EmailFrom, $EmailTo, $Subject, $Body)

    start-sleep -Seconds 10
}

