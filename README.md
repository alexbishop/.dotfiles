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

## Requirement

### Neovim

To make the most of my neovim configuration, you should install `ripgrep` (which is used by the Telescope plugin), and `luarocks` which is needed to install the Lua lsp that my neovim config will attempt to automatically install.

You will also need `git`, and likely a c/c++ compiler (needed for some of the treesitter and lsp plugins) installed as well (I assume this is not a problem).

### Nerd Font

My configuration for `foot`, `tmux`  and `neovim` both require the terminal font to be a [Nerd Font](https://www.nerdfonts.com/) to work. You can get this from [here](https://github.com/ryanoasis/nerd-fonts/releases/tag/v2.3.3). DO NOT install version 3 of this font, it will likely not work (they updated a lot of the glyphs in version 3).

To install Hack Nerd Font (as is used in my dotfiles), you can follow these steps:

 1. Download `Hack.zip` from [here](https://github.com/ryanoasis/nerd-fonts/releases/tag/v2.3.3)
 2. Unzip it into `~/.local/share/fonts/Hack`
 3. from the terminal run `fc-cache -fv` to load the new font 
 4. verify that the font is installed by running `fc-list | grep Hack`
 5. Set `Hack Nerd Font` as your terminal font (if you use foot terminal, you can use my config)

If you prefer a different Nerd font, then install that and set it as your terminal font instead.

### FontAwesome

My configuration for waybar also requires FontAwesome v6 to work correctly.

To install FontAwesome
 
 1. Download the fonts from the `Free for Desktop` link on [FontAwesome's website](https://fontawesome.com/download).
 2. unzip them into `~/.local/share/fonts/FontAwesome`
 3. from the terminal run `fc-cache -fv` to load the new font 
 4. verify that the font is installed by running `fc-list | grep FontAwesome`

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
