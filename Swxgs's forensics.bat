@echo off
chcp 65001 >nul
color 0B
title Swxgs's Forensic Tools Download Helper

REM Resize console window to fit content properly
mode con: cols=120 lines=35
REM =============================================================================
REM Forensic Tools Download Helper
REM =============================================================================
REM 
REM This script opens download links for various forensic tools in your browser
REM
REM USAGE: Simply run forenscan.bat and select from the menu
REM
REM =============================================================================

REM Tool download URLs
REM Detect.ac tools
set "PREFETCH_URL=https://detect.ac/tool/prefetch/"
set "BAM_URL=https://detect.ac/tool/bam/"
set "WINDB_URL=https://detect.ac/tool/windb/"
set "PCASVC_URL=https://detect.ac/tool/pcasvc/"
set "PROCESS_URL=https://detect.ac/tool/process/"

REM System Informer
set "SYSINFORMER_URL=https://systeminformer.com/canary"

REM NirSoft tools (corrected URLs)
set "NIRSOFT_BASE_URL=https://www.nirsoft.net/utils/"
set "AUTORUNS_URL=https://www.nirsoft.net/utils/autoruns.html"
set "PROCMON_URL=https://www.nirsoft.net/utils/procmon.html"
set "REGMON_URL=https://www.nirsoft.net/utils/regmon.html"
set "FILEMON_URL=https://www.nirsoft.net/utils/filemon.html"
set "USBDEVIEW_URL=https://www.nirsoft.net/utils/usbdeview.zip"
set "WIRELESSNETVIEW_URL=https://www.nirsoft.net/utils/wirelessnetview.html"
set "BLUETOOTHVIEW_URL=https://www.nirsoft.net/utils/bluetoothview.html"
set "PRODUKEY_URL=https://www.nirsoft.net/utils/produkey.html"
set "CURRPORTS_URL=https://www.nirsoft.net/utils/cports.html"
set "NETSTATVIEWER_URL=https://www.nirsoft.net/utils/netstat_viewer.html"

REM Eric Zimmerman tools (manual download page)
set "ERIC_ZIMMERMAN_URL=https://ericzimmerman.github.io/#!index.md"

REM Magnet tools
set "MAGNET_PROCESS_CAPTURE_URL=https://www.magnetforensics.com/resources/process-capture/"

REM Disk Drill (corrected)
set "DISK_DRILL_URL=https://cleverfiles.com/disk-drill-win.html"

REM Journal Trace
set "JOURNAL_TRACE_URL=https://github.com/ponei/JournalTrace/releases/latest"

REM Espouken tools
set "PCSVC_EXECUTED_URL=https://github.com/spokwn/pcasvc-executed"
set "PROCESS_PARSER_URL=https://github.com/spokwn/process-parser"
set "BAM_DELETED_KEYS_URL=https://github.com/spokwn/BamDeletedKeys/releases"
set "JOURNAL_TRACE_SPOKWN_URL=https://github.com/spokwn/JournalTrace/tree/master"
set "ACTIVITIES_CACHE_URL=https://github.com/spokwn/ActivitiesCache-execution"
set "PREFETCH_PARSER_URL=https://github.com/spokwn/prefetch-parser"
set "PATHS_PARSER_URL=https://github.com/spokwn/PathsParser"
set "BAM_PARSER_URL=https://github.com/spokwn/BAM-parser"

REM Initialize
setlocal enabledelayedexpansion

REM Set up CHECKER folder on desktop
set "CHECKER_DIR=%USERPROFILE%\Desktop\CHECKER"
if not exist "%CHECKER_DIR%" (
    echo Creating CHECKER folder on desktop...
    mkdir "%CHECKER_DIR%"
)


:main_menu
cls
call :show_banner
call :show_menu
color 07
set /p "choice=Select an option: "

