#!/bin/bash

GREEN='\033[1;32m'
BACKGROUND='\e[0;39;41m'
NC='\033[0m' # No Color

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     # Install Brew
                echo -ne "\n\n${GREEN} Installing Brew${NC}\n\n"
                /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
                exit 0;;
    Darwin*)    # Install Xcode
                echo -ne "\n${GREEN} Installing Xcode${NC}\n\n"
                xcode-select --install
                # Install Brew
                echo -ne "\n\n${GREEN} Installing Brew${NC}\n\n"
                /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
                exit 0;;
esac