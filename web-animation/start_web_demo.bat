@echo off
REM ============================================================
REM  start_web_demo.bat - launch the three.js engagement animation
REM
REM  Starts a tiny local HTTP server (Python) and opens the page.
REM  (Browsers block ES-module loading over file:// - a local
REM   server is required.)
REM ============================================================

setlocal
cd /d "%~dp0"

set PORT=8137

where python >nul 2>nul
if errorlevel 1 (
  echo [ERROR] Python not found in PATH. Install Python 3 or run:
  echo         py -m http.server %PORT% --bind 127.0.0.1
  pause
  exit /b 1
)

echo Starting local server: http://127.0.0.1:%PORT%/
start "WebAnimation Server" /min cmd /c "python -m http.server %PORT% --bind 127.0.0.1"
ping -n 3 127.0.0.1 >nul

start "" "http://127.0.0.1:%PORT%/index.html"

echo.
echo Page opened. Close the minimized "WebAnimation Server"
echo window to stop the server.
endlocal
