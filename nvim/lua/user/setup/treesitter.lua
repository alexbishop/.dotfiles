require("nvim-treesitter.configs").setup({
  ensure_installed = { "lua", "c", "cpp", "zig", "html", "css", "python" },
  sync_install = false,
  auto_install = true,
  ignore_install = {},
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
