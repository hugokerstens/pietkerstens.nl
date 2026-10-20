@echo off
cd /d "%~dp0"
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0scripts\preview.ps1"
if errorlevel 1 (
  echo.
  echo Preview could not start. Ask Codex to help using the message above.
  pause
)
