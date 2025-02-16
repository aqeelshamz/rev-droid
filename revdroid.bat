@echo off
:: Paths and configurations
set OUTPUT_DIR=%cd%
set EMULATOR_PATH=C:\Users\aqeelshamz\AppData\Local\Android\Sdk\emulator\emulator.exe
set AVD_NAME=pixel6a
set VENV_DIR=%OUTPUT_DIR%\venv
set BLUTTER_DIR=C:\Users\aqeelshamz\Aqeel\hack\blutter

:: Main Menu
:show_menu
cls
echo.
echo ⚙️  rev-droid Menu
echo.
echo 1) 🚀 Start Emulator
echo 2) 📱 List Installed Apps
echo 3) 📦 Export App
echo 4) 📦 Export & Decompile (apktool)
echo 5) 📦 Export & Decompile (JADX)
echo 6) 📂 Decompile APK (apktool)
echo 7) 📂 Decompile APK (JADX)
echo 8) 🛠️ Reverse Engineer Flutter App
echo.
echo Type 'exit' to quit or press Ctrl+C.
echo.

set /p choice="> "

if "%choice%"=="1" goto run_android_emulator
if "%choice%"=="2" goto list_installed_apps
if "%choice%"=="3" goto export_app
if "%choice%"=="4" goto export_and_decompile_apktool
if "%choice%"=="5" goto export_and_decompile_jadx
if "%choice%"=="6" goto decompile_file_apktool
if "%choice%"=="7" goto decompile_file_jadx
if "%choice%"=="8" goto reverse_engineer_flutter
if "%choice%"=="exit" goto :eof

echo Invalid option. Please try again.
pause
goto show_menu

:: Functions
:run_android_emulator
echo.
echo 🚀 Starting Android Emulator...
"%EMULATOR_PATH%" -avd "%AVD_NAME%"
pause
goto show_menu

:list_installed_apps
echo.
echo 📱 Installed Apps:
adb shell pm list packages -3 | findstr /r "^package:" | sort
pause
goto show_menu

:export_app
echo.
set /p package_name="📦 Enter the package name: "
set apk_path=
for /f "tokens=2 delims=:" %%a in ('adb shell pm path "%package_name%"') do set apk_path=%%a
if not defined apk_path (
    echo ⚠️ Error: APK path not found for package "%package_name%".
) else (
    adb pull %apk_path% "%OUTPUT_DIR%\%package_name%.apk"
    echo ✅ APK exported to "%OUTPUT_DIR%\%package_name%.apk"
    explorer "%OUTPUT_DIR%"
)
pause
goto show_menu

:export_and_decompile_apktool
echo.
set /p package_name="📦 Enter the package name: "
set apk_path=
for /f "tokens=2 delims=:" %%a in ('adb shell pm path "%package_name%"') do set apk_path=%%a
if not defined apk_path (
    echo ⚠️ Error: APK path not found for package "%package_name%".
) else (
    adb pull %apk_path% "%OUTPUT_DIR%\%package_name%.apk"
    echo ✅ APK exported to "%OUTPUT_DIR%\%package_name%.apk"
    apktool d "%OUTPUT_DIR%\%package_name%.apk" -o "%OUTPUT_DIR%\%package_name%_apktool"
    echo ✅ Decompiled to "%OUTPUT_DIR%\%package_name%_apktool"
    explorer "%OUTPUT_DIR%\%package_name%_apktool"
)
pause
goto show_menu

:export_and_decompile_jadx
echo.
set /p package_name="📦 Enter the package name: "
set apk_path=
for /f "tokens=2 delims=:" %%a in ('adb shell pm path "%package_name%"') do set apk_path=%%a
if not defined apk_path (
    echo ⚠️ Error: APK path not found for package "%package_name%".
) else (
    adb pull %apk_path% "%OUTPUT_DIR%\%package_name%.apk"
    echo ✅ APK exported to "%OUTPUT_DIR%\%package_name%.apk"
    jadx -d "%OUTPUT_DIR%\%package_name%_jadx" "%OUTPUT_DIR%\%package_name%.apk"
    echo ✅ Decompiled to "%OUTPUT_DIR%\%package_name%_jadx"
    explorer "%OUTPUT_DIR%\%package_name%_jadx"
)
pause
goto show_menu

:decompile_file_apktool
echo.
set /p file_path="📂 Enter path to the APK file: "
if not exist "%file_path%" (
    echo ⚠️ Error: File not found: %file_path%
) else (
    apktool d "%file_path%" -o "%OUTPUT_DIR%\%~n1_apktool"
    echo ✅ Decompiled to "%OUTPUT_DIR%\%~n1_apktool"
    explorer "%OUTPUT_DIR%\%~n1_apktool"
)
pause
goto show_menu

:decompile_file_jadx
echo.
set /p file_path="📂 Enter path to the APK file: "
if not exist "%file_path%" (
    echo ⚠️ Error: File not found: %file_path%
) else (
    jadx -d "%OUTPUT_DIR%\%~n1_jadx" "%file_path%"
    echo ✅ Decompiled to "%OUTPUT_DIR%\%~n1_jadx"
    explorer "%OUTPUT_DIR%\%~n1_jadx"
)
pause
goto show_menu

:reverse_engineer_flutter
echo.
set /p apk_file="🛠️ Enter path to the APK file: "
if not exist "%apk_file%" (
    echo ⚠️ Error: APK file not found: %apk_file%
    pause
    goto show_menu
)
echo Setting up virtual environment...
if not exist "%VENV_DIR%" (
    python -m venv "%VENV_DIR%"
)
call "%VENV_DIR%\Scripts\activate.bat"
pip install requests pyelftools
call "%BLUTTER_DIR%\blutter.py" "%apk_file%" "%OUTPUT_DIR%\flutter_output"
deactivate
explorer "%OUTPUT_DIR%\flutter_output"
pause
goto show_menu
