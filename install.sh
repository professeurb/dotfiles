#! /bin/bash

xcode-select --install

curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh

brew install fish fisher kitty
brew install yabai skhd

brew install jesseduffield/lazygit/lazygit

# OCaml
brew install gpatch
brew install opam

opam init
opam install --yes merlin utop ocp-indent dune ocamlformat ocaml-lsp-server

# LaTeX
brew cask install mactex
brew install texlab

brew install youtube-dl ffmpeg opus opus-tools

