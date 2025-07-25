local configs = require("nvim-treesitter.configs")

configs.setup({
  --ensure_installed = "all",
  -- there seems to be a problem with teal
  -- ignore_install = { "teal", "scfg", "idlang" },
  highlight = {
    enable = true,
    disable = { "css" },
  },
  autopairs = {
    enable = true,
  },
  indent = {
    enable = true,
    disable = { "python" }
  },
})
