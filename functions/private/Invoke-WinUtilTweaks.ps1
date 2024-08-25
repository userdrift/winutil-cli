<#

   .SYNOPSIS
      Invokes the tweak functions
        
#>

param(
    $CheckBox
)

# Import tweaks file
$_path = "$PSScriptRoot\..\..\config\tweaks.json"
$_raw = Get-Content -Path $_path -Raw | ConvertFrom-Json

#===========================================================================
# Setup tweaks functions
#===========================================================================

# Disable Activity History
function Set-WPFTweaksAH {
    foreach ($_registry in $_raw.WPFTweaksAH.registry) {
        try {
            Set-WinUtilRegistry -Name $_registry.Name -Path $_registry.Path -Type $_registry.Type -Value $_registry.Value
        } catch {
            Write-Warning $($_.Exception.Message)
        }
    }
}

# Disable Hibernation
function Set-WPFTweaksHiber {
    foreach ($_registry in $_raw.WPFTweaksHiber.registry) {
        try {
            Set-WinUtilRegistry -Name $_registry.Name -Path $_registry.Path -Type $_registry.Type -Value $_registry.Value
        } catch {
            Write-Warning $($_.Exception.Message)
        }
    }

    foreach ($_array in $_raw.WPFTweaksHiber.InvokeScript) {
        try {
            $_InvokeScript = [scriptblock]::Create($_array)
            Invoke-WinUtilScript -ScriptBlock $_InvokeScript -Name "WPFTweaksHiber"
        }
        catch {
            Write-Warning $($_.Exception.Message)
        }
    }
}

# Set Hibernation as default (good for laptops)
function Set-WPFTweaksLaptopHibernation {
    foreach ($_registry in $_raw.WPFTweaksLaptopHibernation.registry) {
        try {
            Set-WinUtilRegistry -Name $_registry.Name -Path $_registry.Path -Type $_registry.Type -Value $_registry.Value
        } catch {
            Write-Warning $($_.Exception.Message)
        }
    }

    foreach ($_array in $_raw.WPFTweaksLaptopHibernation.InvokeScript) {
        try {
            $_InvokeScript = [scriptblock]::Create($_array)
            Invoke-WinUtilScript -ScriptBlock $_InvokeScript -Name "WPFTweaksLaptopHibernation"
        }
        catch {
            Write-Warning $($_.Exception.Message)
        }
    }
}

# Disable Homegroup
function Set-WPFTweaksHome {
    foreach ($_service in $_raw.WPFTweaksHome.service) {
        try {
        if (Get-Service -Name $_service.Name -ErrorAction SilentlyContinue) {
            Set-WinUtilService -Name $_service.Name -StartupType $_service.StartupType
        } else {
            Write-Warning "Service $($_service.Name) was not found"
        }
        } catch {
            Write-Warning $($_.Exception.Message)
        }
    }
}

# Disable Location Tracking
function Set-WPFTweaksLoc {
    foreach ($_registry in $_raw.WPFTweaksLoc.registry) {
        try {
            Set-WinUtilRegistry -Name $_registry.Name -Path $_registry.Path -Type $_registry.Type -Value $_registry.Value
        } catch {
            Write-Warning $($_.Exception.Message)
        }
    }
}

# Set Services to Manual
function Set-WPFTweaksServices {
    foreach ($_service in $_raw.WPFTweaksServices.service) {
        if (Get-Service -Name $_service.Name -ErrorAction SilentlyContinue) {
            try {
                Set-WinUtilService -Name $_service.Name -StartupType $_service.StartupType
            } catch {
                Write-Warning "StartupType $($_service.StartupType) was not found"
            }
        } else {
            Write-Warning "Service $($_service.Name) was not found"
        }
    }
}

# Debloat Edge
function Set-WPFTweaksEdgeDebloat {
    foreach ($_registry in $_raw.WPFTweaksEdgeDebloat.registry) {
        try {
            Set-WinUtilRegistry -Name $_registry.Name -Path $_registry.Path -Type $_registry.Type -Value $_registry.Value
        } catch {
            Write-Warning $($_.Exception.Message)
        }
    }
}

# Disable ConsumerFeatures
function Set-WPFTweaksConsumerFeatures {
    foreach ($_registry in $_raw.WPFTweaksConsumerFeatures.registry) {
        try {
            Set-WinUtilRegistry -Name $_registry.Name -Path $_registry.Path -Type $_registry.Type -Value $_registry.Value
        } catch {
            Write-Warning $($_.Exception.Message)
        }
    }
}

