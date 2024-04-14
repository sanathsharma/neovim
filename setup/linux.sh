#!/bin/bash

#region utils
function install_package {
        if ! dpkg -l $1 | grep -q ^ii; then
					echo "Installing $1..."
					# If the package is not installed, install it using apt-get install
					sudo apt install $1
        fi
}
#endregion

# 1. ask for user consent to remove exiting tmux/nvim config if any
read -p "This script will remove exiting tmux/nvim config if present, do you wish to continue: (y/n): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
	echo "Aborting..."
	exit
fi

# 2. update and upgrade package manager
sudo apt update
sudo apt upgrade

# 3. install git and curl
# install if not already installed
install_package "git-all"
install_package "curl"

# 4. install tmux
# cleanup
sudo rm -rf ~/.config/tmux
sudo rm -rf ~/.tmux
# install if not already installed
install_package "tmux"

# 5. install tpm (tmux plugin manager)
# see https://github.com/tmux-plugins/tpm for more info
echo "Installing tmux plugin manager..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# 6. clone tmux config
echo "Setuping tmux config..."
git clone https://github.com/sanathsharma/tmux ~/.config/tmux

# 7. add tmux alias to ~/.bashrc
echo 'alias tmux="tmux -u"' >> ~/.bashrc

# 8. get user input if he/she wants to install nightly/latest version of nvim
read -p "Would you like to install \"nightly\" nvim build (y/n): " -n 1 -r
echo

# 9. curl for the nvim tarball
# cleanup
rm -f ./nvim-linux64.tar.gz
# see https://github.com/neovim/neovim/blob/master/INSTALL.md#linux for more info
if [[ $REPLY =~ ^[Yy]$ ]]; then
	echo
	echo "Downloading nightly nvim verison..."
	curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz
else
	echo
	echo "Downloading latest nvim verison..."
	curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
fi

# 10. install nvim
# cleanup
sudo rm -rf /opt/nvim
# installation
echo "Installing nvim..."
sudo tar -C /opt -xzvf ./nvim-linux64.tar.gz

# 11. add nvim to $PATH variable
echo 'export PATH="$PATH:/opt/nvim-linux64/bin"' >> ~/.bashrc

# 12. add nvim alias to ~/.bashrc
echo "alias vim=nvim" >> ~/.bashrc

# 13. delete nvim installation files tarball
sudo rm -rf nvim-linux64.tar.gz

# 14. install custom nvim config
# cleanup old installation
sudo rm -rf ~/.config/nvim
# clone repo
echo "Setuping nvim config..."
git clone https://github.com/sanathsharma/neovim-config ~/.config/nvim

# 15. install other external deps
# ripgrep for telescope file live grep
install_package "ripgrep"

echo "All Done!"
echo
echo "Close the terminal and reopen for the changes to reflect"

