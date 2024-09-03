from sys import argv
arg = argv[1]
arg = '"' + arg + '"'
import subprocess
from os import system

windowsCmd = subprocess.run(["yabai", "-m", "query", "--windows"], stdout=subprocess.PIPE)
windowsList = windowsCmd.stdout.decode('utf-8').split('},{')

for i in windowsList:
    if i.split('"app":')[1].split(",")[0] == arg:
        system(f'yabai -m window --focus {i.split('"id":')[1].split(",")[0]}')