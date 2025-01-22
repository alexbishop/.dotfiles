local configs = require("nvim-treesitter.configs")

configs.setup({
  ensure_installed = "all",
  ignore_install = {
    -- there seems to be a problem with this one
    "teal",
  },
  highlight = {
    enable = true,       -- false will disable the whole extension
    disable = { "css" }, -- list of language that will be disabled
  },
  autopairs = {
    enable = true,
  },
  indent = { enable = true, disable = { "python", "css" } },
})