if "%choice%"=="1" (
    echo.
    echo Opening Swxgs's Tools GoFile link...
    start "" "https://gofile.io/d/3DSVae"
    echo ✓ GoFile link opened in your default browser!
    echo.
    echo You can download the latest versions of:
    echo - DLL Scanner
    echo - Memory Scanner
    echo.
    pause
) else if "%choice%"=="2" (
    call :download_detect_tools
) else if "%choice%"=="3" (
    call :download_eric_tools
) else if "%choice%"=="4" (
    call :download_espouken_tools
) else if "%choice%"=="5" (
    call :download_system_informer
) else if "%choice%"=="6" (
    call :download_nirsoft_tools
) else if "%choice%"=="7" (
    call :download_disk_drill
) else if "%choice%"=="8" (
    call :download_magnet_tools
) else if "%choice%"=="9" (
    call :download_journal_trace
) else if "%choice%"=="10" (
    call :download_all_tools
) else if "%choice%"=="11" (
    call :uninstall_all_tools
) else if "%choice%"=="12" (
    call :support_suggestions
) else if "%choice%"=="0" (
    goto :exit_program
) else (
    echo Invalid option. Please try again.
    pause
    goto :main_menu
)

goto :main_menu

REM =============================================================================
REM FUNCTION: Show banner
REM =============================================================================
:show_banner
cls
color 0F
echo.
color 0B
echo ███████╗██╗    ██╗██╗  ██╗ ██████╗ ███████╗ █████╗  ██████╗
color 0E
echo ██╔════╝██║    ██║╚██╗██╔╝██╔════╝ ██╔════╝██╔══██╗██╔════╝
color 0D
echo ███████╗██║ █╗ ██║ ╚███╔╝ ██║  ███╗███████╗███████║██║
color 0C
echo ╚════██║██║███╗██║ ██╔██╗ ██║   ██║╚════██║██╔══██║██║
color 0A
echo ███████║╚███╔███╔╝██╔╝ ██╗╚██████╔╝███████║██║  ██║╚██████╗
color 0F
echo ╚══════╝ ╚══╝╚══╝ ╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝ ╚═════╝
echo.
color 0E
echo Note: Make sure to put this Tool in the folder with the name 'CHECKER' on the desktop.
echo.
goto :eof

REM =============================================================================
REM FUNCTION: Show menu
REM =============================================================================
:show_menu
color 0A
echo.
echo ┌─ MAIN CATEGORIES ─────────────────────────────────────────────────────────┐
color 0F
echo │ [1]  Swxgs's Tools           - DLL Scanner + Memory Scanner              │
color 0D
echo │ [2]  Detect AC Tools         - Windows artifacts                          │
color 0E
echo │ [3]  Eric Zimmerman Tools    - Forensic suite                            │
color 0F
echo │ [4]  Espouken Tools          - Advanced forensics                        │
color 0C
echo │ [5]  System Informer         - Process monitoring                        │
color 0A
echo │ [6]  NirSoft Tools           - USB analysis                              │
color 0B
echo │ [7]  Disk Drill              - Data recovery                             │
color 0E
echo │ [8]  Magnet Process Capture  - Memory forensics                          │
color 0C
echo │ [9]  Journal Trace           - NTFS journal analysis                     │
color 0A
echo ├───────────────────────────────────────────────────────────────────────────┤
color 0B
echo │ [10] Download All            - Download all tools                        │
color 0C
echo │ [11] Uninstall All           - Remove all tools                          │
color 0E
echo │ [12] Support/Suggestions     - Get help or suggest features              │
color 07
echo │ [0]  Exit                    - Close application                         │
color 0A
echo └───────────────────────────────────────────────────────────────────────────┘
echo.
goto :eof

REM =============================================================================
REM FUNCTION: Download Detect.ac tools
REM =============================================================================
:download_detect_tools
cls
color 0D
echo.
echo === Detect.ac Tools ===
echo.

echo WINDOWS ARTIFACT ANALYSIS TOOLS
echo Download location: %CHECKER_DIR%
echo ────────────────────────────────────────────────
echo [1] Prefetch Tool    - Windows Prefetch files
echo [2] BAM Tool         - Background Activity Moderator
echo [3] WinDB Tool       - Windows Event Logs
echo [4] PCASVC Tool      - Program Compatibility Assistant
echo [5] Process Tool     - Process analysis
echo.
echo OPTIONS
echo ────────────────────────────────────────────────
echo [0] Open All Tools
echo [9] Back to Main Menu
echo.
set /p "choice=Select tool number (0-5, 9): "

