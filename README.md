
# rev-droid

**rev-droid** is a versatile Android reverse engineering tool that simplifies tasks such as exporting APKs from installed apps, decompiling APKs using [apktool](https://ibotpeaches.github.io/Apktool/) or [JADX](https://github.com/skylot/jadx), and even reverse engineering Flutter apps using [blutter](https://github.com/worawit/blutter). With an easy-to-use interactive menu, rev-droid streamlines many common tasks in Android security research and development.

---

## Table of Contents

- [Features](#features)
- [Prerequisites](#prerequisites)
  - [General Requirements](#general-requirements)
  - [Installation Instructions](#installation-instructions)
- [Configuration](#configuration)
- [Usage](#usage)
- [Notes](#notes)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)
- [Acknowledgements](#acknowledgements)

---

## Features

- **🚀 Start Android Emulator:** Launch your Android Virtual Device (AVD) directly.
- **📱 List Installed Apps:** Display all third-party apps installed on the connected device/emulator.
- **📦 Export APK:** Extract an installed app’s APK by specifying its package name.
- **📦 Export & Decompile (apktool):** Export an app and decompile it with apktool.
- **📦 Export & Decompile (JADX):** Export an app and decompile it with JADX.
- **📂 Decompile Local APK (apktool):** Decompile an APK file from your system using apktool.
- **📂 Decompile Local APK (JADX):** Decompile an APK file from your system using JADX.
- **🛠️ Reverse Engineer Flutter App:** Automatically decompile and reverse engineer a Flutter app using blutter.

---

## Prerequisites

### General Requirements

- **Bash:** The tool is written as a Bash script.
- **Android SDK:** Required for `adb`, the emulator, and AVD management.
- **adb (Android Debug Bridge):** Typically installed as part of the Android SDK.
- **apktool:** For decompiling APK files.
- **JADX:** Another APK decompilation tool.
- **Python 3:** Needed to run Python scripts (for setting up a virtual environment and running blutter).
- **pip:** Python’s package installer.
- **Virtual Environment (venv):** Comes with Python 3.
- **blutter:** A tool for reverse engineering Flutter apps.  
  [blutter GitHub repository](https://github.com/worawit/blutter)

### Installation Instructions

#### Android SDK & AVD Emulator

- **macOS:**
  1. Download and install [Android Studio](https://developer.android.com/studio).
  2. Use the SDK Manager in Android Studio to install the Android SDK.
  3. Create an AVD (Android Virtual Device) using the AVD Manager.
  4. Typically, the emulator binary is located at:  
     `/Users/yourusername/Library/Android/sdk/emulator/emulator`

- **Linux:**
  1. Install Android Studio or the command-line tools.
  2. Follow the [Android developer docs](https://developer.android.com/studio/run/emulator-commandline) for setup.
  3. Ensure that `adb` and the emulator are in your system PATH.

- **Windows:**
  1. Download and install [Android Studio](https://developer.android.com/studio).
  2. Use the SDK Manager to install necessary components.
  3. Add the Android SDK platform-tools to your system PATH.

#### apktool

- **macOS/Linux:**
  ```bash
  # macOS (via Homebrew)
  brew install apktool
  ```
  Or follow the [official installation guide](https://ibotpeaches.github.io/Apktool/install/) for other systems.

- **Windows:**
  - Download apktool from the [apktool website](https://ibotpeaches.github.io/Apktool/) and follow the Windows installation instructions.

#### JADX

- Download the latest release from the [JADX GitHub releases page](https://github.com/skylot/jadx/releases).
- Extract the package and either add the `jadx` binary to your system PATH or update the rev-droid script with its full path.

#### Python 3 and Virtual Environment

- **macOS/Linux:**
  - Python 3 is typically pre-installed. If not, install it via your package manager or [Homebrew](https://brew.sh/) on macOS.
  - Create a virtual environment using:
    ```bash
    python3 -m venv venv
    ```
  
- **Windows:**
  - Download Python 3 from the [official Python website](https://www.python.org/downloads/).
  - Create a virtual environment:
    ```cmd
    python -m venv venv
    ```

#### blutter

- Clone the repository:
  ```bash
  git clone https://github.com/worawit/blutter.git /path/to/blutter
  ```
- Update the `BLUTTER_DIR` variable in the `rev-droid` script to point to your cloned blutter directory.

---

## Configuration

Before running rev-droid, open the script in your favorite text editor and update the following variables as needed:

- **OUTPUT_DIR**  
  Directory where all outputs (exported APKs, decompiled files, etc.) will be saved.  
  _Default:_ Current working directory.

- **EMULATOR_PATH**  
  Path to the Android Emulator binary.  
  _Example (macOS):_ `/Users/yourusername/Library/Android/sdk/emulator/emulator`

- **AVD_NAME**  
  Name of the Android Virtual Device (AVD) you wish to launch.

- **VENV_DIR**  
  Path to the Python virtual environment directory used for running blutter.

- **BLUTTER_DIR**  
  Path to the cloned blutter repository.

---

## Usage

1. **Make the script executable:**

   ```bash
   chmod +x rev-droid.sh
   ```

2. **Run the script:**

   ```bash
   ./rev-droid.sh
   ```

3. **Interactive Menu:**  
   Upon launching, you will see an interactive menu with options:
   
   - **1)** 🚀 Start Emulator
   - **2)** 📱 List Installed Apps
   - **3)** 📦 Export App
   - **4)** 📦 Export & Decompile (apktool)
   - **5)** 📦 Export & Decompile (JADX)
   - **6)** 📂 Decompile APK (apktool)
   - **7)** 📂 Decompile APK (JADX)
   - **8)** 🛠️ Reverse Engineer Flutter App

4. **Follow On-Screen Prompts:**  
   Choose an option by typing the corresponding number. The script will then guide you through the necessary steps for that task (e.g., entering a package name or file path).

---

## Notes

- The script is optimized for **macOS** (it uses the `open` command to display directories).  
  **Linux:** Replace `open` with `xdg-open`.  
  **Windows:** Replace `open` with `explorer` or adjust the commands as needed.
  
- Ensure all prerequisites are installed and correctly configured in your system's PATH.
  
- Some commands might require administrative privileges. Run the script with appropriate permissions if needed.

---

## Troubleshooting

- **Emulator Issues:**  
  Verify that your AVD is properly configured and that the `EMULATOR_PATH` variable points to the correct emulator binary.

- **APK Not Found:**  
  Ensure that the package name entered corresponds to an installed third-party app on the device/emulator.

- **blutter Errors:**  
  Confirm that the virtual environment is set up correctly and that the required Python modules (`requests` and `pyelftools`) are installed.

---

## Contributing

Contributions are welcome! If you encounter issues or have ideas for enhancements, please fork the repository and submit a pull request. For major changes, open an issue first to discuss what you would like to change.

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## Acknowledgements

- **[blutter](https://github.com/worawit/blutter):** For providing Flutter reverse engineering capabilities.
- **[apktool](https://ibotpeaches.github.io/Apktool/):** For APK decompilation.
- **[JADX](https://github.com/skylot/jadx):** For APK decompilation.
- **Android SDK & AVD:** For robust Android development and testing tools.
