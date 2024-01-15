$ServerInstance = "backups"
$DatabaseName = "rimi_kristoferjurgenstein.sql"
$BackupDir = "C:\users\backups\databases"
$BackupFile = "${BackupDir}\${DatabaseName}"

$T = @{
  Frequency="Daily"
  At="4:00AM"
}
$O = @{
  WakeToRun=$true
  StartIfNotIdle=$false
  MultipleInstancePolicy="Queue"
}
Register-ScheduledJob -Trigger $T -ScheduledJobOption $O -scriptblock {
    mysqldump -u root -pPassw0rd rimi-database > $DatabaseName
    pscp -pw Passw0rd $DatabaseName backups@172.18.24.8:$BackupFile
}