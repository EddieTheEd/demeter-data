import os
import sys
import subprocess

def find_large_files(folder_path, size_limit_mb):
    large_files = []
    for foldername, subfolders, filenames in os.walk(folder_path):
        for filename in filenames:
            file_path = os.path.join(foldername, filename)
            file_size_mb = os.path.getsize(file_path) / (1024 * 1024)  # Convert to MB
            if file_size_mb > size_limit_mb:
                large_files.append((file_path, file_size_mb))
                print(f"File '{file_path}' is {file_size_mb:.2f} MB")
    return large_files

def run_shell_command(command):
    try:
        result = subprocess.run(command, shell=True, capture_output=True, text=True)
        if result.returncode == 0:
            return result.stdout.strip()
        else:
            print("Error running shell command:", result.stderr)
    except Exception as e:
        print("Error running shell command:", e)

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python3 script.py <folder_path> <size_limit_mb>")
        sys.exit(1)

    folder_path = sys.argv[1]
    size_limit_mb = float(sys.argv[2])

    if not os.path.isdir(folder_path):
        print("Invalid folder path.")
        sys.exit(1)

    large_files = find_large_files(folder_path, size_limit_mb)

    # Run the desired shell command
    command = "git ls-files --exclude-standard --others --directory | xargs -d '\n' -r du -ch | awk 'END {print $1, $2, $3, $4}'"
    print("Unstaged files:")
    command_output = run_shell_command(command)
    if command_output:
        print(command_output)