# Disable Telemetry.
function Set-WPFTweaksTele {
    foreach ($_registry in $_raw.WPFTweaksTele.registry) {
        try {
            Set-WinUtilRegistry -Name $_registry.Name -Path $_registry.Path -Type $_registry.Type -Value $_registry.Value
        } catch {
            Write-Warning $($_.Exception.Message)
        }
    }

    foreach ($_scheduledtask in $_raw.WPFTweaksTele.ScheduledTask) {
        try {
            Set-WinUtilScheduledTask -Name  $_scheduledtask.Name -State  $_scheduledtask.State
        }
        catch {
            Write-Warning $($_.Exception.Message)
        }
    }

    foreach ($_array in $_raw.WPFTweaksTele.InvokeScript) {
        try {
            $_InvokeScript = [scriptblock]::Create($_array)
            Invoke-WinUtilScript -ScriptBlock $_InvokeScript -Name "WPFTweaksTele"
        }
        catch {
            Write-Warning $($_.Exception.Message)
        }
    }
}

# Disable Wifi-Sense
function Set-WPFTweaksWifi {
    foreach ($_registry in $_raw.WPFTweaksWifi.registry) {
        try {
            Set-WinUtilRegistry -Name $_registry.Name -Path $_registry.Path -Type $_registry.Type -Value $_registry.Value
        } catch {
            Write-Warning $($_.Exception.Message)
        }
    }
}

# Set Time to UTC (Dual Boot)
function Set-WPFTweaksUTC {
    foreach ($_registry in $_raw.WPFTweaksUTC.registry) {
        try {
            Set-WinUtilRegistry -Name $_registry.Name -Path $_registry.Path -Type $_registry.Type -Value $_registry.Value
        } catch {
            Write-Warning $($_.Exception.Message)
        }
    }
}

# Remove Home and Gallery from explorer
function Set-WPFTweaksRemoveHomeGallery {
    foreach ($_array in $_raw.WPFTweaksRemoveHomeGallery.InvokeScript) {
        try {
            $_InvokeScript = [scriptblock]::Create($_array)
            Invoke-WinUtilScript -ScriptBlock $_InvokeScript -Name "WPFTweaksRemoveHomeGallery"
        }
        catch {
            Write-Warning $($_.Exception.Message)
        }
    }
}

# Set Display for Performance
function Set-WPFTweaksDisplay {
    foreach ($_registry in $_raw.WPFTweaksDisplay.registry) {
        try {
            Set-WinUtilRegistry -Name $_registry.Name -Path $_registry.Path -Type $_registry.Type -Value $_registry.Value
        } catch {
            Write-Warning $($_.Exception.Message)
        }
    }

    foreach ($_array in $_raw.WPFTweaksDisplay.InvokeScript) {
        try {
            $_InvokeScript = [scriptblock]::Create($_array)
            Invoke-WinUtilScript -ScriptBlock $_InvokeScript -Name "WPFTweaksDisplay"
        }
        catch {
            Write-Warning $($_.Exception.Message)
        }
    }
}

# Remove ALL MS Store Apps - NOT RECOMMENDED
function Set-WPFTweaksDeBloat {
    foreach ($_appx in $_raw.WPFTweaksDeBloat.appx) {
        try {
           Remove-WinUtilAPPX -Name "$_appx"
        }
        catch {
           Write-Warning "Package $($_appx.Name) was not found"
        }
    }

    foreach ($_array in $_raw.WPFTweaksDeBloat.InvokeScript) {
        try {
            $_InvokeScript = [scriptblock]::Create($_array)
            Invoke-WinUtilScript -ScriptBlock $_InvokeScript -Name "WPFTweaksDeBloat"
        }
        catch {
            Write-Warning $($_.Exception.Message)
        }
    }
}

# Create Restore Point
function Set-WPFTweaksRestorePoint {
    foreach ($_array in $_raw.WPFTweaksRestorePoint.InvokeScript) {
        try {
            $_InvokeScript = [scriptblock]::Create($_array)
            Invoke-WinUtilScript -ScriptBlock $_InvokeScript -Name "WPFTweaksRestorePoint"
        }
        catch {
            Write-Warning $($_.Exception.Message)
        }
    }
}

