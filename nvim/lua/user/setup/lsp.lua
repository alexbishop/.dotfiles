require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = {
    "ts_ls",
    "pyright",
    "zls",
    "clangd",
    "lua_ls",
    "texlab",
    "ltex",
  },
  automatic_enable = {
    exclude = { "ltex" },
  },
})

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = {
          'vim',
          'require'
        },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

vim.lsp.config('zls', {
  settings = {
    zls = {
      enable_autofix = false
    }
  }
})

require("luasnip").config.set_config({
  history = true,
  updateevents = "TextChanged,TextChangedI",
})

-- setup cmp for autopairs
-- require("nvim-autopairs").setup({
--   fast_wrap = {},
--   disable_filetype = { "TelescopePrompt", "vim" },
-- })
-- local cmp_autopairs = require "nvim-autopairs.completion.cmp"
-- require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())

-- misc stuff

-- vscode format
require("luasnip.loaders.from_vscode").lazy_load { exclude = vim.g.vscode_snippets_exclude or {} }
require("luasnip.loaders.from_vscode").lazy_load { paths = vim.g.vscode_snippets_path or "" }

-- snipmate format
require("luasnip.loaders.from_snipmate").load()
require("luasnip.loaders.from_snipmate").lazy_load { paths = vim.g.snipmate_snippets_path or "" }

-- lua format
require("luasnip.loaders.from_lua").load()
require("luasnip.loaders.from_lua").lazy_load { paths = vim.g.lua_snippets_path or "" }

require("blink.cmp").setup{
  keymap = {
    preset = "none",

    ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
    ['<C-e>'] = { 'hide' },
    ['<C-y>'] = { 'select_and_accept' },

    ['<C-S-n>'] = { 'select_prev', 'fallback' },
    ['<C-S-p>'] = { 'select_next', 'fallback' },
    ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
    ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },

    ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

    ['<C-Tab>'] = { 'snippet_forward', 'fallback' },
    ['<C-S-Tab>'] = { 'snippet_backward', 'fallback' },

    ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
  }
}


--
-- local cmp = require "cmp"
--
-- cmp.setup({
--   completion = { completeopt = "menu,menuone" },
--
--   snippet = {
--     expand = function(args)
--       require("luasnip").lsp_expand(args.body)
--     end,
--   },
--
--   mapping = {
--     ["<C-n>"] =
--         cmp.mapping.select_next_item(),
--     ["<C-p>"] =
--         cmp.mapping.select_prev_item(),
--     ["<C-M-n>"] =
--         cmp.mapping.scroll_docs(1),
--     ["<C-M-p>"] =
--         cmp.mapping.scroll_docs(-1),
--     ["<C-y>"] =
--         cmp.mapping.confirm({ select = false }),
--     ["<C-e>"] =
--         cmp.mapping.abort(),
--
--     -- friendly snippets
--     ["<C-f>"] = cmp.mapping(function(fallback)
--       local luasnip = require("luasnip")
--       if luasnip.expand_or_locally_jumpable() then
--         luasnip.expand_or_jump()
--       else
--         fallback()
--       end
--     end, { "i", "s" }),
--     -- Jump to the previous snippet placeholder
--     ["<C-b>"] = cmp.mapping(function(fallback)
--       local luasnip = require("luasnip")
--       if luasnip.locally_jumpable(-1) then
--         luasnip.jump(-1)
--       else
--         fallback()
--       end
--     end, { "i", "s" }),
--   },
--
--   sources = {
--     { name = "nvim_lsp" },
--     { name = "luasnip" },
--     { name = "buffer" },
--     { name = "nvim_lua" },
--     { name = "async_path" },
--   },
-- })

--
--
--
--
-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
-- local lspconfig_defaults = require("lspconfig").util.default_config
-- lspconfig_defaults.capabilities = vim.tbl_deep_extend(
--   "force",
--   lspconfig_defaults.capabilities,
--   require("cmp_nvim_lsp").default_capabilities()
-- )

