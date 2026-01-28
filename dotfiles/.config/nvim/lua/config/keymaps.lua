-- Keymaps for VS Code-like experience
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Clear search highlight with Escape (like VS Code)
keymap("n", "<Esc>", "<cmd>nohlsearch<CR>", opts)

-- Better window navigation (Ctrl + hjkl)
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize windows with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Buffer navigation (like VS Code tabs)
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })
keymap("n", "<leader>bD", ":bdelete!<CR>", { desc = "Force delete buffer" })

-- Save file (Ctrl+S like VS Code)
keymap("n", "<C-s>", ":w<CR>", opts)
keymap("i", "<C-s>", "<Esc>:w<CR>a", opts)

-- Select all (Ctrl+A like VS Code)
keymap("n", "<C-a>", "gg<S-v>G", opts)

-- Move lines up/down (Alt+Up/Down like VS Code)
keymap("n", "<A-j>", ":m .+1<CR>==", opts)
keymap("n", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- Duplicate line (like VS Code Shift+Alt+Down)
keymap("n", "<S-A-j>", "yyp", opts)
keymap("n", "<S-A-k>", "yyP", opts)

-- Stay in visual mode when indenting
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Don't yank on paste in visual mode
keymap("v", "p", '"_dP', opts)

-- Quick quit
keymap("n", "<leader>qq", "<cmd>qa<CR>", { desc = "Quit all" })

-- Better up/down with wrapped lines
keymap({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Add empty lines (like VS Code Ctrl+Enter)
keymap("n", "<leader>o", "o<Esc>", { desc = "Add line below" })
keymap("n", "<leader>O", "O<Esc>", { desc = "Add line above" })

-- Center cursor after scrolling
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- Undo (Ctrl+Z like VS Code)
keymap("n", "<C-z>", "u", opts)
keymap("i", "<C-z>", "<Esc>ui", opts)

-- Redo (Ctrl+Shift+Z or Ctrl+Y like VS Code)
keymap("n", "<C-y>", "<C-r>", opts)
keymap("n", "<C-S-z>", "<C-r>", opts)

-- Diagnostic keymaps
keymap("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
keymap("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
keymap("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic" })
keymap("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostic list" })

-- Terminal mode escape
keymap("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
