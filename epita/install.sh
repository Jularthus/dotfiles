#!/bin/sh

nix profile install nixpkgs#zsh

dot_list="bashrc config emacs gitconfig gitignore jnewsrc mozilla msmtprc muttrc signature slrnrc ssh thunderbird vim vimrc Xdefaults zshrc"

for f in $dot_list; do
  rm -rf "$HOME/.$f"
  ln -s "$AFS_DIR/.confs/$f" "$HOME/.$f"
done

rm -rf "$HOME/installCustom.sh"
cp "$AFS_DIR/.confs/installCustom.sh" "$HOME/installCustom.sh"