if "%choice%"=="0" (
    echo Opening all Detect.ac tools...
    start "" "%PREFETCH_URL%"
    timeout /t 1 /nobreak >nul
    start "" "%BAM_URL%"
    timeout /t 1 /nobreak >nul
    start "" "%WINDB_URL%"
    timeout /t 1 /nobreak >nul
    start "" "%PCASVC_URL%"
    timeout /t 1 /nobreak >nul
    start "" "%PROCESS_URL%"
    echo ✓ All Detect.ac tools opened!
) else if "%choice%"=="1" (
    echo Opening Prefetch Tool...
    start "" "%PREFETCH_URL%"
    echo ✓ Prefetch Tool page opened!
) else if "%choice%"=="2" (
    echo Opening BAM Tool...
    start "" "%BAM_URL%"
    echo ✓ BAM Tool page opened!
) else if "%choice%"=="3" (
    echo Opening WinDB Tool...
    start "" "%WINDB_URL%"
    echo ✓ WinDB Tool page opened!
) else if "%choice%"=="4" (
    echo Opening PCASVC Tool...
    start "" "%PCASVC_URL%"
    echo ✓ PCASVC Tool page opened!
) else if "%choice%"=="5" (
    echo Opening Process Tool...
    start "" "%PROCESS_URL%"
    echo ✓ Process Tool page opened!
) else if "%choice%"=="9" (
    goto :main_menu
) else (
    echo Invalid selection.
)

echo.
pause
goto :eof

REM =============================================================================
REM FUNCTION: Download System Informer
REM =============================================================================
:download_system_informer
cls
color 0C
echo.
echo === System Informer ===
echo.
echo Download location: %CHECKER_DIR%
echo.
echo [1] Open System Informer download page
echo [0] Back to Main Menu
echo.
set /p "choice=Select option (0-1): "

if "%choice%"=="1" (
    echo Opening System Informer download page...
    echo URL: %SYSINFORMER_URL%
    start "" "%SYSINFORMER_URL%"
    echo ✓ System Informer download page opened in browser!
    echo.
    pause
) else if "%choice%"=="0" (
    goto :main_menu
) else (
    echo Invalid selection.
    pause
)
goto :eof

REM =============================================================================
REM FUNCTION: Download NirSoft Tools
REM =============================================================================
:download_nirsoft_tools
cls
color 0A
echo.
echo === NirSoft Tools ===
echo.

echo USB ANALYSIS TOOLS
echo Download location: %CHECKER_DIR%
echo ────────────────────────────────────────────────
echo [1]  USBDeview         - USB device history analysis
echo.
echo OPTIONS
echo ────────────────────────────────────────────────
echo [99] Back to Main Menu
echo.
set /p "choice=Select tool number (1, 99): "

if "%choice%"=="1" (
    echo Opening USBDeview...
    start "" "%USBDEVIEW_URL%"
    echo ✓ USBDeview page opened!
) else if "%choice%"=="99" (
    goto :main_menu
) else (
    echo Invalid selection.
)

echo.
pause
goto :eof

REM =============================================================================
REM FUNCTION: Download Eric Zimmerman Tools
REM =============================================================================
:download_eric_tools
cls
color 0E
echo.
echo === Eric Zimmerman Tools ===
echo.
echo Download location: %CHECKER_DIR%
echo.
echo [1] Open Eric Zimmerman's forensic tools page
echo [0] Back to Main Menu
echo.
set /p "choice=Select option (0-1): "

if "%choice%"=="1" (
    echo Opening Eric Zimmerman's forensic tools page...
    echo URL: %ERIC_ZIMMERMAN_URL%
    start "" "%ERIC_ZIMMERMAN_URL%"
    echo ✓ Eric Zimmerman tools page opened in browser!
    echo.
    echo Note: You will need to manually download individual tools from this page.
    echo.
    pause
) else if "%choice%"=="0" (
    goto :main_menu
) else (
    echo Invalid selection.
    pause
)
goto :eof

REM =============================================================================
REM FUNCTION: Download Magnet Tools
REM =============================================================================
:download_magnet_tools
cls
color 0F
echo.
echo === Magnet Process Capture ===
echo.
echo Download location: %CHECKER_DIR%\magnet
echo.

if not exist "%CHECKER_DIR%\magnet" mkdir "%CHECKER_DIR%\magnet"

