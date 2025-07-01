import subprocess
from os import system

spacesCmd = subprocess.run(["yabai", "-m", "query", "--spaces"], stdout=subprocess.PIPE)
spacesNumber = len(spacesCmd.stdout.decode("utf-8").split("{")) - 1


if spacesNumber < 10:
    queryFullscreen = subprocess.run(
        f"yabai -m query --spaces --space {spacesNumber}".split(" "),
        stdout=subprocess.PIPE,
    )
    isFullscreen = bool(
        '"is-native-fullscreen":true' in queryFullscreen.stdout.decode("utf-8")
    )

    subprocess.run("yabai -m space --create".split())

    finalSpace = spacesNumber if isFullscreen else spacesNumber + 1

    if system(f"yabai -m space --focus {finalSpace}"):
        system(
            f"yabai -m query --spaces --space {finalSpace}  | jq -r '.windows[0]' | xargs yabai -m window --focus"
        )