# Enable End Task With Right Click
function Set-WPFTweaksEndTaskOnTaskbar {
    foreach ($_array in $_raw.WPFTweaksEndTaskOnTaskbar.InvokeScript) {
        try {
            $_InvokeScript = [scriptblock]::Create($_array)
            Invoke-WinUtilScript -ScriptBlock $_InvokeScript -Name "WPFTweaksEndTaskOnTaskbar"
        }
        catch {
            Write-Warning $($_.Exception.Message)
        }
    }
}

# Change Windows Terminal default: PowerShell 5 -> PowerShell 7
function Set-WPFTweaksPowershell7 {
    foreach ($_array in $_raw.WPFTweaksPowershell7.InvokeScript) {
        try {
            $_InvokeScript = [scriptblock]::Create($_array)
            Invoke-WinUtilScript -ScriptBlock $_InvokeScript -Name "WPFTweaksPowershell7"
        }
        catch {
            Write-Warning $($_.Exception.Message)
        }
    }
}

# Disable Powershell 7 Telemetry
function Set-WPFTweaksPowershell7Tele {
    foreach ($_array in $_raw.WPFTweaksPowershell7Tele.InvokeScript) {
        try {
            $_InvokeScript = [scriptblock]::Create($_array)
            Invoke-WinUtilScript -ScriptBlock $_InvokeScript -Name "WPFTweaksPowershell7Tele"
        }
        catch {
            Write-Warning $($_.Exception.Message)
        }
    }
}

# Disable Storage Sense
function Set-WPFTweaksStorage {
    foreach ($_array in $_raw.WPFTweaksStorage.InvokeScript) {
        try {
            $_InvokeScript = [scriptblock]::Create($_array)
            Invoke-WinUtilScript -ScriptBlock $_InvokeScript -Name "WPFTweaksStorage"
        }
        catch {
            Write-Warning $($_.Exception.Message)
        }
    }
}

# Remove Microsoft Edge
function Set-WPFTweaksRemoveEdge {
    foreach ($_array in $_raw.WPFTweaksRemoveEdge.InvokeScript) {
        try {
            $_InvokeScript = [scriptblock]::Create($_array)
            Invoke-WinUtilScript -ScriptBlock $_InvokeScript -Name "WPFTweaksRemoveEdge"
        }
        catch {
            Write-Warning $($_.Exception.Message)
        }
    }
}

# Disable Microsoft Copilot
function Set-WPFTweaksRemoveCopilot {
    foreach ($_registry in $_raw.WPFTweaksRemoveCopilot.registry) {
        try {
            Set-WinUtilRegistry -Name $_registry.Name -Path $_registry.Path -Type $_registry.Type -Value $_registry.Value
        } catch {
            Write-Warning $($_.Exception.Message)
        }
    }

    foreach ($_array in $_raw.WPFTweaksRemoveCopilot.InvokeScript) {
        try {
            $_InvokeScript = [scriptblock]::Create($_array)
            Invoke-WinUtilScript -ScriptBlock $_InvokeScript -Name "WPFTweaksRemoveCopilot"
        }
        catch {
            Write-Warning $($_.Exception.Message)
        }
    }
}

# Disable Intel MM (vPro LMS)
function Set-WPFTweaksDisableLMS1 {
    foreach ($_array in $_raw.WPFTweaksDisableLMS1.InvokeScript) {
        try {
            $_InvokeScript = [scriptblock]::Create($_array)
            Invoke-WinUtilScript -ScriptBlock $_InvokeScript -Name "WPFTweaksDisableLMS1"
        }
        catch {
            Write-Warning $($_.Exception.Message)
        }
    }
}

# Remove OneDrive
function Set-WPFTweaksRemoveOnedrive {
    foreach ($_array in $_raw.WPFTweaksRemoveOnedrive.InvokeScript) {
        try {
            $_InvokeScript = [scriptblock]::Create($_array)
            Invoke-WinUtilScript -ScriptBlock $_InvokeScript -Name "WPFTweaksRemoveOnedrive"
        }
        catch {
            Write-Warning $($_.Exception.Message)
        }
    }
}

