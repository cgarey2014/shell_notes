# Shell Notes

**Shell Notes** is a lightweight Python utility designed to launch an interactive terminal shell session while automatically capturing and logging all input and output to a local file. It also provides tools to review, list, and search through these logs for easy analysis. This makes it particularly valuable for system administrators, educators, and cybersecurity professionals who require an auditable and searchable record of command-line activity

## Features

- Launches a shell session in a new terminal window
- Captures and logs the full session (input/output) to a file
- Automatically stores logs in a dedicated directory
- Lightweight and easy to use
- Ability to review, search and delete logs

## Installation

1. Clone the repository:

    ```bash
    git clone https://github.com/cgarey2014/shell_notes.git
    cd shell_notes
    ```

2. Run the installation script:

    ```bash
    sudo ./install.sh
    ```

3. After installation, run the program using:

    ```bash
    shellnotes
    ```


## Usage

To start a new session:

```bash
shellnotes
```
- A new terminal window will launch.
- Your full shell session will be recorded.
- To end the session, type:
```bash
exit
```

Requirements

- Python 3.x
- A supported terminal emulator (e.g., gnome-terminal, xfce4-terminal, xterm)
