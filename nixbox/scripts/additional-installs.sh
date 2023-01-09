
# zsh autosuggestions and syntax highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# copy the zshrc file please
cp .zshrc ~/.zshrc


# Install tiling manager. Kwin does not automatically active the script
# Go to System Settings » Shortcuts » Global Shortcuts » KWin and click activate
# git clone https://github.com/Jazqa/kwin-quarter-tiling.git
# plasmapkg2 --type kwinscript -i kwin-quarter-tiling
# mkdir -p ~/.local/share/kservices5
# ln -sf ~/.local/share/kwin/scripts/quarter-tiling/metadata.desktop ~/.local/share/kservices5/kwin-script-quarter-tiling.desktop
