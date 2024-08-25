<#
.NOTES
    Version        : #{replaceme}
#>

param (
    [switch]$Debug
)

if ($Debug) {
    if (!(Test-Path -Path $ENV:TEMP)) {
        New-Item -ItemType Directory -Force -Path $ENV:TEMP
    }
    Start-Transcript $ENV:TEMP\winutil.log -Append
}

If (([Security.Principal.WindowsIdentity]::GetCurrent()).Owner.Value -ne "S-1-5-32-544") {
    Write-Host "===========================================" -Foregroundcolor Red
    Write-Host "-- Scripts must be run as Administrator ---" -Foregroundcolor Red
    Write-Host "-- Right-Click Start -> Terminal(Admin) ---" -Foregroundcolor Red
    Write-Host "===========================================" -Foregroundcolor Red
    break
}
