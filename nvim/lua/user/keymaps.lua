local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Cancel all jumpable
vim.keymap.set({ "i", "s", "n" }, "<C-E>", function()
  local luasnip = require("luasnip")
  while luasnip.jumpable() do
    luasnip.unlink_current()
  end
end, opts)

-- Normal --
-- redefine the arrow keys to make things easier to navigate
keymap("n", "<Up>", "gk", opts)
keymap("n", "<Down>", "gj", opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -1<CR>", opts)
keymap("n", "<C-Down>", ":resize +1<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -1<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +1<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Navigate tabs
--  I added the Alt key here since <Tab> is one of the default
--  keybindings in NVimTree
keymap("n", "<M-Tab>", ":tabn<CR>", opts)
keymap("n", "<M-S-Tab>", ":tabp<CR>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- toggle comments
keymap(
  "x",
  "<C-/>",
  "gc",
  { desc = "Comment toggle linewise" }
)
keymap(
  "n",
  "<C-/>",
  "gcc",
  { desc = "Comment toggle blockwise" }
)

-- some additional maps for convienece

keymap("n",
  "<leader>H",
  "<cmd>cd %:p:h<cr>",
  { desc = "CD Here" }
)
keymap("n",
  "<leader>a",
  "<cmd>Alpha<cr>",
  { desc = "Alpha" }
)
keymap("n",
  "<leader>b",
  '<cmd>lua require("telescope.builtin").buffers(require("telescope.themes").get_dropdown({ previewer = false }))<cr>',
  { desc = "Buffers" }
)
keymap("n",
  "<leader>e",
  "<cmd>NvimTreeToggle<cr>",
  { desc = "Explorer" }
)
keymap("n",
  "<leader>c",
  "<cmd>Bdelete<CR>",
  { desc = "Close Buffer" }
)
keymap("n",
  "<leader>h",
  "<cmd>nohlsearch<CR>",
  { desc = "No Highlight" }
)
keymap("n",
  "<leader>f",
  '<cmd>lua require("telescope.builtin").find_files(require("telescope.themes").get_dropdown({ previewer = false }))<cr>',
  { desc = "Find files" }
)
keymap("n",
  "<leader>F",
  "<cmd>Telescope live_grep theme=ivy<cr>",
  { desc = "Find Text" }
)
keymap("n",
  "<leader>u",
  "<cmd>UndotreeToggle<cr>",
  { desc = "Toggle Undotree" }
)

-- group project
keymap("n", "<leader>p", "<nop>", { desc = "Project" })

keymap("n",
  "<leader>pa",
  "<cmd>CdProjectAdd<cr>",
  { desc = "Add project" }
)
keymap("n",
  "<leader>pd",
  "<cmd>CdProjectDelete<cr>",
  { desc = "Delete project" }
)
keymap("n",
  "<leader>ps",
  "<cmd>CdProject<cr>",
  { desc = "Search project" }
)

--GROUP Search

keymap("n", "<leader>s", "<nop>", { desc = "Search" })

keymap("n",
  "<leader>sb",
  "<cmd>Telescope git_branches<cr>",
  { desc = "Checkout branch" }
)
keymap("n",
  "<leader>sc",
  "<cmd>Telescope colorscheme<cr>",
  { desc = "Colorscheme" }
)
keymap("n",
  "<leader>sh",
  "<cmd>Telescope help_tags<cr>",
  { desc = "Find Help" }
)
keymap("n",
  "<leader>sm",
  "<cmd>Telescope marks<cr>",
  { desc = "Marks" }
)
keymap("n",
  "<leader>sM",
  "<cmd>Telescope man_pages<cr>",
  { desc = "Man Pages" }
)
keymap("n",
  "<leader>sr",
  "<cmd>Telescope oldfiles<cr>",
  { desc = "Open Recent File" }
)
keymap("n",
  "<leader>sR",
  "<cmd>Telescope registers<cr>",
  { desc = "Registers" }
)
keymap("n",
  "<leader>sk",
  "<cmd>Telescope keymaps<cr>",
  { desc = "Keymaps" }
)
keymap("n",
  "<leader>sC",
  "<cmd>Telescope commands<cr>",
  { desc = "Commands" }
)
