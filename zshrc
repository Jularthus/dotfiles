export ZSH="$HOME/.oh-my-zsh"
DISABLE_UPDATE_PROMPT=true # Auto update

ZSH_THEME="bigpathblue"

plugins=(git)

source $ZSH/oh-my-zsh.sh

if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='lvim'
fi

# path
export PATH=$HOME/.local/bin:$PATH

#alias 
alias cls="clear"
alias gc="git commit -m"
alias ga="git add -A"
alias gl="git log" 
alias gp="git push"
alias gs="git status"
alias gd="git diff HEAD^ HEAD"
alias lv=lvim
alias r="ranger ."
alias pv="qlmanage -p"
alias ncat="netcat"
alias cat="bat --paging=never --plain"
alias :q=exit

alias fortuneStart="sshfs -o reconnect -p 8022 jularthus@jularthus.fr:/home/jularthus/AuCoin/fortune ~/.config/fortune"
alias fortuneStop="umount -f ~/.config/fortune"

gacp() {
  cd $(git rev-parse --show-toplevel)

  git add -A
  echo -n "Enter commit name: "
  read commitName
  git commit -m "$commitName"
  git push
}

function devdocker() {
    if [ $# -eq 0 ]; then
        docker run --platform linux/amd64 --cap-add=SYS_PTRACE --security-opt seccomp=unconfined -it --rm -v "$(pwd)":/app dev-env-docker
    else
        if [ "$1" = "check" ] && [ -n "$2" ]; then
            docker run --platform linux/amd64 --rm -v "$(pwd)":/app dev-env-docker sh -c "valgrind --leak-check=full --show-leak-kinds=all ./$2"
        else
            docker run --platform linux/amd64 --rm -v "$(pwd)":/app dev-env-docker sh -c "$*"
        fi
    fi
}
alias dd=devdocker

#AFS
afs() {
  kinit -f jules-arthus.klein@CRI.EPITA.FR
  cd ~
  sshfs -o reconnect -o volname=afs jules-arthus.klein@ssh.cri.epita.fr:/afs/cri.epita.fr/user/j/ju/jules-arthus.klein/u/ afs
  cd ~/afs
}