-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions",
  callback = function(event)
    vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", {
      buffer = event.buf,
      desc = "Hover documentation",
    })
    vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", {
      buffer = event.buf,
      desc = "Go to definition",
    })
    vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", {
      buffer = event.buf,
      desc = "Go to declaration",
    })
    vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", {
      buffer = event.buf,
      desc = "Go to implementation",
    })
    vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", {
      buffer = event.buf,
      desc = "Go to type definition",
    })
    vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", {
      buffer = event.buf, desc = "Go to reference",
    })
    vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", {
      buffer = event.buf,
      desc = "Show function signature",
    })
    vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", {
      buffer = event.buf, desc = "Rename symbol",
    })
    vim.keymap.set("n", "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", {
      buffer = event.buf,
      desc = "Format file",
    })
    vim.keymap.set("x", "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", {
      buffer = event.buf,
      desc = "Format selection",
    })
    vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", {
      buffer = event.buf,
      desc = "Execute code action",
    })

    --------------------------------------------
    --- LSP
    --------------------------------------------

    vim.keymap.set("n",
      "<leader>l",
      "<nop>",
      { buffer = event.buf, desc = "LSP" }
    )

    vim.keymap.set("n",
      "<leader>l<C-a>",
      "<cmd>lua vim.lsp.buf.code_action()<cr>",
      { buffer = event.buf, desc = "Code Action" }
    )
    vim.keymap.set("n",
      "<leader>ld",
      "<cmd>Telescope diagnostics bufnr=0<cr>",
      { buffer = event.buf, desc = "Document Diagnostics", }
    )
    vim.keymap.set("n",
      "<leader>lw",
      "<cmd>Telescope diagnostics<cr>",
      { buffer = event.buf, desc = "Workspace Diagnostics", }
    )
    vim.keymap.set("n",
      "<leader>lf",
      "<cmd>lua vim.lsp.buf.format({ async = true })<cr>",
      { buffer = event.buf, desc = "Format" }
    )
    -- -- I don't really use the following teo at all
    -- vim.keymap.set("n",--
    --   "<leader>li",
    --   "<cmd>LspInfo<cr>",
    --   { buffer = event.buf, desc = "Info" }
    -- )
    -- vim.keymap.set("n",--
    --   "<leader>lI",
    --   "<cmd>LspInstallInfo<cr>",
    --   { buffer = event.buf, desc = "Installer Info" }
    -- )
    vim.keymap.set("n",
      "<leader>l<C-j>",
      "<cmd>lua vim.lsp.diagnostic.goto_next()<cr>",
      { buffer = event.buf, desc = "Next Diagnostic", }
    )
    vim.keymap.set("n",
      "<leader>l<C-k>",
      "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
      { buffer = event.buf, desc = "Prev Diagnostic", }
    )
    vim.keymap.set("n",
      "<leader>l<C-l>",
      "<cmd>lua vim.lsp.codelens.run()<cr>",
      { buffer = event.buf, desc = "CodeLens Action" }
    )
    vim.keymap.set("n",
      "<leader>lQ",
      "<cmd>lua vim.diagnostic.setloclist()<cr>",
      { buffer = event.buf, desc = "Quickfix" }
    )
    vim.keymap.set("n",
      "<leader>lr",
      "<cmd>lua vim.lsp.buf.rename()<cr>",
      { buffer = event.buf, desc = "Rename" }
    )
    vim.keymap.set("n", -- overrides vimtex toggle main
      "<leader>ls",
      "<cmd>Telescope lsp_document_symbols<cr>",
      { buffer = event.buf, desc = "Document Symbols" }
    )
    vim.keymap.set("n",
      "<leader>lS",
      "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
      { buffer = event.buf, desc = "Workspace Symbols", }
    )
    vim.keymap.set("n",
      "<leader>l@",
      "<cmd>lua require('user.setup.lsp').ltex()<cr>",
      { buffer = event.buf, desc = "Enable LTex" }
    )

    --------------------------------------------
    --- Tree Climber
    --------------------------------------------

    vim.keymap.set({ "n", "v", "o" },
      "gt",
      "<nop>",
      { buffer = event.buf, desc = "Tree climber" }
    )

    vim.keymap.set({ "n", "v", "o" },
      "gth",
      '<cmd>lua require("tree-climber").goto_parent<cr>',
      { buffer = event.buf, desc = "Go to parent", }
    )
    vim.keymap.set({ "n", "v", "o" },
      "gtl",
      '<cmd>lua require("tree-climber").goto_child<cr>',
      { buffer = event.buf, desc = "Go to child", }
    )
    vim.keymap.set({ "n", "v", "o" },
      "gtj",
      '<cmd>lua require("tree-climber").goto_next<cr>',
      { buffer = event.buf, desc = "Go to next", }
    )
    vim.keymap.set({ "n", "v", "o" },
      "gtk",
      '<cmd>lua require("tree-climber").goto_prev<cr>',
      { buffer = event.buf, desc = "Go to previous", }
    )
    vim.keymap.set({ "n" },
      "gt<c-k>",
      '<cmd>lua require("tree-climber").swap_prev<cr>',
      { buffer = event.buf, desc = "Swap with previous", }
    )
    vim.keymap.set({ "n" },
      "gt<c-j>",
      '<cmd>lua require("tree-climber").goto_next<cr>',
      { buffer = event.buf, desc = "Swap with next", }
    )
    vim.keymap.set({ "n" },
      "gt<c-h>",
      '<cmd>lua require("tree-climber").highlight_node<cr>',
      { buffer = event.buf, desc = "Highlight node", }
    )
  end,
})

local M = {}

M.ltex = function()
  local pickers = require "telescope.pickers"
  local finders = require "telescope.finders"
  local conf = require("telescope.config").values
  local actions = require "telescope.actions"
  local action_state = require "telescope.actions.state"

  local opts = require("telescope.themes").get_dropdown()
  pickers.new(opts, {
    prompt_title = "languages",
    finder = finders.new_table {
      results = {
        -- these are the 3 language variants I mostly use, so I'll make them first
        "en-AU",
        "en-US",
        "en-GB",
        --
        "en",
        "en-CA",
        "en-NZ",
        "en-ZA",
        --
        "auto",
        "ar",
        "ast-ES",
        "be-BY",
        "br-FR",
        "ca-ES",
        "ca-ES-valencia",
        "da-DK",
        "de",
        "de-AT",
        "de-CH",
        "de-DE",
        "de-DE-x-simple-language",
        "el-GR",
        -- "en",
        -- "en-AU",
        -- "en-CA",
        -- "en-GB",
        -- "en-NZ",
        -- "en-US",
        -- "en-ZA",
        "eo",
        "es",
        "es-AR",
        "fa",
        "fr",
        "ga-IE",
        "gl-ES",
        "it",
        "ja-JP",
        "km-KH",
        "nl",
        "nl-BE",
        "pl-PL",
        "pt",
        "pt-AO",
        "pt-BR",
        "pt-MZ",
        "pt-PT",
        "ro-RO",
        "ru-RU",
        "sk-SK",
        "sl-SI",
        "sv",
        "ta-IN",
        "tl-PH",
        "uk-UA",
        "zh-CN",
      }
    },
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        vim.lsp.config("ltex", { settings = { ltex = { language = selection[1] } } })
        vim.lsp.enable("ltex")
      end)
      return true
    end,
  }):find()
end

return M
