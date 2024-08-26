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
    Start-Transcript $ENV:TEMP\winutil.log -Append -Force
}

If (([Security.Principal.WindowsIdentity]::GetCurrent()).Owner.Value -ne "S-1-5-32-544") {
    Write-Host "===========================================" -Foregroundcolor Red
    Write-Host "-- Scripts must be run as Administrator ---" -Foregroundcolor Red
    Write-Host "-- Right-Click Start -> Terminal(Admin) ---" -Foregroundcolor Red
    Write-Host "===========================================" -Foregroundcolor Red
    break
}

# SPDX-License-Identifier: MIT
# Dot-source every private function
Get-ChildItem -Path "$PSScriptRoot\..\functions\private\" | ForEach-Object { . $_.FullName }
# Dot-source every public function
Get-ChildItem -Path "$PSScriptRoot\..\functions\public\" | ForEach-Object { . $_.FullName }

# $path_ = "$PSScriptRoot\..\config\toggle.json"
# $raw_ = Get-Content -Path $path_ -Raw | ConvertFrom-Json

#===========================================================================
# Setup toggles
#===========================================================================

<#
   Invoke-WinUtilDarkMode -DarkMoveEnabled $false (enable darkmode)
   Invoke-WinUtilDarkMode -DarkMoveEnabled $true (disable darkmode)

   Invoke-WinUtilBingSearch -Enabled $false (enables bing search)
   Invoke-WinUtilBingSearch -Enabled $true (disable bing search)

   Invoke-WinUtilNumLock -Enabled $false (enables num lock on startup)
   Invoke-WinUtilNumLock -Enabled $true (disable num lock on startup)

   Invoke-WinUtilVerboseLogon -Enabled $false (enables verbose log on messages)
   Invoke-WinUtilVerboseLogon -Enabled $true (disable verbose log on messages)

   Invoke-WinUtilSnapWindow -Enabled $false (enables Snapping Windows on startup)
   Invoke-WinUtilSnapWindow -Enabled $true (disables Snapping Windows on startup)

   Invoke-WinUtilSnapFlyout -Enabled $false (enables Snap Assist Flyout on startup)
   Invoke-WinUtilSnapFlyout -Enabled $true (disables Snap Assist Flyout on startup)

   Invoke-WinUtilSnapSuggestion -Enabled $false (enables Snap Assist Suggestions on startup)
   Invoke-WinUtilSnapSuggestion -Enabled $true (disables Snap Assist Suggestions on startup)

   Invoke-WinUtilMouseAcceleration -DarkMoveEnabled $MouseAccelerationEnabled $false (enables mouse acceleration)
   Invoke-WinUtilMouseAcceleration -DarkMoveEnabled $MouseAccelerationEnabled $true (disables mouse acceleration)

   Invoke-WinUtilStickyKeys -Enabled $false (enables Sticky Keys on startup)
   Invoke-WinUtilStickyKeys -Enabled $true (disables Sticky Keys on startup)

   Invoke-WinUtilHiddenFiles -Enabled $false (enables Hidden Files)
   Invoke-WinUtilHiddenFiles -Enabled $true (disables Hidden Files)

   Invoke-WinUtilShowExt -Enabled $false (enables Show file Extentions)
   Invoke-WinUtilShowExt -Enabled $true (disables Show file Extentions)

   Invoke-WinUtilTaskbarSearch -Enabled $false (enables Taskbar Search Button)
   Invoke-WinUtilTaskbarSearch -Enabled $true (disables Taskbar Search Button)

   Invoke-WinUtilTaskView -Enabled $false (enables Task View)
   Invoke-WinUtilTaskView -Enabled $true (disables Task View)

   Invoke-WinUtilTaskbarWidgets -Enabled $false (enables Taskbar Widgets)
   Invoke-WinUtilTaskbarWidgets -Enabled $true (disables Taskbar Widgets)

   Invoke-WinUtilTaskbarAlignment -Enabled $false (enables Left Taskbar Alignment)
   Invoke-WinUtilTaskbarAlignment -Enabled $true (disables Left Taskbar Alignment)

   Invoke-WinUtilDetailedBSoD -Enabled $false (enables Detailed BSoD)
   Invoke-WinUtilDetailedBSoD -Enabled $true (disables Detailed BSoD)

   Invoke-WinUtilDetailedBSoD -Enabled $false (enables Detailed BSoD)
   Invoke-WinUtilDetailedBSoD -Enabled $true (disables Detailed BSoD)

   Set-WinUtilDNS -DNSProvider "" (set a dns provider ex:Google, Cloudflare)

   Invoke-WPFUpdatessecurity (recommended Defers feature updates for 365 days Defers quality updates for 4 days)

   Invoke-WPFUpdatesdisable (Disables Windows Update)

   Invoke-WPFUpdatesdefault (Resets Windows Update settings to default)

   Invoke-WPFUltimatePerformance -State "Enable" (enable Ultimate Performance power scheme)
   Invoke-WPFUltimatePerformance -State "Disable" (disable Ultimate Performance power scheme)

   Invoke-WPFInstall (install a selected app)
#>
Invoke-WePFInstall