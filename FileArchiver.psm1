# Implement your module commands in this script.

function Add-ArchiveFile {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline=$true,Mandatory=$true)]
        [string[]]
        $File,
        [Parameter(Mandatory=$true)]
        [string]
        $ArchiveLocation
    )

    begin {
        $date = Get-Date
    }

    process {
        if (($File | Where-Object {Test-Path -Path $_ }).Count -eq 0){
            throw "Not all files passed exist"
        }
        $File | Get-Item | ForEach-Object {
            $baseName = $_.BaseName
            $extension = $_.Extension

            $destination = "$ArchiveLocation/$baseName-$($date.Year)-$($date.Month)-$($date.Day)$extension"

            Copy-Item $_ -Destination $destination
        }
    }

    end {
    }
}

function Remove-ArchiveFile {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline=$true,Mandatory=$true)]
        [string[]]
        $FileName,
        [Parameter(Mandatory=$true)]
        [string]
        $ArchiveLocation
    )

    begin {
    }

    process {
        $FileName | ForEach-Object {
            $extensionIndex = $_.LastIndexOf('.')
            if($extensionIndex -lt 0){
                $name = $_
                $extension = ''
            }else{
                $name = $_.Substring(0, $extensionIndex)
                $extension = $_.Substring($extensionIndex)
            }
            $matchString = "\A$name-([0-9]{4})-([0-9]{1,2})-([0-9]{1,2})$extension\Z"

            Get-ChildItem $ArchiveLocation -File | ForEach-Object {
                if($_ -match $matchString){
                    @{
                        File = $_
                        Date = Get-Date -Year $Matches[1] -Month $Matches[2] -Day $Matches[3]
                    }
                }
            }
        } | Where-Object {
            & "$PSScriptRoot/IsAllowedDate.ps1" -Date $_.Date
        } | ForEach-Object {
            Write-Host "Removing $($_.File.FullName)"
            Remove-Item $_.File.FullName
        }
    }

    end {
    }
}

# Export only the functions using PowerShell standard verb-noun naming.
# Be sure to list each exported functions in the FunctionsToExport field of the module manifest file.
# This improves performance of command discovery in PowerShell.
Export-ModuleMember -Function Add-ArchiveFile
Export-ModuleMember -Function Remove-ArchiveFile
