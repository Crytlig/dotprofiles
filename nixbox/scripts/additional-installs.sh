#!/bin/bash

PLUGINS_DIR=~/repos/plugins
mkdir -p ${PLUGINS_DIR}

# zsh autosuggestions and syntax highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# copy the zshrc file please
cp .zshrc ~/.zshrc

# Install tiling manager. Kwin does not automatically active the script
# Go to System Settings » Shortcuts » Global Shortcuts » KWin and click activate
KWIN="kwin-quarter-tiling"
git clone https://github.com/Jazqa/kwin-quarter-tiling.git ${PLUGINS_DIR}/${KWIN}
cd ${PLUGINS_DIR}/${KWIN}
./install.sh
#plasmapkg2 --type kwinscript -i kwin-quarter-tiling
cd -
# mkdir -p ~/.local/share/kservices5
# ln -sf ~/.local/share/kwin/scripts/quarter-tiling/metadata.desktop ~/.local/share/kservices5/kwin-script-quarter-tiling.desktop


# Packer for neovim
cd ${PLUGINS_DIR}
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
cd -
