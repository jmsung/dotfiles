#!/usr/bin/env bash

# Install CLI tools (cross-platform: macOS Homebrew + Linuxbrew)
brew install python
brew install tree

# GUI apps + fonts are macOS casks only (no --cask on Linuxbrew)
if [[ "$OSTYPE" == darwin* ]]; then
  brew install --cask google-chrome
  brew install --cask visual-studio-code
  brew install --cask font-source-code-pro
fi
