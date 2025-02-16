#!/bin/bash

# Paths and configurations
OUTPUT_DIR="$(pwd)"
EMULATOR_PATH="/Users/aqeelshamz/Library/Android/sdk/emulator/emulator"
AVD_NAME="pixel6a"
VENV_DIR="$OUTPUT_DIR/venv"
BLUTTER_DIR="/Users/aqeelshamz/Aqeel/hack/blutter"  # https://github.com/worawit/blutter

# Function to set up and activate a Python virtual environment and install requirements
setup_virtualenv() {
  if [ ! -d "$VENV_DIR" ]; then
    echo "Creating virtual environment at $VENV_DIR..."
    python3 -m venv --system-site-packages "$VENV_DIR"
  fi
  echo "Activating virtual environment..."
  # shellcheck disable=SC1090
  source "$VENV_DIR/bin/activate"
  
  echo "Installing required Python modules for blutter..."
  pip install requests pyelftools
}

# Function to run Android Emulator
run_android_emulator() {
  echo ""
  echo "🚀 Starting Android Emulator..."
  "$EMULATOR_PATH" -avd "$AVD_NAME"
  echo "Emulator closed."
  echo ""
  show_menu
}

# Function to list all installed third-party apps
list_installed_apps() {
  echo ""
  echo "📱 Installed Apps:"
  echo ""
  
  adb shell pm list packages -3 | sed 's/package://g' | sort | while read -r pkg; do
    echo "  📦 $pkg"
  done
  
  echo ""
  echo "Done."
  echo ""
  show_menu
}

# Function to export an installed app (APK) to your system using package name
export_app() {
  echo ""
  echo "📦 Export an App"
  read -p "Enter the package name: " package_name
  apk_path=$(adb shell pm path "$package_name" | sed 's/package://g' | tr -d '\r')
  
  if [ -z "$apk_path" ]; then
    echo ""
    echo "⚠️  Error: APK path not found for package '$package_name'."
  else
    echo ""
    echo "Exporting $package_name from $apk_path..."
    adb pull "$apk_path" "$OUTPUT_DIR/${package_name}.apk"
    echo "✅ APK exported to $OUTPUT_DIR/${package_name}.apk"
    echo ""
    echo "🔎 Opening APK export directory in Finder..."
    open "$OUTPUT_DIR"
  fi
  echo ""
  show_menu
}

# Function to export and then decompile with apktool (using package name)
export_and_decompile_apktool() {
  echo ""
  echo "📦 Export & Decompile (apktool)"
  read -p "Enter the package name: " package_name
  apk_path=$(adb shell pm path "$package_name" | sed 's/package://g' | tr -d '\r')
  
  if [ -z "$apk_path" ]; then
    echo ""
    echo "⚠️  Error: APK path not found for package '$package_name'."
  else
    echo ""
    echo "Exporting $package_name from $apk_path..."
    adb pull "$apk_path" "$OUTPUT_DIR/${package_name}.apk"
    echo "✅ APK exported to $OUTPUT_DIR/${package_name}.apk"
    echo ""
    echo "⚙️  Decompiling with apktool..."
    apktool d "$OUTPUT_DIR/${package_name}.apk" -o "$OUTPUT_DIR/${package_name}_apktool"
    echo "✅ Decompiled to $OUTPUT_DIR/${package_name}_apktool"
    echo ""
    echo "🔎 Opening decompiled directory in Finder..."
    open "$OUTPUT_DIR/${package_name}_apktool"
  fi
  echo ""
  show_menu
}

# Function to export and then decompile with JADX (using package name)
export_and_decompile_jadx() {
  echo ""
  echo "📦 Export & Decompile (JADX)"
  read -p "Enter the package name: " package_name
  apk_path=$(adb shell pm path "$package_name" | sed 's/package://g' | tr -d '\r')
  
  if [ -z "$apk_path" ]; then
    echo ""
    echo "⚠️  Error: APK path not found for package '$package_name'."
  else
    echo ""
    echo "Exporting $package_name from $apk_path..."
    adb pull "$apk_path" "$OUTPUT_DIR/${package_name}.apk"
    echo "✅ APK exported to $OUTPUT_DIR/${package_name}.apk"
    echo ""
    echo "⚙️  Decompiling with JADX..."
    jadx -d "$OUTPUT_DIR/${package_name}_jadx" "$OUTPUT_DIR/${package_name}.apk"
    echo "✅ Decompiled to $OUTPUT_DIR/${package_name}_jadx"
    echo ""
    echo "🔎 Opening decompiled directory in Finder..."
    open "$OUTPUT_DIR/${package_name}_jadx"
  fi
  echo ""
  show_menu
}

