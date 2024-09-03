import subprocess

spacesCmd = subprocess.run(["yabai", "-m", "query", "--spaces"], stdout=subprocess.PIPE)
spacesNumber = len(spacesCmd.stdout.decode("utf-8").split("{")) - 1

from os import system

if spacesNumber < 10:
    system("yabai -m space --create")
    system(
        f"python3 /Users/jularthus/.config/skhd/plugins/moveTo.py {spacesNumber + 1}"
    )
