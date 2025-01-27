-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
local lspconfig_defaults = require("lspconfig").util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
  "force",
  lspconfig_defaults.capabilities,
  require("cmp_nvim_lsp").default_capabilities()
)

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
      "<leader>la",
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
    vim.keymap.set("n",
      "<leader>li",
      "<cmd>LspInfo<cr>",
      { buffer = event.buf, desc = "Info" }
    )
    vim.keymap.set("n",
      "<leader>lI",
      "<cmd>LspInstallInfo<cr>",
      { buffer = event.buf, desc = "Installer Info" }
    )
    vim.keymap.set("n",
      "<leader>lj",
      "<cmd>lua vim.lsp.diagnostic.goto_next()<cr>",
      { buffer = event.buf, desc = "Next Diagnostic", }
    )
    vim.keymap.set("n",
      "<leader>lk",
      "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
      { buffer = event.buf, desc = "Prev Diagnostic", }
    )
    vim.keymap.set("n",
      "<leader>ll",
      "<cmd>lua vim.lsp.codelens.run()<cr>",
      { buffer = event.buf, desc = "CodeLens Action" }
    )
    vim.keymap.set("n",
      "<leader>lq",
      "<cmd>lua vim.diagnostic.setloclist()<cr>",
      { buffer = event.buf, desc = "Quickfix" }
    )
    vim.keymap.set("n",
      "<leader>lr",
      "<cmd>lua vim.lsp.buf.rename()<cr>",
      { buffer = event.buf, desc = "Rename" }
    )
    vim.keymap.set("n",
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
      "<cmd>lua '<cmd>lua require('lspconfig').ltex.setup({settings={ltex={language ='en-AU'}}})<cr><cmd>LspStart ltex<cr>",
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

-- The following line is recomended in the documentation for friendly-snippets.
-- Apparently this speeds up the loading time.
require("luasnip.loaders.from_vscode").lazy_load()

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "path" },
    { name = "buffer" },
  }),
  mapping = {
    ["<C-n>"] =
        cmp.mapping.select_next_item(cmp_select),
    ["<C-p>"] =
        cmp.mapping.select_prev_item(cmp_select),
    ["<C-M-n>"] =
        cmp.mapping.scroll_docs(1),
    ["<C-M-p>"] =
        cmp.mapping.scroll_docs(-1),
    ["<C-y>"] =
        cmp.mapping.confirm({ select = false }),
    ["<C-e>"] =
        cmp.mapping.abort(),

    -- friendly snippets
    ["<C-f>"] = cmp.mapping(function(fallback)
      local luasnip = require("luasnip")
      if luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    -- Jump to the previous snippet placeholder
    ["<C-b>"] = cmp.mapping(function(fallback)
      local luasnip = require("luasnip")
      if luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
      -- -- You need Neovim v0.10 to use vim.snippet
      -- vim.snippet.expand(args.body)
    end,
  },
})

-- setup mason

require("mason").setup({})
require("mason-lspconfig").setup({
  ensure_installed = { "ts_ls", "pyright", "zls", "clangd", "lua_ls", "texlab", "ltex" },
  handlers = {
    -- default setup
    function(server_name)
      require("lspconfig")[server_name].setup({})
    end,

    -- custom setups

    lua_ls = function()
      local runtime_path = vim.split(package.path, ";")
      table.insert(runtime_path, "lua/?.lua")
      table.insert(runtime_path, "lua/?/init.lua")

      local config = {
        settings = {
          Lua = {
            -- Disable telemetry
            telemetry = { enable = false },
            runtime = {
              -- Tell the language server which version of Lua you're using
              -- (most likely LuaJIT in the case of Neovim)
              version = "LuaJIT",
              path = runtime_path,
            },
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = { "vim" }
            },
            workspace = {
              checkThirdParty = false,
              library = {
                -- Make the server aware of Neovim runtime files
                vim.fn.expand("$VIMRUNTIME/lua"),
                vim.fn.stdpath("config") .. "/lua"
              }
            },
            format = {
              enable = true,
              -- here is some very opinionated formatting options
              defaultConfig = {
                indent_style = "space",
                quote_style = "double",
                -- line_space_after_if_statement = "max(2)",
                -- line_space_after_do_statement = "max(2)",
                -- line_space_after_while_statement = "max(2)",
                -- line_space_after_repeat_statement = "max(r)",
                -- line_space_after_for_statement = "max(2)",
                -- line_space_after_local_or_assign_statement = "max(2)",
                -- line_space_after_function_statement = "fixed(2)",
                -- line_space_after_expression_statement = "max(2)",
                -- line_space_after_comment = "max(2)",
              }
            },
          }
        }
      }
      require("lspconfig").lua_ls.setup(config)
    end,
    zls = function()
      require("lspconfig").zls.setup({
        settings = {
          zls = {
            enable_autofix = false
          }
        }
      })
    end,
    -- By default we do not initialise ltex
    --  it takes up way too much cpu power
    ltex = function() end
  },
})
