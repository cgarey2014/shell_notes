#!/bin/bash

# Ensure script is run with root privileges
if [ "$(id -u)" -ne 0 ]; then
    echo "❌ This script requires root privileges. Please run as root or with sudo."
    exit 1
fi

# Install Python dependencies silently, but log if it fails
echo "📦 Installing Python dependencies from requirements.txt..."
if ! pip3 install --break-system-packages -r requirements.txt > /dev/null 2>&1; then
    echo "❌ Failed to install Python requirements. Please ensure pip3 is working properly."
    exit 1
fi

# Ensure ~/scripts exists
SCRIPTS_DIR="$HOME/scripts"
mkdir -p "$SCRIPTS_DIR"

# Move shellnotes.py
echo "📁 Moving shellnotes.py to $SCRIPTS_DIR"
cp shellnotes.py "$SCRIPTS_DIR/shellnotes.py"

# Create launcher script
LAUNCHER="/usr/local/bin/shellnotes"
echo "⚙️ Creating launcher at $LAUNCHER"

cat << 'EOF' > "$LAUNCHER"
#!/bin/bash

SCRIPT_PATH="$HOME/scripts/shellnotes.py"

# Function to detect terminal and run the script
open_new_terminal() {
    if command -v gnome-terminal >/dev/null 2>&1; then
        gnome-terminal -- bash -c "python3 '$SCRIPT_PATH'; exec bash"
    elif command -v xfce4-terminal >/dev/null 2>&1; then
        xfce4-terminal --hold -e "python3 '$SCRIPT_PATH'"
    elif command -v xterm >/dev/null 2>&1; then
        xterm -hold -e "python3 '$SCRIPT_PATH'"
    elif command -v konsole >/dev/null 2>&1; then
        konsole --noclose -e python3 "$SCRIPT_PATH"
    else
        echo "❌ No supported terminal emulator found. Please install gnome-terminal, xfce4-terminal, xterm, or konsole."
        exit 1
    fi
}

open_new_terminal
EOF

chmod +x "$LAUNCHER"

echo "✅ Installation complete! You can now run 'shellnotes' from any terminal."
