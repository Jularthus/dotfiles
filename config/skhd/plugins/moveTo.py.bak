from sys import argv
import subprocess
from os import system

arg = int(argv[1])

spacesCmd = subprocess.run(["yabai", "-m", "query", "--spaces"], stdout=subprocess.PIPE)
spacesNumber = len(spacesCmd.stdout.decode("utf-8").split("{")) - 1

if arg <= spacesNumber:
    if system(f"yabai -m space --focus {arg}"):
        system(
            f"yabai -m query --spaces --space {arg}  | jq -r '.windows[0]' | xargs yabai -m window --focus"
        )
else:
    for _ in range(arg - spacesNumber):
        system("yabai -m space --create")
    system(f"yabai -m space --focus {arg}")
