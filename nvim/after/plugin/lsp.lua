local status_ok, lspzero = pcall(require, "lsp-zero")
if not status_ok then
  return
end

local lsp = lspzero.preset({})

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
    'tsserver',
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
