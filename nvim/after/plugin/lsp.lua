local status_ok, lspzero = pcall(require, "lsp-zero")
if not status_ok then
  return
end

local lsp = lspzero.preset({})

lsp.ensure_installed({
  'tsserver',
  "zls",
  "clangd",
  "lua_ls",
})

local status_okay2, lspconfig = pcall(require, "lspconfig")
if status_okay2 then
  lspconfig.lua_ls.setup(lsp.nvim_lua_ls())
end

local cmp_mappings = lsp.defaults.cmp_mappings()

-- Using tab here drives me crazy
cmp_mappings["C-j"] = cmp_mappings["<Tab>"]
cmp_mappings["C-k"] = cmp_mappings["<S-Tab>"]
cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil
-- I also don't like the use of up and down in completion
cmp_mappings['<Down>'] = nil
cmp_mappings['<Up>'] = nil

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

lsp.setup_nvim_cmp({
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

lsp.set_preferences({
  suggest_lsp_servers = false,
  sign_icons = {
    error = 'E',
    warn = 'W',
    hint = 'H',
    info = 'I'
  }
})

lsp.on_attach(function(client, bufnr)
  _ = client
  lsp.default_keymaps({ buffer = bufnr })
end)

lsp.setup()

vim.diagnostic.config({
  virtual_text = true
})
