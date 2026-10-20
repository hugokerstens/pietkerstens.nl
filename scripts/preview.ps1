$ErrorActionPreference = 'Stop'
Write-Host 'Preview: http://localhost:1313/ -- includes drafts. Keep this window open; Ctrl+C stops the preview.'
# Hugo opens the browser after startup. Keep the server in the foreground.
& (Join-Path $PSScriptRoot 'hugo.ps1') server --buildDrafts --openBrowser --bind 127.0.0.1 --port 1313 --baseURL http://localhost:1313/
