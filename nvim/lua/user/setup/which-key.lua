local wk = require("which-key")
wk.setup();

local mappings = {
  {
    "<leader>a",
    "<cmd>Alpha<cr>",
    desc = "Alpha",
  },
  {
    "<leader>b",
    function() require("telescope.builtin").buffers(require("telescope.themes").get_dropdown({ previewer = false })) end,
    desc = "Buffers",
  },
  {
    "<leader>e",
    "<cmd>NvimTreeToggle<cr>",
    desc = "Explorer"
  },
  {
    "<leader>c",
    "<cmd>Bdelete!<CR>",
    desc = "Close Buffer"
  },
  {
    "<leader>h",
    "<cmd>nohlsearch<CR>",
    desc = "No Highlight"
  },
  {
    "<leader>f",
    function() require("telescope.builtin").find_files(require("telescope.themes").get_dropdown({ previewer = false })) end,
    desc = "Find files",
  },
  {
    "<leader>F",
    "<cmd>Telescope live_grep theme=ivy<cr>",
    desc = "Find Text"
  },
  {
    "<leader>P",
    function() require("telescope").extensions.projects.projects() end,
    desc = "Projects"
  },


  {
    "<leader>u",
    "<cmd>UndotreeToggle<cr>",
    desc = "Toggle Undotree"
  },

  -- Group: tree-climber

  {
    "gt",
    group = "Tree climber",
    mode = { "n", "v", "o" }
  },

  {
    "gth",
    require("tree-climber").goto_parent,
    desc = "Go to parent",
    mode = { "n", "v", "o" }
  },
  {
    "gtl",
    require("tree-climber").goto_child,
    desc = "Go to child",
    mode = { "n", "v", "o" }
  },
  {
    "gtj",
    require("tree-climber").goto_next,
    desc = "Go to next",
    mode = { "n", "v", "o" }
  },
  {
    "gtk",
    require("tree-climber").goto_prev,
    desc = "Go to previous",
    mode = { "n", "v", "o" }
  },

  {
    "gt<c-k>",
    require("tree-climber").swap_prev,
    desc = "Swap with previous",
    mode = { "n" }
  },
  {
    "gt<c-j>",
    require("tree-climber").goto_next,
    desc = "Swap with next",
    mode = { "n" }
  },
  {
    "gt<c-h>",
    require("tree-climber").highlight_node,
    desc = "Highlight node",
    mode = { "n" }
  },

  -- Group: LSP

  { "<leader>l", group = "LSP" },
  {
    "<leader>la",
    function() vim.lsp.buf.code_action() end,
    desc = "Code Action"
  },
  {
    "<leader>ld",
    "<cmd>Telescope diagnostics bufnr=0<cr>",

    desc = "Document Diagnostics",
  },
  {
    "<leader>lw",
    "<cmd>Telescope diagnostics<cr>",
    desc = "Workspace Diagnostics",
  },
  {
    "<leader>lf",
    function() vim.lsp.buf.format({ async = true }) end,
    desc = "Format"
  },
  {
    "<leader>li",
    "<cmd>LspInfo<cr>",
    desc = "Info"
  },
  {
    "<leader>lI",
    "<cmd>LspInstallInfo<cr>",
    desc = "Installer Info"
  },
  {
    "<leader>lj",
    function() vim.lsp.diagnostic.goto_next() end,
    desc = "Next Diagnostic",
  },
  {
    "<leader>lk",
    function() vim.lsp.diagnostic.goto_prev() end,

    desc = "Prev Diagnostic",
  },
  {
    "<leader>ll",
    function() vim.lsp.codelens.run() end,
    desc = "CodeLens Action"
  },
  {
    "<leader>lq",
    function() vim.diagnostic.setloclist() end,
    desc = "Quickfix"
  },
  {
    "<leader>lr",
    function() vim.lsp.buf.rename() end,
    desc = "Rename"
  },
  {
    "<leader>ls",
    "<cmd>Telescope lsp_document_symbols<cr>",
    desc = "Document Symbols"
  },
  {
    "<leader>lS",
    "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
    desc = "Workspace Symbols",
  },
  {
    "<leader>l@",
    "<cmd>lua function() require('lspconfig').ltex.setup({settings={ltex={language ='en-AU'}}})<cr><cmd>LspStart ltex<cr>",
    desc = "Enable LTex"
  },

  -- Group: search

  {
    "<leader>s",
    group = "Search"
  },
  {
    "<leader>sb",
    "<cmd>Telescope git_branches<cr>",
    desc = "Checkout branch"
  },
  {
    "<leader>sc",
    "<cmd>Telescope colorscheme<cr>",
    desc = "Colorscheme"
  },
  {
    "<leader>sh",
    "<cmd>Telescope help_tags<cr>",
    desc = "Find Help"
  },
  {
    "<leader>sM",
    "<cmd>Telescope man_pages<cr>",
    desc = "Man Pages"
  },
  {
    "<leader>sr",
    "<cmd>Telescope oldfiles<cr>",
    desc = "Open Recent File"
  },
  {
    "<leader>sR",
    "<cmd>Telescope registers<cr>",
    desc = "Registers"
  },
  {
    "<leader>sk",
    "<cmd>Telescope keymaps<cr>",
    desc = "Keymaps"
  },
  {
    "<leader>sC",
    "<cmd>Telescope commands<cr>",
    desc = "Commands"
  },
}

wk.add(mappings)