echo Opening Magnet Process Capture download page...
echo URL: %MAGNET_PROCESS_CAPTURE_URL%
start "" "%MAGNET_PROCESS_CAPTURE_URL%"
echo ✓ Magnet Process Capture download page opened in browser!
echo.
pause
goto :eof

REM =============================================================================
REM FUNCTION: Download Disk Drill
REM =============================================================================
:download_disk_drill
cls
color 0B
echo.
echo === Disk Drill ===
echo.
echo Download location: %CHECKER_DIR%\disk-drill
echo.

if not exist "%CHECKER_DIR%\disk-drill" mkdir "%CHECKER_DIR%\disk-drill"

echo Opening Disk Drill download page...
echo URL: %DISK_DRILL_URL%
start "" "%DISK_DRILL_URL%"
echo ✓ Disk Drill download page opened in browser!
echo.
pause
goto :eof

REM =============================================================================
REM FUNCTION: Download Journal Trace
REM =============================================================================
:download_journal_trace
cls
color 0A
echo.
echo === Journal Trace ===
echo.
echo Download location: %CHECKER_DIR%
echo.
echo Opening Journal Trace download page...
echo URL: %JOURNAL_TRACE_URL%
start "" "%JOURNAL_TRACE_URL%"
echo ✓ Journal Trace download page opened in browser!
echo.
pause
goto :eof

REM =============================================================================
REM FUNCTION: Download Espouken Tools
REM =============================================================================
:download_espouken_tools
cls
color 0E
echo.
echo === Espouken Tools ===
echo.

echo ADVANCED WINDOWS FORENSICS TOOLS
echo Download location: %CHECKER_DIR%
echo ────────────────────────────────────────────────
echo WINDOWS ARTIFACT PARSERS
echo [1]  PCASVC Executed           - PcaSvc execution info
echo [2]  Process Parser            - Process execution analysis
echo [3]  BAM Deleted Keys          - BAM registry analysis
echo [4]  BAM Parser                - BAM registry parser
echo.
echo FILE SYSTEM ANALYSIS
echo [5]  Journal Trace (spokwn)    - NTFS change journal
echo [6]  Prefetch Parser           - Prefetch file parser
echo [7]  Paths Parser              - Path analysis
echo [8]  Activities Cache Execution - Activities cache
echo.
echo OPTIONS
echo ────────────────────────────────────────────────
echo [0]  Open All Tools
echo [99] Back to Main Menu
echo.
set /p "choice=Select tool number (0-8, 99): "

if "%choice%"=="0" (
    echo Opening all Espouken tools...
    start "" "%PCSVC_EXECUTED_URL%"
    timeout /t 1 /nobreak >nul
    start "" "%PROCESS_PARSER_URL%"
    timeout /t 1 /nobreak >nul
    start "" "%BAM_DELETED_KEYS_URL%"
    timeout /t 1 /nobreak >nul
    start "" "%JOURNAL_TRACE_SPOKWN_URL%"
    timeout /t 1 /nobreak >nul
    start "" "%ACTIVITIES_CACHE_URL%"
    timeout /t 1 /nobreak >nul
    start "" "%PREFETCH_PARSER_URL%"
    timeout /t 1 /nobreak >nul
    start "" "%PATHS_PARSER_URL%"
    timeout /t 1 /nobreak >nul
    start "" "%BAM_PARSER_URL%"
    echo ✓ All Espouken tools opened!
) else if "%choice%"=="1" (
    echo Opening PCASVC Executed...
    start "" "%PCSVC_EXECUTED_URL%"
    echo ✓ PCASVC Executed page opened!
) else if "%choice%"=="2" (
    echo Opening Process Parser...
    start "" "%PROCESS_PARSER_URL%"
    echo ✓ Process Parser page opened!
) else if "%choice%"=="3" (
    echo Opening BAM Deleted Keys...
    start "" "%BAM_DELETED_KEYS_URL%"
    echo ✓ BAM Deleted Keys page opened!
) else if "%choice%"=="4" (
    echo Opening Journal Trace (spokwn)...
    start "" "%JOURNAL_TRACE_SPOKWN_URL%"
    echo ✓ Journal Trace (spokwn) page opened!
) else if "%choice%"=="5" (
    echo Opening Activities Cache Execution...
    start "" "%ACTIVITIES_CACHE_URL%"
    echo ✓ Activities Cache Execution page opened!
) else if "%choice%"=="6" (
    echo Opening Prefetch Parser...
    start "" "%PREFETCH_PARSER_URL%"
    echo ✓ Prefetch Parser page opened!
) else if "%choice%"=="7" (
    echo Opening Paths Parser...
    start "" "%PATHS_PARSER_URL%"
    echo ✓ Paths Parser page opened!
) else if "%choice%"=="8" (
    echo Opening BAM Parser...
    start "" "%BAM_PARSER_URL%"
    echo ✓ BAM Parser page opened!
) else if "%choice%"=="99" (
    goto :main_menu
) else (
    echo Invalid selection.
)

