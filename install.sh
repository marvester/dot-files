#!/bin/zsh

# install homebrew
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash

# install tools
brew install zsh git lazygit neovim bottom tree tmux typst sqlite jq deno kotlin

# install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

configure tmux
cp .tmux.conf ~

if [ ! -d ~/.tmux/plugins/tpm ]; then
  echo "tmux directory not found"
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm 
  ./~/.tmux/plugins/tpm/bin/install_plugins
else
  echo "tmux directory found"
  ~/.tmux/plugins/tpm/bin/install_plugins
fi

# zsh 
cp .zshrc ~
cp .p10k.zsh ~

# oh-my-zsh
/bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# oh-my-zsh plugins
ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}
echo 'zshcustom' $ZSH_CUSTOM $ZSH_THEME 

if [ ! -d $ZSH_CUSTOM/plugins/zsh-vi-mode ]; then
  git clone https://github.com/jeffreytse/zsh-vi-mode \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-vi-mode
else
  echo "zsh-vi-mode already installed"
fi

if [ ! -d $ZSH_CUSTOM/plugins/zsh-syntax-highlighting ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
else
  echo "zsh-syntax-highlighting already installed"
fi

if [ ! -d $ZSH_CUSTOM/plugins/zsh-autosuggestions ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
else
  echo "zsh-autosuggestions already installed"
fi

# install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
source ~/.zshrc

nvm install lts/hydrogen # 18
nvm install lts/iron # 20
nvm install lts/jod # 22

nvm use 22

# install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash
source ~/.zshrc

# astronvim
if [ ! -d ~/.config/nvim ]; then
  git clone git@github.com:marvester/astronvim_config.git ~/.config/nvim
else
  echo "NVIM config already exists. Not cloning astronvim"
fi

