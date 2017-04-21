param(
    # Parameter help description
    [Parameter(Mandatory=$true)]
    [Datetime]
    $Date,
    [Parameter()]
    [Datetime]
    $BaseDate = (Get-Date)
)
$currentQuarter = Get-Date -year $BaseDate.Year -Month ([Math]::Ceiling($BaseDate.Month /3) * 3 - 2) -Day 1
$currentYear = Get-Date -Year $BaseDate.Year -Month 1 -Day 1
$allowedDates = @(
    $BaseDate,
    $BaseDate.AddDays(-1),
    $BaseDate.AddDays(-2),
    $BaseDate.AddDays(-3),
    $BaseDate.AddDays(-4),
    $BaseDate.AddDays(-5),
    $BaseDate.AddDays(-6),
    $currentQuarter,
    $currentQuarter.AddMonths(-3),
    $currentQuarter.AddMonths(-6),
    $currentQuarter.AddMonths(-9)
)
if ($Date.Day -eq 1 -and $Date.Month -eq 1) {
    return $true
}

($allowedDates | Where-Object {
    $Date.Day -eq $_.Day -and $Date.Month -eq $_.Month -and $Date.Year -eq $_.Year
}).Count -gt 0