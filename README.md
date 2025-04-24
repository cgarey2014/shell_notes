<div align="center">
<pre>
  █████████  █████               ████  ████  ██████   █████           █████                    
 ███░░░░░███░░███               ░░███ ░░███ ░░██████ ░░███           ░░███                     
░███    ░░░  ░███████    ██████  ░███  ░███  ░███░███ ░███   ██████  ███████    ██████   █████ 
░░█████████  ░███░░███  ███░░███ ░███  ░███  ░███░░███░███  ███░░███░░░███░    ███░░███ ███░░  
 ░░░░░░░░███ ░███ ░███ ░███████  ░███  ░███  ░███ ░░██████ ░███ ░███  ░███    ░███████ ░░█████ 
 ███    ░███ ░███ ░███ ░███░░░   ░███  ░███  ░███  ░░█████ ░███ ░███  ░███ ███░███░░░   ░░░░███
░░█████████  ████ █████░░██████  █████ █████ █████  ░░█████░░██████   ░░█████ ░░██████  ██████ 
 ░░░░░░░░░  ░░░░ ░░░░░  ░░░░░░  ░░░░░ ░░░░░ ░░░░░    ░░░░░  ░░░░░░     ░░░░░   ░░░░░░  ░░░░░░  
                                                                                               
                                                                                               
</pre>
</div>

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

## 📦 [Download ShellNotes v1.0](https://github.com/cgarey2014/shell_notes/releases/tag/v1.0) *(right-click and open in new tab)*

---

## 🚀 Installation

1. **Download and unzip the release archive:**
   ```bash
   unzip shellnotes-v1.0.zip
   cd shellnotes-release
   ```
2. **Run the installation script:**

   ```bash
   sudo ./install.sh
   ```

4. **Launch ShellNotes with:**

   ```bash
   shellnotes
   ```

## 🗑️ To uninstall ShellNotes:

   ```bash
   sudo ./scripts/uninstall.sh
   ```

## 🖥️ Usage
**To start a new shell session with ShellNotes:**

   ```bash
   shellnotes
   ```

- A new terminal window will launch.

- Your full shell session will be recorded to a timestamped .cast file using asciinema.

**To end the session, simply type:**

   ```bash
   exit
   ```

## 📋 Requirements
- Python 3.x

- A supported terminal emulator:

  - gnome-terminal

  - xfce4-terminal

  - xterm

  - konsole (if installed)

## ℹ️ ShellNotes is a minimalist terminal session recorder designed for cybersecurity professionals, educators, and students to document shell activity with clean and portable log files.
