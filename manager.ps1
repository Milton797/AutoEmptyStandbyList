# Global variables
# -------------------------------------
$taskName = "EmptyStandbyList"
$destinationFolder = "C:\EmptyStandbyList"
$localRecources = ".\Resources\"
$onlineResources = "https://raw.githubusercontent.com/Milton797/AutoEmptyStandbyList/master/Resources/"

# Change console title
# -------------------------------------
$Host.UI.RawUI.WindowTitle = "Manage ScheduledTask to $taskName"

# Self-elevate the script
# -------------------------------------
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
    if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
        $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
        Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
        Exit
    }
}

# Change the current working directory to the location of the script file
# -------------------------------------
Set-Location -Path (Split-Path -Parent $MyInvocation.MyCommand.Path)

# Functions
# -------------------------------------
function Register-AutoEmptyStandbyList {
    New-Item -Path $destinationFolder -ItemType Directory -Force > $null
    if (Test-Path $localRecources -PathType Container) {
        Write-Host "Installing from offline resources."
        $content = Get-Content ($localRecources + "EmptyStandbyList.xml") | Out-String
        Copy-Item -Path ($localRecources + "EmptyStandbyList.exe") -Destination $destinationFolder -Force
    } else {
        Write-Host "Installing from online resources."
        $content = (New-Object System.Net.WebClient).DownloadString(($onlineResources + "EmptyStandbyList.xml")) | Out-String
        Invoke-WebRequest -Uri ($onlineResources + "EmptyStandbyList.exe") -OutFile ($destinationFolder + "\EmptyStandbyList.exe")
    }
    Register-ScheduledTask -TaskName "EmptyStandbyList" -Xml $content -Force > $null

    Write-Host "Task registered successfully."
}

function Unregister-AutoEmptyStandbyList {
    if (Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue) {
        Unregister-ScheduledTask -TaskName $taskName -Confirm:$False
        Remove-Item -Path $destinationFolder -Recurse -Force
        Write-Host "Task unregistered successfully."
    } else {
        Write-Host "The task '$taskName' does not exist."
    }
}

# Menu
# -------------------------------------
while ($true) {
    Clear-Host
    Write-Host "Menu:"
    Write-Host "[1] Register AutoEmptyStandbyList Task"
    Write-Host "[2] Unregister AutoEmptyStandbyList Task"
    Write-Host "[3] Quit"

    $choice = Read-Host "Enter a menu option"
    Clear-Host

    switch ($choice) {
        '1' { Register-AutoEmptyStandbyList }
        '2' { Unregister-AutoEmptyStandbyList }
        '3' { Write-Host "Exiting..." ; return }
        default { Write-Host "Invalid option. Please select a valid option." }
    }

    Write-Host "Press any key continue..."
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown').Key
}
