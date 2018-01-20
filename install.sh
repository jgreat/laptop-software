#!/bin/bash

pkgdir="${HOME}/pkgs"
gitdir="${HOME}/git"

mkdir $pkgdir
mkdir $gitdir

# vscode code
curl -o $pkgdir/vscode.deb https://go.microsoft.com/fwlink/?LinkID=760868
sudo dpkg -i $pkgdir/vscode.deb

# chrome google-chrome-stable
curl -o $pkgdir/google-chrome-stable.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i $pkgdir/google-chrome-stable.deb

# zoom
curl -o $pkgdir/zoom_amd64.deb https://zoom.us/client/latest/zoom_amd64.deb
sudo dpkg -i $pkgdir/zoom_amd64.deb

# slack
sudo snap install slack --classic

# enpass enpass
sudo sh -c 'echo "deb http://repo.sinew.in/ stable main" > /etc/apt/sources.list.d/enpass.list'
wget -O - https://dl.sinew.in/keys/enpass-linux.key | sudo apt-key add -

# nodejs
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -

# # Install repo packages.
# # update is doen in node install
sudo apt install -y enpass vim zsh nodejs

# Install Nerd fonts
fontdir="${HOME}/.fonts"
mkdir $fontdir
curl -sSL -o $fontdir/Fura_Mono_Regular_Nerd_Font_Complete_Mono.otf "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraMono/Regular/complete/Fura%20Mono%20Regular%20Nerd%20Font%20Complete%20Mono.otf"
curl -sSL -o $fontdir/Fura_Mono_Regular_Nerd_Font_Complete.otf "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraMono/Regular/complete/Fura%20Mono%20Regular%20Nerd%20Font%20Complete.otf"
sudo fc-cache -fv

# Set up npm to install globally in home dir.
nodedir="${HOME}/.node"
mkdir $nodedir
npm config set prefix /home/jgreat/.node

echo 'PATH="${HOME}/.node/bin:${PATH}"' >> ~/.profile
echo 'NODE_PATH="${HOME}/.node/lib/node_modules:${NODE_PATH}"' >> ~/.profile
echo 'MANPATH="${HOME}/.node/share/man:${MANPATH}"' >> ~/.profile

. ~/.profile

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install spaceship theme
git clone https://github.com/denysdovhan/spaceship-prompt.git $gitdir/spaceship-prompt
cd $gitdir/spaceship-prompt
# npm install -g

cd $HOME

# Dell XPS 15 (9560)
# gnome-shell-extension-appindicator
# indicator-sensors
# lm-sensors