# Function to decompile an APK file with apktool (from file)
decompile_file_apktool() {
  echo ""
  echo "📂 Decompile APK (apktool)"
  read -p "Enter path to the APK file: " file_path
  if [ ! -f "$file_path" ]; then
    echo "⚠️ Error: File not found: $file_path"
  else
    base=$(basename "$file_path" .apk)
    output_folder="$OUTPUT_DIR/${base}_apktool"
    echo "⚙️ Decompiling $file_path with apktool..."
    apktool d "$file_path" -o "$output_folder"
    echo "✅ Decompiled to $output_folder"
    echo "🔎 Opening decompiled directory in Finder..."
    open "$output_folder"
  fi
  echo ""
  show_menu
}

# Function to decompile an APK file with JADX (from file)
decompile_file_jadx() {
  echo ""
  echo "📂 Decompile APK (JADX)"
  read -p "Enter path to the APK file: " file_path
  if [ ! -f "$file_path" ]; then
    echo "⚠️ Error: File not found: $file_path"
  else
    base=$(basename "$file_path" .apk)
    output_folder="$OUTPUT_DIR/${base}_jadx"
    echo "⚙️ Decompiling $file_path with JADX..."
    jadx -d "$output_folder" "$file_path"
    echo "✅ Decompiled to $output_folder"
    echo "🔎 Opening decompiled directory in Finder..."
    open "$output_folder"
  fi
  echo ""
  show_menu
}

# Function to reverse engineer a Flutter app from an APK file
reverse_engineer_flutter() {
  echo ""
  echo "🛠️ Reverse Engineer Flutter App"
  read -p "Enter path to the APK file: " apk_file
  if [ ! -f "$apk_file" ]; then
    echo "⚠️ Error: APK file not found: $apk_file"
    show_menu
    return
  fi

  base=$(basename "$apk_file" .apk)
  decompiled_dir="$OUTPUT_DIR/${base}_apktool"
  echo ""
  echo "⚙️ Decompiling with apktool..."
  apktool d "$apk_file" -o "$decompiled_dir" -f
  echo "✅ Decompiled to $decompiled_dir"

  lib_folder="$decompiled_dir/lib"
  if [ ! -d "$lib_folder" ]; then
    echo ""
    echo "⚠️ Error: No lib folder found in the decompiled APK."
    show_menu
    return
  fi

  arm_folder=""
  for dir in "$lib_folder"/*; do
    if [ -d "$dir" ]; then
      dirname=$(basename "$dir")
      if [[ $dirname == arm* ]]; then
        # Check if this folder contains both libapp.so and libflutter.so
        if [ -f "$dir/libapp.so" ] && [ -f "$dir/libflutter.so" ]; then
          arm_folder="$dir"
          break
        fi
      fi
    fi
  done

  if [ -z "$arm_folder" ]; then
    echo ""
    echo "⚠️ Error: No ARM folder (with libapp.so and libflutter.so) found inside lib."
    show_menu
    return
  fi

  echo ""
  echo "✅ Found ARM folder: $arm_folder"
  output_flutter="$OUTPUT_DIR/${base}_flutter_output"
  echo ""
  echo "Setting up virtual environment for blutter..."
  setup_virtualenv
  echo "Running blutter command..."
  if ! $VENV_DIR/bin/python3 "$BLUTTER_DIR/blutter.py" "$arm_folder" "$output_flutter"; then
    echo "⚠️ Error: blutter command failed. Exiting."
    deactivate 2>/dev/null
    exit 1
  fi
  echo "✅ Flutter reverse engineering output saved to: $output_flutter"
  echo ""
  echo "🔎 Opening output directory in Finder..."
  open "$output_flutter"
  echo ""
  deactivate 2>/dev/null 
  show_menu
}

# Main Menu
show_menu() {
  echo ""
  echo "⚙️  rev-dorid Menu"
  echo ""
  echo "1) 🚀 Start Emulator"
  echo "2) 📱 Installed Apps"
  echo "3) 📦 Export App"
  echo "4) 📦 Export & Decompile (apktool)"
  echo "5) 📦 Export & Decompile (JADX)"
  echo "6) 📂 Decompile APK (apktool)"
  echo "7) 📂 Decompile APK (JADX)"
  echo "8) 🛠️ Reverse Engineer Flutter App"
  echo ""
  echo "Type 'exit' to quit or press Ctrl+C (Cmd+C on macOS)."
  echo ""

  read -p "> " choice
  echo ""

  case "$choice" in
    1) run_android_emulator ;;
    2) list_installed_apps ;;
    3) export_app ;;
    4) export_and_decompile_apktool ;;
    5) export_and_decompile_jadx ;;
    6) decompile_file_apktool ;;
    7) decompile_file_jadx ;;
    8) reverse_engineer_flutter ;;
    exit)
      echo "Goodbye!"
      exit 0
      ;;
    *)
      echo "Invalid option. Please try again."
      show_menu
      ;;
  esac
}

show_menu
