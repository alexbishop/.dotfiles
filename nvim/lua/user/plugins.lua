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

  {
    "folke/tokyonight.nvim",
    config = function() pcall(vim.cmd.colorscheme, "tokyonight-night") end,
  },

  -- tree sitter

  {
    "nvim-treesitter/nvim-treesitter",
    config = function() require("user.setup.treesitter") end,
  },


  -- Support for language servers

  {
    "L3MON4D3/LuaSnip",
    run = "make install_jsregexp",
    requires = {
      "rafamadriz/friendly-snippets",
    },
  },

  -- support for Mason which can be used to unstall language servers

  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v4.x",
    requires = {
      -- lsp stuff
      "neovim/nvim-lspconfig",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",

      -- mason
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",

      -- snippets
      "hrsh7th/cmp-buffer",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip"
    },
    config = function() require("user.setup.lsp") end,
  },


  -- support for whichkeys

  {
    "folke/which-key.nvim",
    tag = "v3.15.0",
    requires = {
      "mbbill/undotree",
      "moll/vim-bbye",
      "drybalka/tree-climber.nvim",
    },
    config = function() require("user.setup.which-key") end,
  },


  -- Git interactions

  {
    "lewis6991/gitsigns.nvim",
    config = function() require('gitsigns').setup() end,
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
    "kyazdani42/nvim-tree.lua",
    requires = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function() require("user.setup.nvim-tree") end
  },

  -- ziglang

  {
    "ziglang/zig.vim",
    config = function()
      vim.cmd("let g:zig_fmt_autosave = 0")
    end
  },

  -- latex

  {
    "lervag/vimtex",
    config = function()
      vim.cmd("let g:vimtex_view_method = 'zathura'")
      vim.cmd("let g:vimtex_syntax_enabled = 0")
      vim.cmd("let g:vimtex_compiler_method = 'latexmk'")
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
    "ahmedkhalf/project.nvim",
    requires = {
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("project_nvim").setup()
      require("telescope").load_extension("projects")
    end,
  },


  {
    "Julian/lean.nvim",
    requires = {
      "neovim/nvim-lspconfig",
      "nvim-lua/plenary.nvim",
      -- 'andymass/vim-matchup',          -- for enhanced % motion behavior
      "andrewradev/switch.vim",        -- For Lean switch support
      -- 'tomtom/tcomment_vim',         -- For commenting motions
      "nvim-telescope/telescope.nvim", -- For Loogle search
      "hrsh7th/nvim-cmp",              -- For LSP completion
    },
    config = function()
      require("lean").setup({ mappings = true })
    end

  },

})
