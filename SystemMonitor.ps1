<# 
    Script: SystemMonitor.ps1
    Description: Monitors CPU, Memory, Disk usage and top processes, exporting results to CSV and HTML.
    Author: chrisladzamach
    Version: 1.0
#>

$timestamp = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"

$outputDir = "$PSScriptRoot\Reports"
if (!(Test-Path $outputDir)) {
    New-Item -ItemType Directory -Path $outputDir | Out-Null
}

# --- CPU ---
$cpuLoad = Get-CimInstance Win32_Processor | Select-Object -ExpandProperty LoadPercentage
$cpuUsage = [math]::Round(($cpuLoad | Measure-Object -Average).Average,2)

# --- Memory ---
$memory = Get-CimInstance Win32_OperatingSystem
$totalMemory = [math]::Round($memory.TotalVisibleMemorySize/1MB,2)
$freeMemory = [math]::Round($memory.FreePhysicalMemory/1MB,2)
$usedMemory = $totalMemory - $freeMemory
$ramUsagePercent = [math]::Round(($usedMemory / $totalMemory) * 100,2)

# --- Discs ---
$disks = Get-PSDrive -PSProvider FileSystem | ForEach-Object {
    [PSCustomObject]@{
        Drive = $_.Name
        UsedGB = [math]::Round(($_.Used/1GB),2)
        FreeGB = [math]::Round(($_.Free/1GB),2)
        TotalGB = [math]::Round(($_.Used/1GB + $_.Free/1GB),2)
        UsagePercent = [math]::Round(($_.Used / ($_.Used + $_.Free))*100,2)
    }
}

# --- Processes with highest CPU ---
$topProcesses = Get-Process | Sort-Object CPU -Descending | Select-Object -First 5 `
    | Select-Object ProcessName, Id, CPU, PM

# --- CSV Report ---
$csvPath = "$outputDir\SystemReport_$timestamp.csv"
$reportObj = [PSCustomObject]@{
    Timestamp = $timestamp
    CPU_Usage = "$cpuUsage %"
    RAM_Usage = "$ramUsagePercent %"
    Total_RAM_GB = $totalMemory
    Used_RAM_GB = $usedMemory
}
$reportObj | Export-Csv -Path $csvPath -NoTypeInformation -Encoding UTF8

# Export CSV for each disk
$disks | Export-Csv -Path "$outputDir\Disks_$timestamp.csv" -NoTypeInformation -Encoding UTF8

# --- HTML Report ---
$htmlPath = "$outputDir\SystemReport_$timestamp.html"

$cpuHtml = "<h2>CPU Usage</h2><p>$cpuUsage %</p>"
$ramHtml = "<h2>RAM Usage</h2><p>$ramUsagePercent % ($usedMemory GB / $totalMemory GB)</p>"

$diskHtml = "<h2>Disk Usage</h2>" + ($disks | ConvertTo-Html -Property Drive, UsedGB, FreeGB, TotalGB, UsagePercent -Fragment)

$processHtml = "<h2>Top 5 Processes (by CPU)</h2>" + ($topProcesses | ConvertTo-Html -Property ProcessName, Id, CPU, PM -Fragment)

$htmlReport = @"
<html>
<head>
<title>System Report</title>
<style>
    body { font-family: Arial; margin: 20px; }
    h1 { color: #2b6cb0; }
    table { border-collapse: collapse; width: 80%; margin-bottom: 20px; }
    th, td { border: 1px solid #ccc; padding: 8px; text-align: center; }
    th { background-color: #2b6cb0; color: white; }
</style>
</head>
<body>
    <h1>System Report - $timestamp</h1>
    $cpuHtml
    $ramHtml
    $diskHtml
    $processHtml
</body>
</html>
"@

$htmlReport | Out-File -FilePath $htmlPath -Encoding UTF8

Write-Output "Report generated:"
Write-Output "CSV: $csvPath"
Write-Output "HTML: $htmlPath"