echo.
pause
goto :eof

REM =============================================================================
REM FUNCTION: Download All Tools
REM =============================================================================
:download_all_tools
cls
color 0B
echo.
echo === DOWNLOAD ALL FORENSIC TOOLS ===
echo.
echo This will open ALL download pages at once!
echo Download location: %CHECKER_DIR%
echo.
echo Opening ALL forensic tool download pages...
echo.

REM Create all necessary folders
if not exist "%CHECKER_DIR%\magnet" mkdir "%CHECKER_DIR%\magnet"
if not exist "%CHECKER_DIR%\disk-drill" mkdir "%CHECKER_DIR%\disk-drill"

REM Detect AC Tools (5 tools)
echo Opening Detect AC Tools...
start "" "%PREFETCH_URL%"
timeout /t 1 /nobreak >nul
start "" "%BAM_URL%"
timeout /t 1 /nobreak >nul
start "" "%WINDB_URL%"
timeout /t 1 /nobreak >nul
start "" "%PCASVC_URL%"
timeout /t 1 /nobreak >nul
start "" "%PROCESS_URL%"
timeout /t 1 /nobreak >nul

REM System Informer
echo Opening System Informer...
start "" "%SYSINFORMER_URL%"
timeout /t 1 /nobreak >nul

REM NirSoft Tools (1 tool)
echo Opening NirSoft Tools...
start "" "%USBDEVIEW_URL%"
timeout /t 1 /nobreak >nul

REM Eric Zimmerman Tools
echo Opening Eric Zimmerman Tools...
start "" "%ERIC_ZIMMERMAN_URL%"
timeout /t 1 /nobreak >nul

REM Magnet Process Capture
echo Opening Magnet Process Capture...
start "" "%MAGNET_PROCESS_CAPTURE_URL%"
timeout /t 1 /nobreak >nul

REM Disk Drill
echo Opening Disk Drill...
start "" "%DISK_DRILL_URL%"
timeout /t 1 /nobreak >nul

REM Journal Trace
echo Opening Journal Trace...
start "" "%JOURNAL_TRACE_URL%"
timeout /t 1 /nobreak >nul

REM Espouken Tools (8 tools)
echo Opening Espouken Tools...
start "" "%PCSVC_EXECUTED_URL%"
timeout /t 1 /nobreak >nul
start "" "%PROCESS_PARSER_URL%"
timeout /t 1 /nobreak >nul
start "" "%BAM_DELETED_KEYS_URL%"
timeout /t 1 /nobreak >nul
start "" "%JOURNAL_TRACE_SPOKWN_URL%"
timeout /t 1 /nobreak >nul
start "" "%ACTIVITIES_CACHE_URL%"
timeout /t 1 /nobreak >nul
start "" "%PREFETCH_PARSER_URL%"
timeout /t 1 /nobreak >nul
start "" "%PATHS_PARSER_URL%"
timeout /t 1 /nobreak >nul
start "" "%BAM_PARSER_URL%"

echo.
echo ✓ ALL forensic tool download pages opened!
echo Total: 24+ download pages opened
echo.
echo Note: Download all tools to: %CHECKER_DIR%
echo.
pause
goto :eof

REM =============================================================================
REM FUNCTION: Uninstall All Tools
REM =============================================================================
:uninstall_all_tools
cls
color 0C
echo.
echo === UNINSTALL ALL FORENSIC TOOLS ===
echo.
echo WARNING: This will permanently delete ALL downloaded forensic tools!
echo.
echo This will remove:
echo - The entire CHECKER folder: %CHECKER_DIR%
echo - All subfolders (magnet, disk-drill, etc.)
echo - All downloaded tools and files
echo - Any extracted archives
echo.
set /p "confirm=Are you sure you want to delete everything? Type 'DELETE' to confirm: "

