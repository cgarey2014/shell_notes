#!/bin/bash

# Ensure script is run with root privileges
if [ "$(id -u)" -ne 0 ]; then
    echo "❌ This script requires root privileges. Please run as root or with sudo."
    exit 1
fi

echo "🔧 This script will install the following:"
echo "  - Python 3 and pip3 (if not installed)"
echo "  - Python dependencies from requirements.txt"
echo "  - Copy ShellNotes to /opt/shellnotes"
echo "  - Create a launcher at /usr/local/bin/shellnotes (opens in terminal)"
echo "  - Make the launcher executable"
echo "❗ Please review the above steps before proceeding. ❗"
echo "  -- Press Enter to continue or Ctrl+C to cancel. --"
read -r
echo "✅ Proceeding with installation..."

INSTALL_DIR="/opt/shellnotes"
LAUNCHER_PATH="/usr/local/bin/shellnotes"
SCRIPT_PATH="$INSTALL_DIR/shellnotes.py"

# Remove previous installation
sudo rm -rf "$INSTALL_DIR" > /dev/null 2>&1

# Remove any previous symbolic link, file, or directory
[ -L "$LAUNCHER_PATH" ] && sudo rm -f "$LAUNCHER_PATH" > /dev/null 2>&1
[ -f "$LAUNCHER_PATH" ] && sudo rm -f "$LAUNCHER_PATH" > /dev/null 2>&1
[ -d "$LAUNCHER_PATH" ] && sudo rm -rf "$LAUNCHER_PATH" > /dev/null 2>&1

# Create the install directory and copy files
echo "📁 Copying files to $INSTALL_DIR..."
sudo mkdir -p "$INSTALL_DIR" > /dev/null 2>&1
sudo cp -r ./* "$INSTALL_DIR" > /dev/null 2>&1

# Install Python and pip if not already installed
if ! command -v python3 &> /dev/null; then
    echo "❌ Python 3 is not installed. Installing..."
    if [ -f /etc/debian_version ]; then
        sudo apt update -qq > /dev/null && sudo apt install python3 python3-pip -y > /dev/null 2>&1
    elif [ -f /etc/redhat-release ]; then
        sudo yum install python3 python3-pip -y > /dev/null 2>&1
    else
        echo "❌ Unsupported OS. Please install Python 3 manually."
        exit 1
    fi
fi

# Install Python requirements if present
if [ -f "requirements.txt" ]; then
    echo "📦 Installing Python dependencies..."
    if ! python3 -m pip install --break-system-packages -r requirements.txt 2>&1 | grep -v -E "WARNING: Skipping .*dist-packages/asciinema.*|WARNING: Running pip as the 'root'" >/dev/null; then
        echo "❌ Error: Failed to install Python requirements. Please ensure pip is installed and try again."
        exit 1
    fi
fi

# Create launcher script that opens in a new terminal
echo "🚀 Creating launcher at $LAUNCHER_PATH..."
sudo tee "$LAUNCHER_PATH" > /dev/null << EOF
#!/bin/bash

SCRIPT_PATH="$SCRIPT_PATH"

if command -v gnome-terminal >/dev/null 2>&1; then
    gnome-terminal -- bash -c "python3 '\$SCRIPT_PATH'; read -n 1 -s -r -p 'Press any key to exit...'"
elif command -v xfce4-terminal >/dev/null 2>&1; then
    xfce4-terminal --hold -e "bash -c 'python3 \"\$SCRIPT_PATH\"'"
elif command -v konsole >/dev/null 2>&1; then
    konsole --noclose -e bash -c "python3 '\$SCRIPT_PATH'"
elif command -v xterm >/dev/null 2>&1; then
    xterm -hold -e "python3 '\$SCRIPT_PATH'"
else
    echo "❌ No supported terminal emulator found. Please run manually:"
    echo "python3 '\$SCRIPT_PATH'"
    exit 1
fi
EOF

# Make the launcher executable
sudo chmod +x "$LAUNCHER_PATH"

# Final success message
echo "✅ ShellNotes installed successfully!"
echo "You can now launch it by typing: shellnotes"
