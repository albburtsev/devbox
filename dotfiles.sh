#!/bin/bash

# Based on https://github.com/sapegin/dotfiles/blob/master/install/install.sh

echo "Installing dotfiles..."

cd ~ && git clone https://github.com/albburtsev/devbox.git && cd devbox/dotfiles && python sync.py

echo "Dotfiles installed successfully."