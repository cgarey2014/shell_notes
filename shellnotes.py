from colorama import init, Fore, Style
import os
import subprocess
import time
import datetime
import re
import sys

init(autoreset=True)

log_dir = "/home/cosmo/terminal_logs"
if not os.path.exists(log_dir):
    os.makedirs(log_dir)

def clear_screen():
    os.system('clear')

# Check if we are in a terminal
def is_running_in_terminal():
    return os.isatty(sys.stdout.fileno())

def create_log_file():
    timestamp = datetime.datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
    return os.path.join(log_dir, f"LogFile_{timestamp}.log")

def start_shell(log_file):
    print(Fore.GREEN + f"Logging full shell session to: {log_file}")
    time.sleep(1)
    os.system(f'script -q -f {log_file}')
    print(Fore.RED + "Shell session ended. Returning to main menu.")
    time.sleep(2)
    clear_screen()
    show_main_menu()

def view_logs():
    log_files = [f for f in os.listdir(log_dir) if f.startswith("LogFile_")]
    if not log_files:
        print(Fore.RED + "No log files found.")
        time.sleep(2)
        return

    print(Fore.CYAN + "Available Log Files:")
    for i, filename in enumerate(log_files, 1):
        print(Fore.GREEN + f"{i}. {filename}")

    try:
        selection = int(input(Fore.YELLOW + "\nEnter the number of the log to view (0 to cancel): "))
        if selection == 0:
            print(Fore.RED + "Cancelled log selection.")
            time.sleep(1)
            return
        if selection < 1 or selection > len(log_files):
            print(Fore.RED + "Invalid selection.")
            time.sleep(1)
            return

        selected_log = log_files[selection - 1]
        log_path = os.path.join(log_dir, selected_log)

        with open(log_path, "r") as file:
            print(Fore.CYAN + "-" * 60)
            print(file.read())
            print(Fore.CYAN + "-" * 60)

        delete_option = input(Fore.YELLOW + "\nDo you want to delete this log? (y/n): ").strip().lower()
        if delete_option == 'y':
            os.remove(log_path)
            print(Fore.GREEN + f"Log file {selected_log} has been deleted.")
        else:
            print(Fore.RED + "Log file not deleted.")
        show_logs_menu()

    except ValueError:
        print(Fore.RED + "Invalid input. Please enter a number.")

def delete_log():
    while True:
        logs = sorted([f for f in os.listdir(log_dir) if f.endswith('.log')])
        if not logs:
            print(Fore.YELLOW + "No logs available for deletion.")
            time.sleep(2)
            return

        print(Fore.CYAN + "Available Logs for Deletion:")
        for idx, log_file in enumerate(logs, start=1):
            print(Fore.GREEN + f"{idx}. {log_file}")

        try:
            choice = input(Fore.CYAN + "\nEnter the number(s) of the logs to delete (e.g. 1, 2, 3. 0 to cancel): ").strip()
            if choice == "0":
                break
            # Handle deletion of multiple logs
            selected_choices = [int(x) for x in choice.split(",") if x.strip().isdigit()]
            if not selected_choices:
                print(Fore.RED + "No valid numbers entered.")
                continue

            selected_logs = [logs[i - 1] for i in selected_choices if 1 <= i <= len(logs)]
            if selected_logs:
                for log_to_delete in selected_logs:
                    os.remove(os.path.join(log_dir, log_to_delete))
                    print(Fore.RED + f"\nDeleted log file: {log_to_delete}")
            else:
                print(Fore.YELLOW + "Invalid choices. Please enter valid numbers.")
                continue
        except ValueError:
            print(Fore.YELLOW + "Invalid input. Please enter a number.")
            continue

        while True:
            next_action = input(Fore.CYAN + "\nWhat would you like to do next?\n" +
                                Fore.MAGENTA + "Type 'delete'" + Fore.CYAN + " to delete more logs\n" +
                                Fore.MAGENTA + "Type 'back'" + Fore.CYAN + " to return to logs menu\n" +
                                Fore.MAGENTA + "Type 'exit'" + Fore.CYAN + " to quit\n>>> ").strip().lower()
            if next_action == "delete":
                break
            elif next_action == "back":
                return
            elif next_action == "exit":
                sys.exit()
            else:
                print(Fore.YELLOW + "Invalid input.")

def highlight_keyword(line, keyword):
    return re.sub(f"({re.escape(keyword)})", Fore.RED + r"\1" + Style.RESET_ALL, line, flags=re.IGNORECASE)