if /i not "%confirm%"=="DELETE" (
    echo.
    echo Uninstall cancelled. No files were deleted.
    echo.
    pause
    goto :eof
)

echo.
echo Starting uninstall process...
echo.

REM Check if CHECKER folder exists
if exist "%CHECKER_DIR%" (
    echo Deleting CHECKER folder and all contents...
    echo Location: %CHECKER_DIR%
    
    REM Use PowerShell to force delete all contents including hidden/system files
    powershell -Command "if (Test-Path '%CHECKER_DIR%') { Remove-Item '%CHECKER_DIR%' -Recurse -Force -ErrorAction SilentlyContinue }" >nul 2>&1
    
    REM Verify deletion
    if exist "%CHECKER_DIR%" (
        echo.
        echo ⚠ WARNING: Some files could not be deleted.
        echo This may be because:
        echo - Files are currently in use by other programs
        echo - Files are read-only or system protected
        echo - Insufficient permissions
        echo.
        echo Please manually delete: %CHECKER_DIR%
    ) else (
        echo.
        echo ✓ CHECKER folder successfully deleted!
    )
) else (
    echo.
    echo CHECKER folder not found: %CHECKER_DIR%
    echo Nothing to uninstall.
)

echo.
echo Uninstall process completed.
echo.
pause
goto :eof

REM =============================================================================
REM FUNCTION: Swxgs Tools Menu
REM =============================================================================
:swxgs_tools_menu
cls
color 0F
echo.
echo === Swxgs's Tools ===
echo.

echo CUSTOM FORENSIC TOOLS
echo Download location: %CHECKER_DIR%\swxgs-tools
echo ────────────────────────────────────────────────
echo [1]  Open GoFile Link         - Download tools from GoFile
echo [2]  DLL Scanner              - Comprehensive DLL analysis tool
echo [3]  Memory Scanner           - Advanced memory forensics scanner
echo [4]  Run DLL Scanner          - Execute DLL scanner directly
echo [5]  Run Memory Scanner       - Execute memory scanner directly
echo.
echo OPTIONS
echo ────────────────────────────────────────────────
echo [0]  Open All Tools
echo [99] Back to Main Menu
echo.
set /p "choice=Select tool number (0-5, 99): "

