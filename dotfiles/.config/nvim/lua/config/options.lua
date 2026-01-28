-- Core Neovim options (VS Code-like behavior)
local opt = vim.opt

-- Line numbers (like VS Code)
opt.number = true
opt.relativenumber = true

-- Tabs & indentation (VS Code defaults)
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- Line wrapping
opt.wrap = false

-- Search settings
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Cursor line (like VS Code highlighting)
opt.cursorline = true

-- Appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- Backspace behavior
opt.backspace = "indent,eol,start"

-- Clipboard (use system clipboard like VS Code)
opt.clipboard = "unnamedplus"

-- Split windows (VS Code-like)
opt.splitright = true
opt.splitbelow = true

-- Consider - as part of word
opt.iskeyword:append("-")

-- Mouse support (like VS Code)
opt.mouse = "a"

-- Disable swap files
opt.swapfile = false
opt.backup = false

-- Persistent undo
opt.undofile = true
opt.undolevels = 10000

-- Update time for faster response
opt.updatetime = 250
opt.timeoutlen = 300

-- Better completion experience
opt.completeopt = "menuone,noselect"

-- Scroll offset (keep context visible)
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Show invisible characters (like VS Code)
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Command line height
opt.cmdheight = 1

-- Pop up menu height
opt.pumheight = 10

-- Hide mode (shown in status line instead)
opt.showmode = false

-- Enable break indent
opt.breakindent = true

-- Save undo history
opt.undofile = true

-- Decrease mapped sequence wait time (faster which-key popup)
opt.timeoutlen = 300

-- Configure how new splits should be opened
opt.splitright = true
opt.splitbelow = true

-- Preview substitutions live
opt.inccommand = "split"

-- Minimal number of screen lines to keep above and below the cursor
opt.scrolloff = 10

-- Set highlight on search, but clear on pressing <Esc> in normal mode
opt.hlsearch = true
