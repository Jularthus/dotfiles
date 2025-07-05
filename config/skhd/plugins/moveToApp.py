from sys import argv
import subprocess
from os import system

arg = argv[1]
arg = '"' + arg + '"'

windowsCmd = subprocess.run(
    ["yabai", "-m", "query", "--windows"], stdout=subprocess.PIPE
)
windowsList = windowsCmd.stdout.decode("utf-8").split("},{")

for i in windowsList:
    print(i.split('"is-visible":')[1].split(",")[0])
    if (i.split('"app":')[1].split(",")[0] == arg) and (
        i.split('"is-minimized":')[1].split(",")[0] == "false"
    ):
        system(f"yabai -m window --focus {i.split('"id":')[1].split(',')[0]}")
