#!/bin/bash
#this script installs a number of tools for ethereum developers
#script by no_data_here <error.404.no.data.here@gmail.com>

#add etherium ppa and make sure that all software installed via apt is prepared, relies on apt to handle things if packages already exist
sudo apt install -y build-essential software-properties-common;
sudo add-apt-repository ppa:ethereum/ethereum;
sudo apt update;
sudo apt upgrade -y;
sudo apt update;
sudo apt upgrade -y;
sudo apt install -y solc npm git geth;

#install rust via rustup
rustup_path=/home/$USER/.cargo/bin/rustup; #check for rustup rust installation in this location
if [ $(command -v rustup) = $rustup_path ]; then
echo "Installing Rust";
curl https://sh.rustup.rs -sSf | sh;
else
echo "Rust already installed";
fi

#install parity
if [ $(command -v parity) != /usr/bin/parity ]; then
echo "Installing Parity";
bash <(curl https://get.parity.io -Lk)
else
echo "Parity already installed";
fi

#install nvm via method reccommended at https://github.com/creationix/nvm#installation

if[ $(command -v nvm) = "nvm" ]; then
nvm_preinstalled=1;
else
nvm_preinstalled=0;
fi

if[ $nvm_preinstalled -eq 0 ]; then
echo "Installing NVM";
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash;
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" ;
else
echo "NVM already installed";
fi


#install latest nodejs or update
if[ $nvm_preinstalled -eq 0 ]; then
echo "Installing Node";
nvm install node;
else
echo "Node already installed, making sure it's up to date";
nvm install node --reinstall-packages-from=node;
fi
#install web3
if[[ $(npm list web3) = *"empty"* ]]; then
npm install web3;
fi
#install ganache-cli
if[[ $(npm list -g ganache-cli) = *"empty"* ]]; then
npm install -g ganache-cli;
fi
#install truffle suite/debugger
if[[ $(npm list -g truffle) = *"empty"* ]]; then
npm install -g truffle;
fi
#update all local and global npm installations
npm update;
npu update -g;

#clones workshops from http://github.com/utdcrypto to folders named by date of workshops, relies on git skipping repos where folder already exists
wget -qO- https://raw.githubusercontent.com/utdcrypto/EthDevTools/master/cloneworkshops.sh | bash;

exit;
