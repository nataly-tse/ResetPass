<#
    .DESCRIPTION
    Скрипт для сброса пароля пользователя на стандартный, требовать смену при первом входе
#>

# change before running
$stdpwd = "DefautlPassword"

Write-Host " RESET PASSWORD SCRIPT " -BackgroundColor White -ForegroundColor Black

$username = Read-Host `n"Enter the users lastname"

$userinfo = get-aduser -Filter "name -like '$username*'"
Write-Host $userinfo

$continue = Read-Host `n"Reset password for user (y/n)?"

if ($continue -eq "y") {
    Set-ADAccountPassword -identity $userinfo -NewPassword (ConvertTo-SecureString -AsPlainText $stdpwd -Force -Verbose) 
    Set-ADuser -Identity $userinfo -ChangePasswordAtLogon $true
    Write-Host `n"Password has been reset"
} else {
    Write-Host `n"Password has not change"
}

# users password info
Get-ADUser -Filter "name -like '$username*'" -Properties * | Select-Object name, UserPrincipalName, pass*

Pause
