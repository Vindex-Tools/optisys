# optisys (Windows Sysinternals Survival Kit)

## Overview
This repository contains a streamlined, offline-ready deployment folder designed for rapid Windows defense under active Red Team conditions. All tools are pre-staged static binaries optimized for 100% offline, air-gapped usability during Red v Blue Competitions.

## Directory Structure
```text
optisys/
├── autoeula.bat  (EULA automation script - Batch)
├── x64/          (64-bit tools)
│   ├── Autoruns64.exe
│   ├── procexp64.exe
│   ├── Procmon64.exe
│   ├── PsExec64.exe    (CLI ONLY)
│   ├── sigcheck64.exe  (CLI ONLY)
│   └── tcpview64.exe
└── x86/          (32-bit tools)
    ├── Autoruns.exe
    ├── procexp.exe
    ├── Procmon.exe
    ├── PsExec.exe      (CLI ONLY)
    ├── sigcheck.exe    (CLI ONLY)
    └── tcpview.exe
```

> [!NOTE]
> The two compressed archives (`optisys_x64_compressed.zip` and `optisys_x86_compressed.zip`) are meant for quick deployment and use directly within target environments. They contain only `autoeula.bat` and their corresponding architecture-specific programs to minimize payload transfer size.

## The Core Arsenal

| Tool | Executable | Interface | Primary Blue Team Use Case & Quick Reference |
| :--- | :--- | :--- | :--- |
| **Process Explorer** | `procexp.exe` / `procexp64.exe` | **GUI** | It shows a deep, live view of all running programs, the files they lock, and the system resources they use. |
| **Autoruns** | `Autoruns.exe` / `Autoruns64.exe` | **GUI** | It shows every single program, driver, scheduled task, and service configured to run automatically when your Windows computer boots up or you log in. |
| **TCPView** | `tcpview.exe` / `tcpview64.exe` | **GUI** | It displays active TCP and UDP connections in real time, shows which program owns each connection. Easy live network mapping to trace persistent high-port C2 beacons back to their originating PIDs. |
| **Process Monitor** | `Procmon.exe` / `Procmon64.exe` | **GUI** | Deep file system and registry triage. <br>**Warning**: *Must apply strict process filters immediately to prevent UI lag and memory exhaustion.* |
| **PsExec** | `PsExec.exe` / `PsExec64.exe` | **CLI** | CLI utility to spawn an elevated shell. Execute `PsExec64.exe -sid cmd.exe` to obtain a shell running as `NT AUTHORITY\SYSTEM`. |
| **Sigcheck** | `sigcheck.exe` / `sigcheck64.exe` | **CLI** | Signature validation tool. Execute `sigcheck64.exe -e -u C:\Windows\System32` to scan for unsigned binaries and anomalous code. |
| **Sysmon** | `sysmon64.exe` (Remote Deployment) | **CLI / Service** |  It logs deep, detailed activity about processes, network connections, and file changes directly to the Windows Event Log to help find malware and security threats. |

## Setup Instructions (Quick-Start Guide)

> [!IMPORTANT]
> All tools are pre-staged static binaries for 100% offline, air-gapped usability. No internet connectivity or external downloads are required.

### Step 1: Open an Elevated Shell
Open an elevated Command Prompt or PowerShell (run as **Administrator**).

### Step 2: Bypass EULA Popups OPTIONAL 
Execute `autoeula.bat` from an elevated shell **BEFORE** launching any utilities. 

This script automates system-wide EULA acceptance (HKCU & HKLM registry paths) to block modal popup delays under high-stress conditions.

### Step 3: Hunt and Catch the Red Team
You are now ready to run the programs. Navigate to the appropriate architecture folder (`x64` or `x86`) and begin hunting down the Red Team's C2 channels, persistent services, and anomalous processes.

## Using Sigcheck

Below are some common commands for hunting unsigned binaries, drivers, and DLLs:

```cmd
# Scans the driver directory recursively (-s) and outputs ONLY unsigned files (-u)
sigcheck.exe -s -u C:\Windows\System32\drivers\ > C:\unsigned_drivers.txt

# Scans the main Windows binaries for unsigned executables or DLLs
sigcheck.exe -s -u C:\Windows\System32\*.exe > C:\unsigned_exes.txt
sigcheck.exe -s -u C:\Windows\System32\*.dll > C:\unsigned_dlls.txt

# Checks the common malware hiding spot in ProgramData
sigcheck.exe -s -u -e C:\ProgramData\ > C:\unsigned_programdata.txt
```