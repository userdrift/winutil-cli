function Invoke-WPFInstall {
    <#

   .SYNOPSIS
       

   .OUTPUTS
           
   
   #>

   # Import json file
   $_path = "$PSScriptRoot\..\..\config\input.json"
   $_raw = Get-Content -Path $_path -Raw | ConvertFrom-Json

    $tempPath = "$env:LOCALAPPDATA\Temp\winutil.ps1"

    # Create or clear winutil.ps1 in temp
    @"
Get-ChildItem -Path "$PSScriptRoot\functions\private\" | ForEach-Object { . `$_.FullName }
Get-ChildItem -Path "$PSScriptRoot\functions\public\" | ForEach-Object { . `$_.FullName }
"@ | Set-Content -Path $tempPath

    foreach ($_app in $_raw.PSObject.Properties) {
        Write-Host $($_app.Value.content)
        Write-Host ""
        Write-Host $($_app.Value.description)
        Write-Host ""
        $_input = Read-Host "[y/n]"

        if ($_input -eq 'y') {
            Add-Content -Path $tempPath -Value $($_app.Value.function)
        }
    }

    # Execute winutil.ps1
    & $tempPath
}