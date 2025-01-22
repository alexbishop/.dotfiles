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
    "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
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
    "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
    desc = "Find files",
  },
  {
    "<leader>F",
    "<cmd>Telescope live_grep theme=ivy<cr>",
    desc = "Find Text"
  },
  {
    "<leader>P",
    "<cmd>lua require('telescope').extensions.projects.projects()<cr>",
    desc = "Projects"
  },


  {
    "<leader>u",
    "<cmd>UndotreeToggle<cr>",
    desc = "Toggle Undotree"
  },

  -- Group: LSP

  { "l", group = "LSP" },
  {
    "<leader>la",
    "<cmd>lua vim.lsp.buf.code_action()<cr>",
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
    "<cmd>lua vim.lsp.buf.format{async=true}<cr>",
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
    "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
    desc = "Next Diagnostic",
  },
  {
    "<leader>lk",
    "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",

    desc = "Prev Diagnostic",
  },
  {
    "<leader>ll",
    "<cmd>lua vim.lsp.codelens.run()<cr>",
    desc = "CodeLens Action"
  },
  {
    "<leader>lq",
    "<cmd>lua vim.diagnostic.setloclist()<cr>",
    desc = "Quickfix"
  },
  {
    "<leader>lr",
    "<cmd>lua vim.lsp.buf.rename()<cr>",
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
    "<cmd>lua require('lspconfig').ltex.setup({settings={ltex={language ='en-AU'}}})<cr><cmd>LspStart ltex<cr>",
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
