@echo off
:: Ensure the script is running with administrative privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] ERROR: Please right-click and "Run as Administrator".
    pause
    exit /b
)

echo [*] Pre-accepting Sysinternals EULAs for Current User...
reg add "HKCU\Software\Sysinternals\Process Explorer" /v EulaAccepted /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Sysinternals\Autoruns" /v EulaAccepted /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Sysinternals\Process Monitor" /v EulaAccepted /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Sysinternals\PsExec" /v EulaAccepted /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Sysinternals\TCPView" /v EulaAccepted /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Sysinternals\Sigcheck" /v EulaAccepted /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Sysinternals\Sysmon" /v EulaAccepted /t REG_DWORD /d 1 /f >nul

echo [*] Pre-accepting Sysinternals EULAs System-Wide (HKLM)...
reg add "HKLM\Software\Sysinternals\Process Explorer" /v EulaAccepted /t REG_DWORD /d 1 /f >nul
reg add "HKLM\Software\Sysinternals\Autoruns" /v EulaAccepted /t REG_DWORD /d 1 /f >nul
reg add "HKLM\Software\Sysinternals\Process Monitor" /v EulaAccepted /t REG_DWORD /d 1 /f >nul
reg add "HKLM\Software\Sysinternals\PsExec" /v EulaAccepted /t REG_DWORD /d 1 /f >nul
reg add "HKLM\Software\Sysinternals\TCPView" /v EulaAccepted /t REG_DWORD /d 1 /f >nul
reg add "HKLM\Software\Sysinternals\Sigcheck" /v EulaAccepted /t REG_DWORD /d 1 /f >nul
reg add "HKLM\Software\Sysinternals\Sysmon" /v EulaAccepted /t REG_DWORD /d 1 /f >nul

echo [+] Done! All EULAs accepted. No popups will interrupt you.
timeout /t 3
