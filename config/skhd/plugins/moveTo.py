from sys import argv
import subprocess
from os import system

arg = int(argv[1])

spacesCmd = subprocess.run(["yabai", "-m", "query", "--spaces"], stdout=subprocess.PIPE)
spacesNumber = len(spacesCmd.stdout.decode("utf-8").split("{")) - 1

for _ in range(arg - spacesNumber):
    system("yabai -m space --create")

queryFullscreen = subprocess.run(
    f"yabai -m query --spaces --space {arg}".split(" "), stdout=subprocess.PIPE
)
isFullscreen = bool(
    '"is-native-fullscreen":true' in queryFullscreen.stdout.decode("utf-8")
)

finalSpace = arg - 1 if arg > spacesNumber and isFullscreen else arg

if system(f"yabai -m space --focus {finalSpace}"):
    system(
        f"yabai -m query --spaces --space {finalSpace}  | jq -r '.windows[0]' | xargs yabai -m window --focus"
    )
