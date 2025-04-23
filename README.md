# Shell Notes

Shell Notes is a simple Python application that allows you to drop into a terminal shell session and logs the input/output to a file.

## Installation

1. Clone the repository:
    ```bash
    git clone https://github.com/yourusername/shell_notes.git
    cd shell_notes
    ```

2. Run the installation script:
    ```bash
    sudo ./install.sh
    ```

3. After installation, you can run the program by typing:
    ```bash
    shellnotes
    ```

## Usage

- Type `shellnotes` in your terminal to open a new terminal window and start a logging session.
- Type `exit` to exit the session and end logging.

Logs will be saved in `/home/user/shell_notes_logs` by default.

## Requirements

- Python 3.x
- Terminal emulator that supports commands like `gnome-terminal`, `xfce4-terminal`, etc.
