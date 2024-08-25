function Invoke-WPFInstall {
     <#

    .SYNOPSIS
        This function will install a selected application

    .OUTPUTS
            For example: 
            
            FirefoxESR
            Mozilla Firefox is an open-source web browser known for its customization options, privacy features, and extensions. Firefox ESR (Extended Support Release) receives major updates every 42 weeks with minor updates such as crash fixes, security fixes and policy updates as needed, but at least every four weeks.

            [y/n]:
    
    #>

    # Import json file
    $_path = "$PSScriptRoot\..\..\config\applications.json"
    $_raw = Get-Content -Path $_path -Raw | ConvertFrom-Json

    $_appindex = $_raw.PSObject.Properties.Count
    $appindex_ = 0

    # For each application prompt user
    foreach ($app_ in $_raw.PSObject.Properties) {
        $currentAppIndex++

        $_app = $app_.Name
        $_app = $app_.Value
        do {
        Write-Host $($_app.choco)
        Write-Host ""
        Write-Host $($_app.description)
        Write-Host ""
        $_input = Read-Host "[y/n]"

        if ($_input -eq 'y') {
            Start-Process $_app.link
            if ($appindex_ -eq $_appindex) {
                return
            }
            break
        }
        elseif ($_input -eq 'n') {
            Write-Host ""
            break
        }
        else {
            Write-Host ""
        }
        if (($_input -eq 'n' -or $_input -notin 'y','n') -and $app_ -eq $_raw.PSObject.Properties[-1]) {
            return
        }
        } while ($true)
    }
}
