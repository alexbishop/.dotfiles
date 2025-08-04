local function bootstrap_pckr()
  local pckr_path = vim.fn.stdpath("data") .. "/pckr/pckr.nvim"

  if not (vim.uv or vim.loop).fs_stat(pckr_path) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/lewis6991/pckr.nvim",
      pckr_path
    })
  end

  vim.opt.rtp:prepend(pckr_path)
end

bootstrap_pckr()

local pckr = require("pckr")

pckr.setup({
  lockfile = {
    path = vim.fn.stdpath("config") .. "/pckr/lockfile.lua"
  }
})

pckr.add({

  -- color scheme

  { "catppuccin/nvim",
  },
  {
    "folke/tokyonight.nvim",
    config = function() pcall(vim.cmd.colorscheme, "tokyonight") end,
  },

  -- tree sitter

  {
    "nvim-treesitter/nvim-treesitter",
    tag = "v0.10.0",
    config = function() require("user.setup.treesitter") end,
  },


  -- Support for language servers

  {
    "L3MON4D3/LuaSnip",
    tag = "v2.4.0",
    run = "make install_jsregexp",
    requires = {
      "rafamadriz/friendly-snippets",
    },
  },

  -- support for Mason which can be used to install language servers

  {
    "neovim/nvim-lspconfig",
    requires = {
      -- cmp stuff
      "hrsh7th/nvim-cmp",
      "L3MON4D3/LuaSnip",

      -- snippets
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "https://codeberg.org/FelipeLema/cmp-async-path.git",
      "windwp/nvim-autopairs",

      -- mason
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function() require("user.setup.lsp") end,
  },


  -- support for whichkeys

  "mbbill/undotree",
  "moll/vim-bbye",
  "drybalka/tree-climber.nvim",

  {
    "folke/which-key.nvim",
    tag = "v3.17.0",
    config = function() require("which-key").setup() end,
  },


  -- Git interactions

  {
    "lewis6991/gitsigns.nvim",
    config = function() require("gitsigns").setup() end,
  },

  -- UI

  {
    "akinsho/bufferline.nvim",
    requires = {
      "moll/vim-bbye",
    },
    config = function() require("user.setup.bufferline") end,
  },

  {
    "nvim-tree/nvim-web-devicons",
    requires = {
      "echasnovski/mini.icons",
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    requires = {
      "nvim-tree/nvim-web-devicons",
      "akinsho/bufferline.nvim",
    },
    config = function() require("user.setup.lualine") end,
  },


  {
    "goolord/alpha-nvim",
    requires = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function() require("user.setup.alpha") end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    requires = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function() require("user.setup.nvim-tree") end
  },

  -- ziglang

  {
    "ziglang/zig.vim",
    config = function()
      vim.g.zig_fmt_autosave = 0
    end
  },

  -- latex

  {
    "lervag/vimtex",
    config = function()
      vim.g.vimtex_view_method = "zathura"
      vim.g.vimtex_syntax_enabled = 0
      vim.g.vimtex_compiler_method = "latexmk"
    end
  },

  -- Telescope

  {
    "nvim-telescope/telescope.nvim",
    requires = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
      "nvim-lua/plenary.nvim",
    },
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    config = function() require("ibl").setup() end,
  },

  {
    "Julian/lean.nvim",
    requires = {
      "neovim/nvim-lspconfig",
      "nvim-lua/plenary.nvim",
      "andymass/vim-matchup",          -- for enhanced % motion behavior
      "andrewradev/switch.vim",        -- For Lean switch support
      -- 'tomtom/tcomment_vim',         -- For commenting motions
      "lewis6991/satellite.nvim",
      "nvim-telescope/telescope.nvim", -- For Loogle search
      "hrsh7th/nvim-cmp",              -- For LSP completion
    },
    config = function()
      local lean = require("lean");
      -- update the c to C so it doesn't interfear with the close buffer keymap
      for i, v in ipairs(lean.mappings) do
        if v[1] == "<LocalLeader>c" then
          lean.mappings[i][1] = "<LocalLeader>C"
        end
      end
      lean.setup({ mappings = true })
    end

  },

})
