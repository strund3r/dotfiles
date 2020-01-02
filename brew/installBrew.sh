#!/bin/bash

GREEN='\033[1;32m'
BACKGROUND='\e[0;39;41m'
NC='\033[0m' # No Color

# Install Xcode
echo -ne "\n${GREEN} Installing Xcode${NC}\n\n"
xcode-select --install

# Install Brew
echo -ne "\n\n${GREEN} Installing Brew${NC}\n\n"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"