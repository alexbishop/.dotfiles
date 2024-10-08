local fn = vim.fn

-- automatically install packer using git
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end
packer.util = require('packer.util')

-- Autocommand that reloads neovim whenever you save the plugins.lua file
-- vim.cmd([[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost plugins.lua source <afile> | PackerSync
--   augroup end
-- ]])

local function file_exists(name)
  local f = io.open(name, "r")
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end

if file_exists(packer.util.join_paths(vim.fn.stdpath('config'), 'packer.nvim', 'stable')) then
  packer.init({
    snapshot = 'stable',
    snapshot_path = packer.util.join_paths(vim.fn.stdpath('config'), 'packer.nvim'),
    display = {
      open_fn = function()
        return require("packer.util").float({ border = "rounded" })
      end,
    },
  })
else
  packer.init({
    display = {
      open_fn = function()
        return require("packer.util").float({ border = "rounded" })
      end,
    },
  })
end

-- Install your plugins here
return packer.startup(function(use)
  -- have packer manager itself
  use({ "wbthomason/packer.nvim" })

  -- neovim look
  use({
    "goolord/alpha-nvim",
    requires = { 'nvim-tree/nvim-web-devicons' },
  })
  use({ "akinsho/bufferline.nvim" })
  use({ "kyazdani42/nvim-tree.lua" })
  use({ "kyazdani42/nvim-web-devicons" })
  use({ "nvim-lualine/lualine.nvim" })

  -- helps you remember your bindings
  use({ "folke/which-key.nvim", commit = "0539da005b98b02cf730c1d9da82b8e8edb1c2d2" })

  -- colorschemes
  use("LunarVim/Colorschemes")
  use("catppuccin/nvim")
  use("folke/tokyonight.nvim")

  -- latex
  use({ "lervag/vimtex" }) --, tag = "v2.15" })

  -- more advanced undos
  use({ "mbbill/undotree" })

  -- get lsp and completion working
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = "v3.x",
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },

      -- Snippets
      { 'L3MON4D3/LuaSnip',                 run = "make install_jsregexp" },
      { 'rafamadriz/friendly-snippets' },
    }
  }

  -- toggle commented lines
  use({ "numToStr/Comment.nvim" })

  -- add some nice support for zigland
  use({ "ziglang/zig.vim" })

  -- keep for now
  use({ "moll/vim-bbye" })
  use({ "lukas-reineke/indent-blankline.nvim" })

  -- Telescope
  use({ "nvim-telescope/telescope.nvim" --, tag = "0.1.2"
  })
  use({ "ahmedkhalf/project.nvim" })

  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
  })

  -- I use this to run cmake
  use({ "Shatur/neovim-tasks", requires = "nvim-lua/plenary.nvim", commit = "12fbbff7e91b1d07498f0574505e9d48baa9d7bf" })

  use({
    "danymat/neogen",
    config = function()
      require("neogen").setup({})
    end,
    requires = "nvim-treesitter/nvim-treesitter",
  })

  -- Autopairs, integrates with both cmp and treesitter
  -- use({ "windwp/nvim-autopairs" })

  -- Git
  use({ "lewis6991/gitsigns.nvim" })

  use({
    'Julian/lean.nvim',
    -- event = { 'BufReadPre *.lean', 'BufNewFile *.lean' },

    requires = {
      'neovim/nvim-lspconfig',
      'nvim-lua/plenary.nvim',
      'hrsh7th/nvim-cmp', -- For LSP completion
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/vim-vsnip',             -- For snippets
      'andrewradev/switch.vim',        -- For Lean switch support
      -- 'tomtom/tcomment_vim',         -- For commenting motions
      'nvim-telescope/telescope.nvim', -- For Loogle search
      -- you also will likely want nvim-cmp or some completion engine
    },
  })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
