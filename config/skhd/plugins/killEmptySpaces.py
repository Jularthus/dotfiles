# USE THIS VERSION
import subprocess
from os import system

spacesCmd = subprocess.run(["yabai", "-m", "query", "--spaces"], stdout=subprocess.PIPE)
splitedOut = spacesCmd.stdout.decode("utf-8").split('"first-window":')
index = -1
for i in splitedOut:
    index += 1
    if i[0] == "0":
        system(f"yabai -m space {index} --destroy")
        index -= 1


# DEPRECATED OLD VESRION
# import subprocess
# from os import system

# spacesCmd = subprocess.run(["yabai", "-m", "query", "--spaces"], stdout=subprocess.PIPE)
# splitedOut = spacesCmd.stdout.decode("utf-8").split('windows":[')
# index = -1
# for i in splitedOut:
#     index += 1
#     if i[0] == "]":
#         system(f"yabai -m space {index} --destroy")
#         index -= 1
