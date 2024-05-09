local status_ok, lspzero = pcall(require, "lsp-zero")
if not status_ok then
  return
end

local lsp = lspzero.preset({})

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
    "tsserver",
    "pyright",
    "zls",
    "clangd",
    "lua_ls",
    "texlab",
    "ltex",
  },
  handlers = {
    lspzero.default_setup,
    lua_ls = function()
      require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())
    end,
    zls = function()
      require("lspconfig").zls.setup({
        settings = { zls = { enable_autofix = false } }
      })
    end,
    -- By default we do not initialise ltex
    --  it takes up way too much cpu power
    ltex = function() end
  },
})

local cmp_mappings = lsp.defaults.cmp_mappings()

-- Using tab and arrow keys drives me crazy
-- disable some default bindings that drive me crazy
local loaded_okay, cmp = pcall(require, "cmp")
if loaded_okay then
  local do_nothing = cmp.mapping(function(fallback) fallback() end)
  cmp_mappings['<Tab>'] = do_nothing
  cmp_mappings['<S-Tab>'] = do_nothing
  cmp_mappings['<Down>'] = do_nothing
  cmp_mappings['<Up>'] = do_nothing
end

local kind_icons = {
  Text = "",
  Method = "m",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}

cmp.setup({
  mapping = cmp_mappings,
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        luasnip = "[Snippet]",
        buffer = "[Buffer]",
        path = "[Path]",
      })[entry.source.name]
      return vim_item
    end,
  },
  window = {
    documentation = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    },
  },
})

lsp.set_sign_icons({
  error = '✘',
  warn = '▲',
  hint = '⚑',
  info = '»'
})

lsp.on_attach(function(client, bufnr)
  _ = client
  lsp.default_keymaps({ buffer = bufnr })
end)

lsp.setup()



local function on_attach(_, bufnr)
  local function cmd(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { noremap = true, buffer = true })
  end

  -- Autocomplete using the Lean language server
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- gd in normal mode will jump to definition
  cmd('n', 'gd', vim.lsp.buf.definition)
  -- K in normal mode will show the definition of what's under the cursor
  cmd('n', 'K', vim.lsp.buf.hover)

  -- <leader>n will jump to the next Lean line with a diagnostic message on it
  -- <leader>N will jump backwards
  cmd('n', '<leader>n', function() vim.diagnostic.goto_next { popup_opts = { show_header = false } } end)
  cmd('n', '<leader>N', function() vim.diagnostic.goto_prev { popup_opts = { show_header = false } } end)

  -- <leader>K will show all diagnostics for the current line in a popup window
  cmd('n', '<leader>K', function() vim.diagnostic.open_float(0, { scope = "line", header = false, focus = false }) end)

  -- <leader>q will load all errors in the current lean file into the location list
  -- (and then will open the location list)
  -- see :h location-list if you don't generally use it in other vim contexts
  cmd('n', '<leader>q', vim.diagnostic.setloclist)
end

local status_oklean, lean = pcall(require, "lean")
if not status_oklean then
  return
end
-- Enable lean.nvim, and enable abbreviations and mappings
lean.setup {
  abbreviations = { builtin = true },
  lsp = { on_attach = on_attach },
  lsp3 = { on_attach = on_attach },
  mappings = true,
}
