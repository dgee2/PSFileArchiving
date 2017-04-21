$baseDate = Get-Date -Year 2017 -Month 9 -Day 6
Describe "IsAllowedDate"{
    It "Returns true for a date on the first day of the year"{
        & "$PSScriptRoot/../IsAllowedDate.ps1" -Date (Get-Date -Year 2017 -Month 1 -Day 1) -BaseDate $baseDate | should be $true
    }
    It "Returns false for a date on the second day of the year"{
        & "$PSScriptRoot/../IsAllowedDate.ps1" -Date (Get-Date -Year 2017 -Month 1 -Day 2) -BaseDate $baseDate | should be $false
    }
    It "Returns true for a date that is today"{
        & "$PSScriptRoot/../IsAllowedDate.ps1" -Date (Get-Date -Year 2017 -Month 9 -Day 6) -BaseDate $baseDate | should be $true
    }
    It "Returns true for a date that is yesterday"{
        & "$PSScriptRoot/../IsAllowedDate.ps1" -Date (Get-Date -Year 2017 -Month 9 -Day 5) -BaseDate $baseDate | should be $true
    }
    It "Returns true for a date that is 2 days ago"{
        & "$PSScriptRoot/../IsAllowedDate.ps1" -Date (Get-Date -Year 2017 -Month 9 -Day 4) -BaseDate $baseDate | should be $true
    }
    It "Returns true for a date that is 3 days ago"{
        & "$PSScriptRoot/../IsAllowedDate.ps1" -Date (Get-Date -Year 2017 -Month 9 -Day 3) -BaseDate $baseDate | should be $true
    }
    It "Returns true for a date that is 4 days ago"{
        & "$PSScriptRoot/../IsAllowedDate.ps1" -Date (Get-Date -Year 2017 -Month 9 -Day 2) -BaseDate $baseDate | should be $true
    }
    It "Returns true for a date that is 5 days ago"{
        & "$PSScriptRoot/../IsAllowedDate.ps1" -Date (Get-Date -Year 2017 -Month 9 -Day 1) -BaseDate $baseDate | should be $true
    }
    It "Returns true for a date that is 6 days ago"{
        & "$PSScriptRoot/../IsAllowedDate.ps1" -Date (Get-Date -Year 2017 -Month 8 -Day 31) -BaseDate $baseDate | should be $true
    }
    It "Returns false for a date that is 7 days ago"{
        & "$PSScriptRoot/../IsAllowedDate.ps1" -Date (Get-Date -Year 2017 -Month 8 -Day 30) -BaseDate $baseDate | should be $false
    }
    It "Returns true for a date that is the start of the current quarter"{
        & "$PSScriptRoot/../IsAllowedDate.ps1" -Date (Get-Date -Year 2017 -Month 7 -Day 1) -BaseDate $baseDate | should be $true
    }
    It "Returns true for a date that is the start of the previous quarter"{
        & "$PSScriptRoot/../IsAllowedDate.ps1" -Date (Get-Date -Year 2017 -Month 4 -Day 1) -BaseDate $baseDate | should be $true
    }
    It "Returns true for a date that is the start of the quarter 2 quarters ago"{
        & "$PSScriptRoot/../IsAllowedDate.ps1" -Date (Get-Date -Year 2017 -Month 1 -Day 1) -BaseDate $baseDate | should be $true
    }
    It "Returns true for a date that is the start of the quarter 3 quarters ago"{
        & "$PSScriptRoot/../IsAllowedDate.ps1" -Date (Get-Date -Year 2016 -Month 10 -Day 1) -BaseDate $baseDate | should be $true
    }
}