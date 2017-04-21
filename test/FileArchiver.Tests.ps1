$ModuleManifestName = 'FileArchiver.psd1'
$ModuleManifestPath = "$PSScriptRoot\..\$ModuleManifestName"

Describe 'Module Manifest Tests' {
    It 'Passes Test-ModuleManifest' {
        Test-ModuleManifest -Path $ModuleManifestPath
        $? | Should Be $true
    }
}

Import-Module $ModuleManifestPath

Describe 'Add-ArchiveFile' {
    It 'Throws an exception if a file does not exist' {
        { @("Z:\unknownFile.txt") | Add-ArchiveFile -ArchiveLocation "C:\Test" } | Should Throw "Not all files passed exist"
    }
}

Remove-Module FileArchiver