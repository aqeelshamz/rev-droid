# Rev-Droid

**Rev-Droid** is an interactive toolkit for reverse engineering Android apps. It automates tasks such as launching the Android emulator, exporting APKs, decompiling using apktool or JADX, and reverse engineering Flutter apps via Blutter.

This repository includes two scripts:
- `revdroid.sh` – For Unix-based systems (macOS/Linux)
- `revdroid.bat` – For Windows

## Features

- **Start Android Emulator:** Launch your configured Android Virtual Device (AVD).
- **List Installed Apps:** Display third-party applications installed on a connected Android device.
- **Export App:** Pull APKs directly from the device using the package name.
- **Decompile APKs:** Use apktool or JADX to decompile APK files.
- **Reverse Engineer Flutter Apps:** Decompile Flutter APKs and run the Blutter tool for additional analysis.

## Prerequisites

- **Android SDK:** Ensure you have the Android SDK installed with tools such as `adb`, `emulator`, `apktool`, and `jadx` available in your system's PATH.
- **Python 3:** Required for setting up a virtual environment and running Blutter.
- **Blutter:** Clone or download from [Blutter on GitHub](https://github.com/worawit/blutter) and update the `BLUTTER_DIR` variable in the scripts accordingly.

## Setup and Usage

### For macOS/Linux

1. **Configure the Script:**
   - Open `revdroid.sh` and update the following variables if needed:
     - `EMULATOR_PATH`: Path to your Android emulator executable.
     - `AVD_NAME`: Name of your Android Virtual Device.
     - `BLUTTER_DIR`: Path to your Blutter tool directory.
  
2. **Make the Script Executable:**
   ```bash
   chmod +x revdroid.sh
   ```

3. **Run the Script:**
   ```bash
   ./revdroid.sh
   ```

### For Windows

1. **Configure the Script:**
   - Open `revdroid.bat` in a text editor and update:
     - `EMULATOR_PATH`: Path to your Android emulator executable.
     - `AVD_NAME`: Your AVD name.
     - `BLUTTER_DIR`: Path to your Blutter tool directory.

2. **Run the Batch File:**
   - Open Command Prompt and execute:
     ```bat
     revdroid.bat
     ```

## How It Works

Upon running either script, you will be presented with a menu offering several options:
- **Start Emulator:** Launch your Android emulator.
- **List Installed Apps:** Display a list of installed third-party apps.
- **Export App:** Pull the APK of a specified app from the connected device.
- **Export & Decompile:** Automatically export and decompile the APK using apktool or JADX.
- **Reverse Engineer Flutter App:** Decompile a Flutter APK and run the Blutter tool to analyze native libraries.

For Flutter reverse engineering, the script sets up a Python virtual environment, installs required modules (`requests` and `pyelftools`), and executes the Blutter tool.

## License

This project is licensed under the [MIT License](LICENSE).
