# Personal Dotfiles

These are some of the dotfiles I used on my machine. I am keeping them here on Github for future reference.

Make sure to download all submodules when you clone this repo, i.e., run

```sh
git clone --recurse-submodules https://github.com/alexbishop/.dotfiles
```
or
```sh
git clone https://github.com/alexbishop/.dotfiles
cd .dotfiles
git submodule init
git submodule update
```

## Quickstart

 1. run `fresh-install-root.sh` as the root user (make sure to select `ssdm` as your display manager when prompted)
 2. run `fresh-install-user.sh` as the user
 3. reboot
 4. run `nvim` in the terminal and wait for everything to download and install
 5. run `tmux`, then press `C-b` followed by `I` and wait for things to install

## Installation

### neovim

After placing the dotfiles in `.config/nvim`

 1. run `nvim` and wait for packer to install all the new packages, then close neovim.
 2. open `nvim` again, and wait for it to install all the treesitter packages and lsps.
    * run `:messages` to check the progress of treesitter; and
    * run `:Mason` to check the progress of the lsp installs.
 3. After the installs finish, restart neovim to ensure that changes take effect

### tmux

Open tmux, press `C-b`, then `I` (in sequence, not together). Tmux will then download the packages.
After this, restart tmux to make sure the changes take effect.