if "%choice%"=="0" (
    echo Opening all Swxgs tools...
    echo.
    echo Opening GoFile download link...
    start "" "https://gofile.io/d/3DSVae"
    echo ✓ GoFile link opened in your default browser!
    echo.
    echo ✓ DLL Scanner and Memory Scanner are available locally!
    echo.
    echo DLL Scanner location: %~dp0dllscanner\
    echo Memory Scanner location: %~dp0memoryscanner\
    echo.
    echo You can run them using:
    echo - DLL Scanner: %~dp0dllscanner\run.bat
    echo - Memory Scanner: %~dp0memoryscanner\launch_scanner.bat
) else if "%choice%"=="1" (
    echo.
    echo Opening GoFile download link...
    start "" "https://gofile.io/d/3DSVae"
    echo ✓ GoFile link opened in your default browser!
    echo.
    echo You can download the latest versions of:
    echo - DLL Scanner
    echo - Memory Scanner
    echo.
) else if "%choice%"=="2" (
    echo.
    echo === DLL Scanner ===
    echo.
    echo A comprehensive C++ DLL Scanner tool designed for Windows systems.
    echo Provides administrative-level scanning capabilities to identify and analyze DLL files.
    echo.
    echo Location: %~dp0dllscanner\
    echo Executable: %~dp0dllscanner\build\bin\Release\Swxgs's dll scanner.exe
    echo.
    echo Features:
    echo - Scan System Directories
    echo - Scan Application Directories  
    echo - Scan Process Loaded DLLs
    echo - Generate comprehensive reports
    echo - Digital signature verification
    echo.
    echo To run: %~dp0dllscanner\run.bat
    echo.
) else if "%choice%"=="3" (
    echo.
    echo === Memory Scanner ===
    echo.
    echo A powerful memory forensics scanner adapted from the Ocean memory management framework.
    echo Provides comprehensive memory analysis capabilities for digital forensics investigations.
    echo.
    echo Location: %~dp0memoryscanner\
    echo Executables: 
    echo - %~dp0memoryscanner\ForensicsMemoryScanner.exe
    echo - %~dp0memoryscanner\SwxgsScanner.exe
    echo.
    echo Features:
    echo - Process Memory Scanning
    echo - Multi-Process Analysis
    echo - Memory Region Mapping
    echo - Pattern Matching
    echo - Multiple export formats (JSON, CSV, XML, TXT)
    echo.
    echo To run: %~dp0memoryscanner\launch_scanner.bat
    echo.
) else if "%choice%"=="4" (
    echo.
    echo Running DLL Scanner...
    echo.
    if exist "%~dp0dllscanner\run.bat" (
        call "%~dp0dllscanner\run.bat"
    ) else if exist "%~dp0dllscanner\build\bin\Release\Swxgs's dll scanner.exe" (
        echo Starting DLL Scanner executable...
        start "" "%~dp0dllscanner\build\bin\Release\Swxgs's dll scanner.exe"
        echo ✓ DLL Scanner started!
    ) else (
        echo ⚠ DLL Scanner not found!
        echo Expected location: %~dp0dllscanner\build\bin\Release\Swxgs's dll scanner.exe
        echo.
        echo Please ensure the DLL Scanner is built and available.
    )
) else if "%choice%"=="5" (
    echo.
    echo Running Memory Scanner...
    echo.
    if exist "%~dp0memoryscanner\launch_scanner.bat" (
        call "%~dp0memoryscanner\launch_scanner.bat"
    ) else if exist "%~dp0memoryscanner\SwxgsScanner.exe" (
        echo Starting Memory Scanner executable...
        start "" "%~dp0memoryscanner\SwxgsScanner.exe"
        echo ✓ Memory Scanner started!
    ) else if exist "%~dp0memoryscanner\ForensicsMemoryScanner.exe" (
        echo Starting Memory Scanner executable...
        start "" "%~dp0memoryscanner\ForensicsMemoryScanner.exe"
        echo ✓ Memory Scanner started!
    ) else (
        echo ⚠ Memory Scanner not found!
        echo Expected locations:
        echo - %~dp0memoryscanner\SwxgsScanner.exe
        echo - %~dp0memoryscanner\ForensicsMemoryScanner.exe
        echo.
        echo Please ensure the Memory Scanner is built and available.
    )
) else if "%choice%"=="99" (
    goto :main_menu
) else (
    echo Invalid selection.
)

echo.
pause
goto :eof

REM =============================================================================
REM FUNCTION: Support/Suggestions
REM =============================================================================
:support_suggestions
cls
color 0E
echo.
echo === SUPPORT / SUGGESTIONS ===
echo.
echo Need help or have suggestions for improvement?
echo.
echo This will open a Discord link where you can:
echo - Get technical support
echo - Report bugs or issues
echo - Suggest new features
echo - Request additional forensic tools
echo - Get help with tool usage
echo.
echo Discord: specsvc
echo.
set /p "open_discord=Open Discord support link? (y/n): "

if /i "%open_discord%"=="y" (
    echo.
    echo Opening Discord support link...
    start "" "https://discord.com/users/1156545582727450745"
    echo.
    echo Discord link opened in your browser!
    echo.
    echo If the link doesn't work, you can manually add me: specsvc
    echo.
    echo Thank you for your feedback and suggestions!
) else (
    echo.
    echo Discord link not opened.
    echo.
    echo You can manually add me on Discord: specsvc
)

echo.
pause
goto :eof

REM =============================================================================
REM FUNCTION: Exit Program
REM =============================================================================
:exit_program
cls
echo.
echo =============================================================================
echo Thank you for using Swxgs's Tools And Download Helper!
echo =============================================================================
echo.
echo Remember to:
echo - Download tools from the opened browser pages
echo - Extract and configure tools as needed
echo - Follow legal and ethical guidelines for forensics
echo.
pause
exit /b 0

REM =============================================================================
REM END OF SCRIPT
REM =============================================================================