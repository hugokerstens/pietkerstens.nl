param([Parameter(ValueFromRemainingArguments = $true)][string[]]$HugoArguments)
$ErrorActionPreference = 'Stop'
$projectRoot = Split-Path $PSScriptRoot -Parent
$version = (Get-Content (Join-Path $projectRoot '.hugo-version') -Raw).Trim()
$architecture = if ($env:PROCESSOR_ARCHITECTURE -eq 'ARM64' -or $env:PROCESSOR_ARCHITEW6432 -eq 'ARM64') { 'arm64' } else { 'amd64' }
$toolDirectory = Join-Path $projectRoot ".tools/hugo/$version-windows-$architecture"
$executable = Join-Path $toolDirectory 'hugo.exe'
if (!(Test-Path $executable)) {
    New-Item -ItemType Directory -Force -Path $toolDirectory | Out-Null
    $archiveName = "hugo_${version}_windows-$architecture.zip"
    $archive = Join-Path $toolDirectory $archiveName
    $checksumLine = Get-Content (Join-Path $PSScriptRoot 'hugo-checksums.txt') | Where-Object { $_.EndsWith("  $archiveName") }
    if (!$checksumLine) { throw "No pinned checksum for $archiveName" }
    $expected = ($checksumLine -split '\s+')[0]
    Write-Host "Downloading site builder $version (first run only)..."
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    Invoke-WebRequest -UseBasicParsing -Uri "https://github.com/gohugoio/hugo/releases/download/v$version/$archiveName" -OutFile $archive
    if ((Get-FileHash $archive -Algorithm SHA256).Hash.ToLowerInvariant() -ne $expected) {
        throw 'Site builder checksum verification failed. Download was not extracted.'
    }
    Expand-Archive -Path $archive -DestinationPath $toolDirectory -Force
}
Push-Location $projectRoot
$previousCacheDirectory = $env:HUGO_CACHEDIR
try {
    $env:HUGO_CACHEDIR = Join-Path $projectRoot '.tools/cache'
    & $executable @HugoArguments
    if ($LASTEXITCODE -ne 0) { throw "Site builder exited with code $LASTEXITCODE" }
} finally {
    $env:HUGO_CACHEDIR = $previousCacheDirectory
    Pop-Location
}
