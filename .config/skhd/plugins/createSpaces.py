from sys import argv
arg = int(argv[1])
import subprocess
from os import system

spacesCmd = subprocess.run(["yabai", "-m", "query", "--spaces"], stdout=subprocess.PIPE)
spacesNumber = len(spacesCmd.stdout.decode('utf-8').split('{')) -1

if(arg<=spacesNumber):
    system(f"yabai -m window --space {arg}")
else:
    for _ in range(arg-spacesNumber):
        system(f"yabai -m space --create")
    system(f"yabai -m window --space {arg}")