def search_logs():
    while True:
        keyword = input(Fore.YELLOW + "Enter search keyword: ").strip()
        if not keyword:
            print(Fore.RED + "No keyword entered.")
            return

        results = []
        log_files = [f for f in os.listdir(log_dir) if f.startswith("LogFile_")]
        for file_name in log_files:
            file_path = os.path.join(log_dir, file_name)
            with open(file_path, "r") as file:
                for i, line in enumerate(file.readlines(), 1):
                    if keyword.lower() in line.lower():
                        results.append((file_name, i, line.strip()))

        if not results:
            print(Fore.RED + "No matches found.")
            return

        def show_results():
            clear_screen()
            print(Fore.CYAN + "\nSearch Results:")
            for idx, (fname, lineno, content) in enumerate(results, 1):
                highlighted = highlight_keyword(content, keyword)
                print(f"{idx}. {Fore.GREEN}{fname}{Style.RESET_ALL} (Line {lineno}): {highlighted}")

        show_results()

        while True:
            try:
                choice = input(Fore.YELLOW + "\nEnter result number to view (0 to cancel): ").strip()
                if choice == "0":
                    print(Fore.RED + "Cancelled.")
                    show_logs_menu()
                    return
                if not choice.isdigit():
                    raise ValueError
                choice = int(choice)
                if choice < 1 or choice > len(results):
                    raise ValueError

                selected_file, target_line, _ = results[choice - 1]
                file_path = os.path.join(log_dir, selected_file)
                with open(file_path, "r") as file:
                    lines = file.readlines()
                    start = max(0, target_line - 5)
                    end = min(len(lines), target_line + 5)
                    print(Fore.CYAN + "-" * 60)
                    for i in range(start, end):
                        line = highlight_keyword(lines[i].rstrip(), keyword)
                        prefix = ">>>" if i + 1 == target_line else "   "
                        print(f"{prefix} {i+1}: {line}")
                    print(Fore.CYAN + "-" * 60)
            except ValueError:
                print(Fore.RED + "Invalid input.")
                continue

            next_action = input(Fore.YELLOW + "\nWhat would you like to do next?\n"
                                "Type 'back' to return to logs menu\n"
                                "Type 'new' to enter a new keyword\n"
                                "Type 'results' to view search results again\n"
                                "Type 'exit' to quit\n>>> ").strip().lower()
            if next_action == "back":
                return
            elif next_action == "new":
                search_logs()
            elif next_action == "results":
                show_results()
            elif next_action == "exit":
                print(Fore.RED + "Exiting Terminal Logger.")
                exit()
            else:
                print(Fore.RED + "Unknown option.")

def show_main_menu():
    clear_screen()
    print(Fore.CYAN + "\nWelcome to Terminal Logger.")
    print(Fore.YELLOW + "Type 'shell'" + Fore.RESET + " to drop into a shell session.")
    print(Fore.YELLOW + "Type 'logs'" + Fore.RESET + " to list and manage logs.")
    print(Fore.RED + "Type 'exit'" + Fore.RESET + " to quit.")

    while True:
        choice = input(Fore.GREEN + "\nSelect an option: ").strip().lower()
        if choice == 'shell':
            log_file = create_log_file()
            start_shell(log_file)
        elif choice == 'logs':
            show_logs_menu()
        elif choice == 'exit':
            sys.exit()
        else:
            print(Fore.RED + "Invalid input, please try again.")

def show_logs_menu():
    while True:
        clear_screen()
        print(Fore.CYAN + "\n=== Log Management ===" + Style.RESET_ALL)
        print(Fore.YELLOW + "1." + Style.RESET_ALL + " View Logs")
        print(Fore.YELLOW + "2." + Style.RESET_ALL + " Delete Log")
        print(Fore.YELLOW + "3." + Style.RESET_ALL + " Search Logs")
        print(Fore.YELLOW + "4." + Style.RESET_ALL + " Back")
        choice = input(Fore.GREEN + "Select an option: ").strip()
        if choice == '1':
            view_logs()
        elif choice == '2':
            delete_log()
        elif choice == '3':
            search_logs()
        elif choice == '4':
            show_main_menu()
        else:
            print(Fore.RED + "Invalid selection.")
            time.sleep(1)

def main():
    clear_screen()
    show_main_menu()

if __name__ == "__main__":
    main()
