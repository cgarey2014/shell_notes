#!/bin/bash

# Detect the terminal emulator being used
parent_pid=$(ps -o ppid= -p $$)
terminal_cmd=$(ps -o comm= -p "$parent_pid")

# Default command to run the Python script
script_cmd="python3 -m shell_notes"

# Function to launch terminal with the appropriate command
launch_terminal() {
    terminal=$1
    case "$terminal" in
        gnome-terminal)
            gnome-terminal -- bash -c "$script_cmd"
            ;;
        konsole)
            konsole -e bash -c "$script_cmd"
            ;;
        xfce4-terminal)
            xfce4-terminal --command="bash -c '$script_cmd'"
            ;;
        xterm)
            xterm -e "$script_cmd"
            ;;
        tilix)
            tilix -e bash -c "$script_cmd"
            ;;
        terminator)
            terminator -x bash -c "$script_cmd"
            ;;
        alacritty)
            alacritty -e bash -c "$script_cmd"
            ;;
        urxvt)
            urxvt -e bash -c "$script_cmd"
            ;;
        *)
            echo "Unsupported or unknown terminal: $terminal"
            echo "Trying fallback options..."
            try_fallbacks
            ;;
    esac
}

try_fallbacks() {
    for term in gnome-terminal xfce4-terminal konsole xterm terminator alacritty tilix urxvt; do
        if command -v "$term" &> /dev/null; then
            echo "Launching fallback: $term"
            launch_terminal "$term"
            return
        fi
    done
    echo "No compatible terminal emulator found."
    exit 1
}

# Main launcher logic
if command -v "$terminal_cmd" &> /dev/null; then
    launch_terminal "$terminal_cmd"
else
    try_fallbacks
fi
