# Shell Notes

**Shell Notes** is a user-friendly terminal logging utility that gives you a clean, interactive interface to drop into shell sessions with full input/output logging. Whether you're auditing commands, studying terminal workflows, or keeping track of what you ran, **Shell Notes** makes logging simple and organized.

---

## 🧰 Features

- 🖥️ Fully interactive shell environment with session logging
- 📂 Timestamped log files organized and easy to access
- 🔍 Review logs with a searchable, numbered menu system
- 🗑️ Option to delete unwanted logs right from the interface
- 🧼 Clean interface with screen clearing between menus
- ⚙️ Ready on boot, waits silently until invoked

---

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

4. To uninstall, run the following:
   ```bash
   sudo ./uninstall.sh
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
