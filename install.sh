#!/bin/bash

# Ensure the script is run with root privileges
if [ "$(id -u)" -ne 0 ]; then
    echo "This script requires root privileges. Please run as root or with sudo."
    exit 1
fi

# Step 1: Install Python requirements
echo "Installing Python dependencies from requirements.txt..."
pip3 install -r requirements.txt || {
    echo "Failed to install Python requirements."
    exit 1
}

# Step 2: Create ~/scripts if it does not exist
USER_HOME=$(eval echo "~$SUDO_USER")
SCRIPTS_DIR="$USER_HOME/scripts"

echo "Ensuring $SCRIPTS_DIR exists..."
mkdir -p "$SCRIPTS_DIR"

# Step 3: Move shellnotes.py to ~/scripts
echo "Moving shellnotes.py to $SCRIPTS_DIR..."
cp shellnotes.py "$SCRIPTS_DIR/shellnotes.py"
chown "$SUDO_USER":"$SUDO_USER" "$SCRIPTS_DIR/shellnotes.py"
chmod +x "$SCRIPTS_DIR/shellnotes.py"

# Step 4: Create /usr/local/bin/shellnotes
echo "Creating /usr/local/bin/shellnotes..."
cat << 'EOF' > /usr/local/bin/shellnotes
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
        echo "No supported terminal emulator found. Please install gnome-terminal, xfce4-terminal, xterm, or konsole."
        exit 1
    fi
}

# Execute
open_new_terminal
EOF

chmod +x /usr/local/bin/shellnotes

echo "Installation complete. You can now run 'shellnotes' from any terminal."