# Disable Notification Tray/Calendar
function Set-WPFTweaksDisableNotifications {
    foreach ($_registry in $_raw.WPFTweaksDisableNotifications.registry) {
        try {
            Set-WinUtilRegistry -Name $_registry.Name -Path $_registry.Path -Type $_registry.Type -Value $_registry.Value
        } catch {
            Write-Warning $($_.Exception.Message)
        }
    }
}

# Set Classic Right-Click Menu
function Set-WPFTweaksRightClickMenu {
    foreach ($_array in $_raw.WPFTweaksRightClickMenu.InvokeScript) {
        try {
            $_InvokeScript = [scriptblock]::Create($_array)
            Invoke-WinUtilScript -ScriptBlock $_InvokeScript -Name "WPFTweaksRightClickMenu"
        }
        catch {
            Write-Warning $($_.Exception.Message)
        }
    }
}

# Run Disk Cleanup
function Set-WPFTweaksDiskCleanup {
    foreach ($_array in $_raw.WPFTweaksDiskCleanup.InvokeScript) {
        try {
            $_InvokeScript = [scriptblock]::Create($_array)
            Invoke-WinUtilScript -ScriptBlock $_InvokeScript -Name "WPFTweaksDiskCleanup"
        }
        catch {
            Write-Warning $($_.Exception.Message)
        }
    }
}

# Delete Temporary Files
function Set-WPFTweaksDeleteTempFiles {
    foreach ($_array in $_raw.WPFTweaksDeleteTempFiles.InvokeScript) {
        try {
            $_InvokeScript = [scriptblock]::Create($_array)
            Invoke-WinUtilScript -ScriptBlock $_InvokeScript -Name "WPFTweaksDeleteTempFiles"
        }
        catch {
            Write-Warning $($_.Exception.Message)
        }
    }
}

# Disable GameDVR
function Set-WPFTweaksDVR {
    foreach ($_registry in $_raw.WPFTweaksDVR.registry) {
        try {
            Set-WinUtilRegistry -Name $_registry.Name -Path $_registry.Path -Type $_registry.Type -Value $_registry.Value
        } catch {
            Write-Warning $($_.Exception.Message)
        }
    }
}

# Disable Teredo
function Set-WPFTweaksTeredo {
    foreach ($_registry in $_raw.WPFTweaksTeredo.registry) {
        try {
            Set-WinUtilRegistry -Name $_registry.Name -Path $_registry.Path -Type $_registry.Type -Value $_registry.Value
        } catch {
            Write-Warning $($_.Exception.Message)
        }
    }

    foreach ($_array in $_raw.WPFTweaksTeredo.InvokeScript) {
        try {
            $_InvokeScript = [scriptblock]::Create($_array)
            Invoke-WinUtilScript -ScriptBlock $_InvokeScript -Name "WPFTweaksTeredo"
        }
        catch {
            Write-Warning $($_.Exception.Message)
        }
    }
}

# Disable IPv6
function Set-WPFTweaksDisableipsix {
    foreach ($_registry in $_raw.WPFTweaksDisableipsix.registry) {
        try {
            Set-WinUtilRegistry -Name $_registry.Name -Path $_registry.Path -Type $_registry.Type -Value $_registry.Value
        } catch {
            Write-Warning $($_.Exception.Message)
        }
    }

    foreach ($_array in $_raw.WPFTweaksDisableipsix.InvokeScript) {
        try {
            $_InvokeScript = [scriptblock]::Create($_array)
            Invoke-WinUtilScript -ScriptBlock $_InvokeScript -Name "WPFTweaksDisableipsix"
        }
        catch {
            Write-Warning $($_.Exception.Message)
        }
    }
}

# Disable Background Apps
function Set-WPFTweaksDisableBGapps {
    foreach ($_registry in $_raw.WPFTweaksDisableBGapps.registry) {
        try {
            Set-WinUtilRegistry -Name $_registry.Name -Path $_registry.Path -Type $_registry.Type -Value $_registry.Value
        } catch {
            Write-Warning $($_.Exception.Message)
        }
    }
}

# Disable Fullscreen Optimizations
function Set-WPFTweaksDisableFSO {
    foreach ($_registry in $_raw.WPFTweaksDisableFSO.registry) {
        try {
            Set-WinUtilRegistry -Name $_registry.Name -Path $_registry.Path -Type $_registry.Type -Value $_registry.Value
        } catch {
            Write-Warning $($_.Exception.Message)
        }
    }
}
