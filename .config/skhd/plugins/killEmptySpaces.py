import subprocess
from os import system

print('')

spacesCmd = subprocess.run(["yabai", "-m", "query", "--spaces"], stdout=subprocess.PIPE)
splitedOut = spacesCmd.stdout.decode('utf-8').split('windows":[')
index = -1
for i in splitedOut:
    index+=1
    if(i[0] == ']'):
        system(f'yabai -m space {index} --destroy')
        index-=1