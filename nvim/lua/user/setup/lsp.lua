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
        function()
          if cmp.visible() then
            cmp.select_next_item()
          else
            cmp.complete()
          end
        end,
    ["<C-M-p>"] =
        function()
          if cmp.visible() then
            cmp.select_prev_item()
          else
            cmp.complete()
          end
        end,
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
    require("lsp-zero").default_setup,
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
            -- format =
            -- {
            --   enable = true,
            --   -- here is some very opinionated formatting options
            --   defaultConfig =
            --   {
            --     indent_style = "space",
            --     quote_style = "double",
            --     line_space_after_if_statement = "max(2)",
            --     line_space_after_do_statement = "max(2)",
            --     line_space_after_while_statement = "max(2)",
            --     line_space_after_repeat_statement = "max(r)",
            --     line_space_after_for_statement = "max(2)",
            --     line_space_after_local_or_assign_statement = "max(2)",
            --     line_space_after_function_statement = "fixed(2)",
            --     line_space_after_expression_statement = "max(2)",
            --     line_space_after_comment = "max(2)",
            --   }
            -- },
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
