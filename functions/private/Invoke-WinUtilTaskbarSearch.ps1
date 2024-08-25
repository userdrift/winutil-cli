function Invoke-WinUtilTaskbarSearch {
    <#

    .SYNOPSIS
        Enable Disable Taskbar Search Button.

    .PARAMETER Enabled
        Enable disable Taskbar Search Button.

    #>
    Param($Enabled)
    try {
        if ($Enabled -eq $false) {
            Write-Host "Enabling Search Button"
            $_value = 1
        } else {
            Write-Host "Disabling Search Button"
            $_value = 0
        }
        $_Path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search\"
        Set-ItemProperty -Path $_Path -Name SearchboxTaskbarMode -Value $_value
    } catch [System.Security.SecurityException] {
        Write-Warning "Unable to set $_Path\$name_ to $_value due to a Security Exception"
    } catch [System.Management.Automation.ItemNotFoundException] {
        Write-Warning $psitem.Exception.ErrorRecord
    } catch {
        Write-Warning "Unable to set $name_ due to unhandled exception"
        Write-Warning $psitem.Exception.StackTrace
    }
}
