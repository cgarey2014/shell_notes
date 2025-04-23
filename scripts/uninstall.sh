#!/bin/bash

# -------------------------------
# 🔓 Root Check
# -------------------------------
if [ "$(id -u)" -ne 0 ]; then
    echo "❌ This script requires root privileges. Please run as root or with sudo."
    exit 1
fi

# -------------------------------
# 📁 Remove the script
# -------------------------------
SCRIPTS_DIR="$HOME/scripts"
SCRIPT_FILE="$SCRIPTS_DIR/shellnotes.py"

if [ -f "$SCRIPT_FILE" ]; then
    echo "🧹 Removing script: $SCRIPT_FILE"
    rm -f "$SCRIPT_FILE"
else
    echo "⚠️ Script not found in $SCRIPTS_DIR (already removed or never installed)."
fi

# -------------------------------
# 🗑️ Remove launcher
# -------------------------------
LAUNCHER="/usr/local/bin/shellnotes"
if [ -f "$LAUNCHER" ]; then
    echo "🗑️ Removing launcher: $LAUNCHER"
    rm -f "$LAUNCHER"
else
    echo "⚠️ Launcher not found in /usr/local/bin (already removed or never created)."
fi

# -------------------------------
# ✅ Done
# -------------------------------
echo "✅ Uninstallation complete. 'shellnotes' has been fully removed."
